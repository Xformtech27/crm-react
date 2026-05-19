import { useEffect, useMemo, useState } from "react";
import Icon from "../../components/Icon";
import AppConfirmModal from "../../components/ui/AppConfirmModal";
import OpportunityDealModal from "../../components/pipeline/OpportunityDealModal";
import { useOpportunity } from "../../hooks/useOpportunity";
import {
  ACTIVE_PIPELINE_STAGES,
  STAGE_ACCENT_CLASS,
  STAGE_BADGE_CLASS,
  amountOf,
  dealAccount,
  dealCloseDate,
  dealName,
  dealOwner,
  formatDate,
  formatMoney,
  groupDealsByStage,
  matchesDeal,
  payloadFromDeal,
} from "../../utils/opportunityPipeline";

export default function PipelinePage() {
  const opportunityApi = useOpportunity();
  const [deals, setDeals] = useState([]);
  const [query, setQuery] = useState("");
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingDeal, setEditingDeal] = useState(null);
  const [initialStage, setInitialStage] = useState("New");
  const [deleteDeal, setDeleteDeal] = useState(null);
  const [toast, setToast] = useState(null);

  async function loadDeals() {
    setLoading(true);
    try {
      const data = await opportunityApi.getAll();
      setDeals(Array.isArray(data) ? data : []);
    } catch {
      setToast({ type: "error", text: "Unable to load pipeline deals." });
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadDeals();
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  useEffect(() => {
    if (!toast) return undefined;
    const timer = window.setTimeout(() => setToast(null), 2600);
    return () => window.clearTimeout(timer);
  }, [toast]);

  const filteredDeals = useMemo(() => {
    const term = query.trim();
    if (!term) return deals;
    return deals.filter((deal) => matchesDeal(deal, term));
  }, [deals, query]);

  const stages = useMemo(
    () => groupDealsByStage(filteredDeals, ACTIVE_PIPELINE_STAGES),
    [filteredDeals]
  );

  const metrics = useMemo(() => {
    const totalPipeline = filteredDeals.reduce((sum, deal) => sum + amountOf(deal), 0);
    const activeDeals = filteredDeals.filter((deal) => !["Won", "Lost"].includes(deal.oppStatus)).length;
    const won = filteredDeals.filter((deal) => deal.oppStatus === "Won").length;
    const lost = filteredDeals.filter((deal) => deal.oppStatus === "Lost").length;
    const forecast = filteredDeals
      .filter((deal) => !["Won", "Lost"].includes(deal.oppStatus))
      .reduce((sum, deal) => sum + amountOf(deal), 0);

    return {
      totalPipeline,
      activeDeals,
      winRate: won + lost ? Math.round((won / (won + lost)) * 100) : 0,
      forecast,
    };
  }, [filteredDeals]);

  function openCreate(stage = "New") {
    setEditingDeal(null);
    setInitialStage(stage);
    setModalOpen(true);
  }

  function openEdit(deal) {
    setEditingDeal(deal);
    setInitialStage(deal.oppStatus || "New");
    setModalOpen(true);
  }

  async function saveDeal(payload) {
    setSaving(true);
    try {
      if (editingDeal) {
        const updated = await opportunityApi.update(editingDeal.oppId, payload);
        setDeals((current) => current.map((deal) => deal.oppId === editingDeal.oppId ? updated : deal));
        setToast({ type: "success", text: "Deal updated." });
      } else {
        const created = await opportunityApi.create(payload);
        setDeals((current) => [created, ...current]);
        setToast({ type: "success", text: "Deal created." });
      }
      setModalOpen(false);
    } catch {
      setToast({ type: "error", text: "Unable to save deal." });
    } finally {
      setSaving(false);
    }
  }

  async function moveDeal(deal, nextStage) {
    if (deal.oppStatus === nextStage) return;
    setSaving(true);
    try {
      const updated = await opportunityApi.update(deal.oppId, payloadFromDeal(deal, { oppStatus: nextStage }));
      setDeals((current) => current.map((item) => item.oppId === deal.oppId ? updated : item));
      setToast({ type: "success", text: `Moved to ${nextStage}.` });
    } catch {
      setToast({ type: "error", text: "Unable to move deal." });
    } finally {
      setSaving(false);
    }
  }

  async function confirmDelete() {
    if (!deleteDeal) return;
    setSaving(true);
    try {
      await opportunityApi.remove(deleteDeal.oppId);
      setDeals((current) => current.filter((deal) => deal.oppId !== deleteDeal.oppId));
      setDeleteDeal(null);
      setToast({ type: "success", text: "Deal deleted." });
    } catch {
      setToast({ type: "error", text: "Unable to delete deal." });
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="min-h-full space-y-5">
      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">CRM Pipeline</h1>
          <p className="mt-1 text-sm text-slate-500">Track opportunities and manage your sales workflow.</p>
        </div>

        <div className="flex flex-col gap-2 sm:flex-row">
          <div className="relative">
            <Icon name="mdi:magnify" className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
            <input
              type="search"
              value={query}
              onChange={(event) => setQuery(event.target.value)}
              placeholder="Search deals..."
              className="h-10 w-full rounded-xl border border-slate-200 bg-white pl-9 pr-3 text-sm shadow-sm outline-none transition focus:border-slate-400 focus:ring-2 focus:ring-slate-200 sm:w-72"
            />
          </div>
          <button
            onClick={() => openCreate("New")}
            className="inline-flex h-10 items-center justify-center gap-2 rounded-xl bg-slate-900 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-slate-800"
          >
            <Icon name="mdi:plus" className="h-4 w-4" />
            Add Deal
          </button>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-4">
        {[
          { label: "Total Pipeline", value: formatMoney(metrics.totalPipeline, true), icon: "mdi:chart-timeline-variant" },
          { label: "Active Deals", value: metrics.activeDeals, icon: "mdi:briefcase-outline" },
          { label: "Win Rate", value: `${metrics.winRate}%`, icon: "mdi:trophy-outline" },
          { label: "Revenue Forecast", value: formatMoney(metrics.forecast, true), icon: "mdi:cash-clock" },
        ].map((metric) => (
          <div key={metric.label} className="rounded-xl border border-slate-100 bg-white p-5 shadow-sm">
            <div className="flex items-center justify-between">
              <p className="text-sm font-medium text-slate-500">{metric.label}</p>
              <Icon name={metric.icon} className="h-5 w-5 text-slate-400" />
            </div>
            <h2 className="mt-2 text-2xl font-bold text-slate-900">{metric.value}</h2>
          </div>
        ))}
      </div>

      <div className="overflow-x-auto pb-2">
        <div className="flex min-w-[1180px] gap-4">
          {stages.map((stage) => (
            <section key={stage.key} className="flex w-72 shrink-0 flex-col rounded-xl border border-slate-100 bg-white shadow-sm">
              <div className="border-b border-slate-100 p-4">
                <div className={`mb-3 h-1.5 rounded-full ${STAGE_ACCENT_CLASS[stage.key]}`} />
                <div className="flex items-start justify-between gap-3">
                  <div className="min-w-0">
                    <h3 className="truncate text-base font-semibold text-slate-900">{stage.title}</h3>
                    <p className="mt-1 text-sm font-semibold text-slate-500">{formatMoney(stage.value, true)}</p>
                  </div>
                  <span className={`rounded-full border px-2.5 py-1 text-xs font-semibold ${STAGE_BADGE_CLASS[stage.key]}`}>
                    {stage.deals.length} Deals
                  </span>
                </div>
              </div>

              <div className="flex-1 space-y-3 p-3">
                {loading ? (
                  <div className="space-y-3">
                    <div className="skeleton h-28 rounded-xl" />
                    <div className="skeleton h-28 rounded-xl" />
                  </div>
                ) : stage.deals.length ? (
                  stage.deals.map((deal) => (
                    <article
                      key={deal.oppId}
                      className="rounded-xl border border-slate-200 bg-slate-50 p-4 transition hover:-translate-y-0.5 hover:border-slate-300 hover:bg-white hover:shadow-md"
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div className="min-w-0">
                          <h4 className="truncate font-semibold text-slate-900">{dealName(deal)}</h4>
                          <p className="mt-1 truncate text-sm text-slate-500">{dealAccount(deal)}</p>
                        </div>
                        <span className="shrink-0 text-sm font-bold text-slate-800">{formatMoney(amountOf(deal), true)}</span>
                      </div>

                      <div className="mt-4 flex items-center justify-between text-xs text-slate-500">
                        <span className="truncate">Owner: {dealOwner(deal)}</span>
                        <span className="shrink-0">{formatDate(dealCloseDate(deal))}</span>
                      </div>

                      <div className="mt-3 flex items-center gap-2">
                        <select
                          value={deal.oppStatus || "New"}
                          onChange={(event) => moveDeal(deal, event.target.value)}
                          className="min-w-0 flex-1 rounded-lg border border-slate-200 bg-white px-2 py-1.5 text-xs font-semibold text-slate-700 outline-none focus:border-blue-300"
                        >
                          {ACTIVE_PIPELINE_STAGES.map((item) => (
                            <option key={item.key} value={item.key}>{item.title}</option>
                          ))}
                        </select>
                        <button
                          onClick={() => openEdit(deal)}
                          className="rounded-lg bg-white px-2.5 py-1.5 text-xs font-semibold text-slate-700 shadow-sm hover:bg-slate-100"
                        >
                          View
                        </button>
                        <button
                          onClick={() => setDeleteDeal(deal)}
                          className="rounded-lg bg-white p-1.5 text-slate-400 shadow-sm hover:bg-rose-50 hover:text-rose-600"
                          title="Delete deal"
                        >
                          <Icon name="mdi:trash-can-outline" className="h-4 w-4" />
                        </button>
                      </div>
                    </article>
                  ))
                ) : (
                  <div className="rounded-xl border border-dashed border-slate-200 p-5 text-center">
                    <Icon name="mdi:briefcase-plus-outline" className="mx-auto h-8 w-8 text-slate-300" />
                    <p className="mt-2 text-sm font-semibold text-slate-600">No deals</p>
                    <button
                      onClick={() => openCreate(stage.key)}
                      className="mt-3 rounded-lg bg-slate-900 px-3 py-1.5 text-xs font-semibold text-white hover:bg-slate-800"
                    >
                      Add here
                    </button>
                  </div>
                )}
              </div>
            </section>
          ))}
        </div>
      </div>

      <OpportunityDealModal
        open={modalOpen}
        deal={editingDeal}
        initialStage={initialStage}
        saving={saving}
        onClose={() => setModalOpen(false)}
        onSubmit={saveDeal}
      />

      <AppConfirmModal
        open={Boolean(deleteDeal)}
        title="Delete Deal"
        message={`Delete ${deleteDeal ? dealName(deleteDeal) : "this deal"} permanently?`}
        confirmLabel="Delete"
        loading={saving}
        onCancel={() => setDeleteDeal(null)}
        onConfirm={confirmDelete}
      />

      {toast && (
        <div className={`fixed bottom-6 right-6 z-[70] rounded-lg px-4 py-3 text-sm font-semibold text-white shadow-lg ${toast.type === "success" ? "bg-emerald-500" : "bg-rose-500"}`}>
          {toast.text}
        </div>
      )}
    </div>
  );
}
