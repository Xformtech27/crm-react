export const PIPELINE_STAGES = [
  { key: "New", title: "New Leads", color: "blue", probability: 15 },
  { key: "Qualified", title: "Qualified", color: "indigo", probability: 35 },
  { key: "Proposal", title: "Proposal Sent", color: "purple", probability: 55 },
  { key: "Negotiation", title: "Negotiation", color: "amber", probability: 75 },
  { key: "Won", title: "Closed Won", color: "emerald", probability: 100 },
  { key: "Lost", title: "Closed Lost", color: "rose", probability: 0 },
  { key: "On Hold", title: "On Hold", color: "slate", probability: 20 },
];

export const ACTIVE_PIPELINE_STAGES = PIPELINE_STAGES.filter((stage) =>
  !["Lost", "On Hold"].includes(stage.key)
);

export const STAGE_OPTIONS = PIPELINE_STAGES.map((stage) => stage.key);

export const STAGE_BADGE_CLASS = {
  New: "bg-blue-50 text-blue-700 border-blue-100",
  Qualified: "bg-indigo-50 text-indigo-700 border-indigo-100",
  Proposal: "bg-purple-50 text-purple-700 border-purple-100",
  Negotiation: "bg-amber-50 text-amber-700 border-amber-100",
  Won: "bg-emerald-50 text-emerald-700 border-emerald-100",
  Lost: "bg-rose-50 text-rose-700 border-rose-100",
  "On Hold": "bg-slate-100 text-slate-700 border-slate-200",
};

export const STAGE_ACCENT_CLASS = {
  New: "bg-blue-500",
  Qualified: "bg-indigo-500",
  Proposal: "bg-purple-500",
  Negotiation: "bg-amber-500",
  Won: "bg-emerald-500",
  Lost: "bg-rose-500",
  "On Hold": "bg-slate-500",
};

export function amountOf(deal) {
  return Number(deal?.oppAmount || 0);
}

export function formatMoney(value, compact = false) {
  const amount = Number(value || 0);
  if (compact && amount >= 10000000) return `Rs ${(amount / 10000000).toFixed(1)}Cr`;
  if (compact && amount >= 100000) return `Rs ${(amount / 100000).toFixed(1)}L`;
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 0,
  }).format(amount);
}

export function dealName(deal) {
  return deal?.oppName || "Untitled deal";
}

export function dealAccount(deal) {
  return deal?.oppTitle || "No account";
}

export function dealOwner(deal) {
  return deal?.owner || deal?.oppOwner || (deal?.userIdFk ? `User ${deal.userIdFk}` : "Unassigned");
}

export function dealCloseDate(deal) {
  return deal?.oppActualCloseDate || deal?.oppForcastCloseDate || "";
}

export function formatDate(value) {
  if (!value) return "No close date";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "No close date";
  return date.toLocaleDateString("en-IN", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
}

export function matchesDeal(deal, query) {
  const text = [
    deal?.oppName,
    deal?.oppTitle,
    deal?.oppStatus,
    deal?.oppDescription,
    dealOwner(deal),
  ].join(" ").toLowerCase();
  return text.includes(query.trim().toLowerCase());
}

export function groupDealsByStage(deals, stages = ACTIVE_PIPELINE_STAGES) {
  return stages.map((stage) => {
    const stageDeals = deals.filter((deal) => (deal.oppStatus || "New") === stage.key);
    return {
      ...stage,
      deals: stageDeals,
      value: stageDeals.reduce((sum, deal) => sum + amountOf(deal), 0),
    };
  });
}

export function makeOpportunityPayload(form) {
  return {
    oppName: form.oppName?.trim(),
    oppTitle: form.oppTitle?.trim(),
    oppStatus: form.oppStatus || "New",
    oppAmount: Number(form.oppAmount || 0),
    oppForcastCloseDate: form.oppForcastCloseDate || undefined,
    oppActualCloseDate: form.oppActualCloseDate || undefined,
    oppDescription: form.oppDescription?.trim(),
    leadIdFk: form.leadIdFk || undefined,
  };
}

export function payloadFromDeal(deal, overrides = {}) {
  return makeOpportunityPayload({
    oppName: deal?.oppName || "",
    oppTitle: deal?.oppTitle || "",
    oppStatus: deal?.oppStatus || "New",
    oppAmount: deal?.oppAmount || 0,
    oppForcastCloseDate: deal?.oppForcastCloseDate || "",
    oppActualCloseDate: deal?.oppActualCloseDate || "",
    oppDescription: deal?.oppDescription || "",
    leadIdFk: deal?.leadIdFk,
    ...overrides,
  });
}
