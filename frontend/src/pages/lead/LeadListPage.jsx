// // import { useState, useEffect, useMemo, useCallback, useRef } from "react";
// // import { createPortal } from "react-dom";
// // import { Link, useOutletContext } from "react-router-dom";
// // import { useLead } from "../../hooks/useLead";
// // import { LEAD_SOURCES } from "../../utils/constants";
// // import { formatDate } from "../../utils/format";
// // import AppConfirmDialog from "../../components/common/AppConfirmDialog";
// // import LeadForm from "../../components/lead/LeadForm";
// // import Icon from "../../components/Icon";

// // const STATUS_BG = {
// //   "New Lead": "bg-blue-100 text-blue-700",
// //   NotContacted: "bg-gray-100 text-gray-600",
// //   Contacted: "bg-indigo-100 text-indigo-700",
// //   Working: "bg-cyan-100 text-cyan-700",
// //   "Qualified Lead": "bg-purple-100 text-purple-700",
// //   QuotationSent: "bg-orange-100 text-orange-700",
// //   Negotiation: "bg-yellow-100 text-yellow-700",
// //   Converted: "bg-emerald-100 text-emerald-700",
// //   Won: "bg-emerald-100 text-emerald-700",
// //   Lost: "bg-red-100 text-red-700",
// //   Open: "bg-blue-100 text-blue-700",
// //   "On Hold": "bg-gray-100 text-gray-600",
// // };
// // const SOURCE_BG = {
// //   Website: "bg-sky-100 text-sky-700",
// //   Indiamart: "bg-orange-100 text-orange-700",
// //   Referral: "bg-violet-100 text-violet-700",
// //   "Cold Call": "bg-slate-100 text-slate-600",
// //   Email: "bg-blue-100 text-blue-700",
// //   "Social Media": "bg-pink-100 text-pink-700",
// //   "Trade Show": "bg-amber-100 text-amber-700",
// //   Advertisement: "bg-lime-100 text-lime-700",
// //   Other: "bg-gray-100 text-gray-500",
// // };
// // const GRADE_BG = {
// //   A: "bg-emerald-100 text-emerald-700 border-emerald-200",
// //   B: "bg-blue-100 text-blue-700 border-blue-200",
// //   C: "bg-amber-100 text-amber-700 border-amber-200",
// //   D: "bg-red-100 text-red-700 border-red-200",
// // };
// // const KANBAN_HEADER = {
// //   "New Lead": "border-blue-400",
// //   Contacted: "border-indigo-400",
// //   Working: "border-cyan-400",
// //   "Qualified Lead": "border-purple-400",
// //   Won: "border-emerald-400",
// //   Lost: "border-red-400",
// // };
// // const KANBAN_STATUSES = [
// //   "New Lead",
// //   "Contacted",
// //   "Working",
// //   "Qualified Lead",
// //   "Won",
// //   "Lost",
// // ];
// // const STATUS_TABS = [
// //   "All",
// //   "New Lead",
// //   "Contacted",
// //   "Working",
// //   "Qualified Lead",
// //   "Won",
// //   "Lost",
// // ];
// // const AVATAR_COLORS = [
// //   "bg-blue-100 text-blue-700",
// //   "bg-violet-100 text-violet-700",
// //   "bg-emerald-100 text-emerald-700",
// //   "bg-amber-100 text-amber-700",
// //   "bg-rose-100 text-rose-700",
// //   "bg-cyan-100 text-cyan-700",
// // ];

// // function avatarColor(name) {
// //   return AVATAR_COLORS[(name?.charCodeAt(0) || 0) % AVATAR_COLORS.length];
// // }

// // function timeAgo(dateStr) {
// //   if (!dateStr) return "—";
// //   const diff = Date.now() - new Date(dateStr).getTime();
// //   const mins = Math.floor(diff / 60000);
// //   if (mins < 1) return "just now";
// //   if (mins < 60) return `${mins}m ago`;
// //   const hrs = Math.floor(mins / 60);
// //   if (hrs < 24) return `${hrs}h ago`;
// //   const days = Math.floor(hrs / 24);
// //   if (days < 30) return `${days}d ago`;
// //   return `${Math.floor(days / 30)}mo ago`;
// // }

// // export default function LeadListPage() {
// //   const { getAll, create, update, remove, getAllScores, exportLeads } =
// //     useLead();
// //   const leadFormRef = useRef(null);

// //   const [allLeads, setAllLeads] = useState([]);
// //   const [scores, setScores] = useState([]);
// //   const [loading, setLoading] = useState(false);
// //   const [activeStatus, setActiveStatus] = useState("All");
// //   const [searchQuery, setSearchQuery] = useState("");
// //   const [sourceFilter, setSourceFilter] = useState("");
// //   const [gradeFilter, setGradeFilter] = useState("");
// //   const [dateFrom, setDateFrom] = useState("");
// //   const [dateTo, setDateTo] = useState("");
// //   const [sortKey, setSortKey] = useState("leadCreatedDate");
// //   const [sortDir, setSortDir] = useState("desc");
// //   const [currentView, setCurrentView] = useState("table");
// //   const [pageSize, setPageSize] = useState(25);
// //   const [currentPage, setCurrentPage] = useState(1);

// //   const [panelLead, setPanelLead] = useState(null);
// //   const [showPanel, setShowPanel] = useState(false);

// //   const [showModal, setShowModal] = useState(false);
// //   const [editingLead, setEditingLead] = useState(null);
// //   const [modalSaving, setModalSaving] = useState(false);

// //   const [deleteId, setDeleteId] = useState(null);
// //   const [selectedIds, setSelectedIds] = useState(new Set());

// //   const [toast, setToast] = useState(null);
// //   const toastTimer = useRef(null);

// //   function showToast(type, msg) {
// //     if (toastTimer.current) clearTimeout(toastTimer.current);
// //     setToast({ type, msg });
// //     toastTimer.current = setTimeout(() => setToast(null), 3000);
// //   }

// //   const loadAll = useCallback(async () => {
// //     setLoading(true);
// //     try {
// //       const leads = await getAll();
// //       setAllLeads(leads ?? []);
// //       getAllScores()
// //         .then((s) => setScores(s ?? []))
// //         .catch(() => {});
// //     } finally {
// //       setLoading(false);
// //     }
// //   }, []); // eslint-disable-line

// //   useEffect(() => {
// //     loadAll();
// //   }, [loadAll]);

// //   const scoresMap = useMemo(() => {
// //     const m = {};
// //     for (const s of scores) m[s.leadId] = s;
// //     return m;
// //   }, [scores]);

// //   const filtersActive = useMemo(
// //     () =>
// //       searchQuery !== "" ||
// //       sourceFilter !== "" ||
// //       gradeFilter !== "" ||
// //       dateFrom !== "" ||
// //       dateTo !== "" ||
// //       activeStatus !== "All",
// //     [searchQuery, sourceFilter, gradeFilter, dateFrom, dateTo, activeStatus],
// //   );

// //   const filteredLeads = useMemo(() => {
// //     let list = allLeads;
// //     if (activeStatus !== "All")
// //       list = list.filter((l) => l.leadStatus === activeStatus);
// //     if (searchQuery) {
// //       const q = searchQuery.toLowerCase();
// //       list = list.filter(
// //         (l) =>
// //           `${l.leadFirstName} ${l.leadLastName ?? ""}`
// //             .toLowerCase()
// //             .includes(q) ||
// //           (l.leadMobileNo ?? "").includes(q) ||
// //           (l.leadEmail ?? "").toLowerCase().includes(q) ||
// //           (l.leadOrganisationName ?? "").toLowerCase().includes(q),
// //       );
// //     }
// //     if (sourceFilter) list = list.filter((l) => l.leadSource === sourceFilter);
// //     if (gradeFilter)
// //       list = list.filter((l) => scoresMap[l.leadId]?.grade === gradeFilter);
// //     if (dateFrom)
// //       list = list.filter(
// //         (l) => l.leadCreatedDate && l.leadCreatedDate >= dateFrom,
// //       );
// //     if (dateTo)
// //       list = list.filter(
// //         (l) => l.leadCreatedDate && l.leadCreatedDate <= dateTo + "T23:59:59",
// //       );

// //     return [...list].sort((a, b) => {
// //       let va = "",
// //         vb = "";
// //       if (sortKey === "leadFirstName") {
// //         va = `${a.leadFirstName} ${a.leadLastName ?? ""}`.toLowerCase();
// //         vb = `${b.leadFirstName} ${b.leadLastName ?? ""}`.toLowerCase();
// //       } else if (sortKey === "leadStatus") {
// //         va = a.leadStatus;
// //         vb = b.leadStatus;
// //       } else {
// //         va = a.leadCreatedDate ?? "";
// //         vb = b.leadCreatedDate ?? "";
// //       }
// //       return sortDir === "asc" ? va.localeCompare(vb) : vb.localeCompare(va);
// //     });
// //   }, [
// //     allLeads,
// //     activeStatus,
// //     searchQuery,
// //     sourceFilter,
// //     gradeFilter,
// //     dateFrom,
// //     dateTo,
// //     sortKey,
// //     sortDir,
// //     scoresMap,
// //   ]);

// //   const totalCount = filteredLeads.length;
// //   const totalPages = Math.ceil(totalCount / pageSize);
// //   const { setHeaderBadge } = useOutletContext();

// //   useEffect(() => {
// //     setHeaderBadge?.(totalCount);
// //     return () => setHeaderBadge?.(null);
// //   }, [setHeaderBadge, totalCount]);

// //   const pagedLeads = useMemo(() => {
// //     const start = (currentPage - 1) * pageSize;
// //     return filteredLeads.slice(start, start + pageSize);
// //   }, [filteredLeads, currentPage, pageSize]);

// //   useEffect(() => {
// //     setCurrentPage(1);
// //     setSelectedIds(new Set());
// //   }, [
// //     searchQuery,
// //     sourceFilter,
// //     gradeFilter,
// //     dateFrom,
// //     dateTo,
// //     activeStatus,
// //     sortKey,
// //     sortDir,
// //     pageSize,
// //   ]);

// //   const kanbanColumns = useMemo(
// //     () =>
// //       KANBAN_STATUSES.map((s) => ({
// //         status: s,
// //         leads: filteredLeads.filter((l) => l.leadStatus === s),
// //       })),
// //     [filteredLeads],
// //   );

// //   const allPageSelected = useMemo(
// //     () =>
// //       pagedLeads.length > 0 &&
// //       pagedLeads.every((l) => selectedIds.has(l.leadId)),
// //     [pagedLeads, selectedIds],
// //   );

// //   function toggleSelectAll() {
// //     if (allPageSelected) {
// //       setSelectedIds((prev) => {
// //         const n = new Set(prev);
// //         pagedLeads.forEach((l) => n.delete(l.leadId));
// //         return n;
// //       });
// //     } else {
// //       setSelectedIds((prev) => {
// //         const n = new Set(prev);
// //         pagedLeads.forEach((l) => n.add(l.leadId));
// //         return n;
// //       });
// //     }
// //   }

// //   function toggleSelect(id) {
// //     setSelectedIds((prev) => {
// //       const n = new Set(prev);
// //       n.has(id) ? n.delete(id) : n.add(id);
// //       return n;
// //     });
// //   }

// //   function toggleSort(key) {
// //     if (sortKey === key) setSortDir((d) => (d === "asc" ? "desc" : "asc"));
// //     else {
// //       setSortKey(key);
// //       setSortDir("asc");
// //     }
// //   }

// //   function clearFilters() {
// //     setSearchQuery("");
// //     setSourceFilter("");
// //     setGradeFilter("");
// //     setDateFrom("");
// //     setDateTo("");
// //     setActiveStatus("All");
// //     setSortKey("leadCreatedDate");
// //     setSortDir("desc");
// //   }

// //   async function bulkExport() {
// //     const selected = allLeads.filter((l) => selectedIds.has(l.leadId));
// //     const headers = [
// //       "ID",
// //       "Name",
// //       "Mobile",
// //       "Email",
// //       "Organization",
// //       "Status",
// //       "Source",
// //       "Date",
// //     ];
// //     const rows = selected.map((l) => [
// //       l.leadId,
// //       `${l.leadFirstName} ${l.leadLastName ?? ""}`.trim(),
// //       l.leadMobileNo ?? "",
// //       l.leadEmail ?? "",
// //       l.leadOrganisationName ?? "",
// //       l.leadStatus,
// //       l.leadSource ?? "",
// //       formatDate(l.leadCreatedDate),
// //     ]);
// //     const csv = [headers, ...rows].map((r) => r.join(",")).join("\n");
// //     const blob = new Blob([csv], { type: "text/csv" });
// //     const url = URL.createObjectURL(blob);
// //     const a = document.createElement("a");
// //     a.href = url;
// //     a.download = "leads.csv";
// //     a.click();
// //     URL.revokeObjectURL(url);
// //   }

// //   async function bulkDelete() {
// //     if (!selectedIds.size) return;
// //     if (!confirm(`Delete ${selectedIds.size} selected leads?`)) return;
// //     setLoading(true);
// //     try {
// //       await Promise.all([...selectedIds].map((id) => remove(id)));
// //       showToast("success", `${selectedIds.size} leads deleted.`);
// //       setSelectedIds(new Set());
// //       await loadAll();
// //     } catch {
// //       showToast("error", "Some deletes failed.");
// //     } finally {
// //       setLoading(false);
// //     }
// //   }

// //   function openCreate() {
// //     setEditingLead(null);
// //     setShowModal(true);
// //   }
// //   function openEdit(lead, e) {
// //     e?.stopPropagation();
// //     setEditingLead({ ...lead });
// //     setShowPanel(false);
// //     setShowModal(true);
// //   }
// //   function openPanel(lead) {
// //     setPanelLead(lead);
// //     setShowPanel(true);
// //   }

// //   async function handleSave(formData) {
// //     setModalSaving(true);
// //     try {
// //       if (editingLead?.leadId) {
// //         await update(editingLead.leadId, formData, {});
// //         showToast("success", "Lead updated.");
// //       } else {
// //         await create(formData, {});
// //         showToast("success", "Lead created.");
// //       }
// //       setShowModal(false);
// //       await loadAll();
// //     } catch {
// //       showToast("error", "Failed to save lead.");
// //     } finally {
// //       setModalSaving(false);
// //     }
// //   }

// //   async function handleDelete() {
// //     if (!deleteId) return;
// //     setLoading(true);
// //     try {
// //       await remove(deleteId);
// //       showToast("success", "Lead deleted.");
// //       if (panelLead?.leadId === deleteId) setShowPanel(false);
// //       await loadAll();
// //     } catch {
// //       showToast("error", "Failed to delete lead.");
// //     } finally {
// //       setDeleteId(null);
// //       setLoading(false);
// //     }
// //   }

// //   function sortIcon(key) {
// //     if (sortKey !== key) return "mdi:unfold-more-horizontal";
// //     return sortDir === "asc" ? "mdi:chevron-up" : "mdi:chevron-down";
// //   }

// //   const gradeActiveClass = (g) => {
// //     if (gradeFilter !== g) return "text-gray-500 hover:bg-gray-100";
// //     if (g === "A") return "bg-emerald-500 text-white";
// //     if (g === "B") return "bg-blue-500 text-white";
// //     if (g === "C") return "bg-amber-500 text-white";
// //     if (g === "D") return "bg-red-500 text-white";
// //     return "bg-gray-800 text-white";
// //   };

// //   return (
// //     <div className="animate-fade-in flex flex-col gap-0">
// //       {/* Top Bar */}
// //       <div className="flex items-center justify-between gap-4 ">
// //         <div className="flex items-center gap-3">
// //           {/* <h1 className="text-xl font-semibold text-gray-900 leading-none">
// //             Leads
// //           </h1> */}
// //           {/* <span className="inline-flex items-center justify-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-700 min-w-[2rem]"> */}
// //           {/* {totalCount} */}
// //           {/* </span> */}
// //         </div>

// //       </div>

// //       {/* Filter Bar */}
// //       <div className="  flex flex-col gap-3 mb-3">
// //         {/* .. left*/}
// //         <div className="flex justify-between">
// //           {/* ............. */}
// //            <div className="-mt- flex flex-wrap items-center gap-2">
// //           {/* ..left side  */}
// //           <div className="flex items-center gap-1 flex-wrap">
// //             {STATUS_TABS.map((s) => (
// //               <button
// //                 key={s}
// //                 onClick={() => setActiveStatus(s)}
// //                 className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all duration-150 border ${
// //                   activeStatus === s
// //                     ? "bg-blue-600 text-white border-blue-600 shadow-sm"
// //                     : "bg-white text-gray-600 border-gray-200 hover:border-blue-300 hover:text-blue-600"
// //                 }`}
// //               >
// //                 {s}
// //               </button>
// //             ))}
// //           </div>

// //           <select
// //             value={sourceFilter}
// //             onChange={(e) => setSourceFilter(e.target.value)}
// //             className="text-xs border border-gray-200 rounded-lg px-3 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
// //           >
// //             <option value="">All Sources</option>
// //             {LEAD_SOURCES.map((src) => (
// //               <option key={src} value={src}>
// //                 {src}
// //               </option>
// //             ))}
// //           </select>
// //         </div>
// //           <div className="flex items-center gap-2 p-4">
// //           <div className="relative w-72 mr-auto">
// //             <Icon
// //               name="mdi:magnify"
// //               className="absolute left-2.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none"
// //             />
// //             <input
// //               type="text"
// //               value={searchQuery}
// //               onChange={(e) => setSearchQuery(e.target.value)}
// //               placeholder="Search name, mobile, email, org..."
// //               className="pl-8 pr-3 py-2 w-full text-sm border border-gray-200 rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400 placeholder-gray-400"
// //             />
// //           </div>

// //           <Link
// //             to="/lead/import"
// //             className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 hover:border-gray-300 transition-colors shadow-sm"
// //           >
// //             <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
// //             Import
// //           </Link>

// //           <button
// //             onClick={openCreate}
// //             className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors shadow-sm shadow-blue-200"
// //           >
// //             <Icon name="mdi:plus" className="w-4 h-4" />
// //             New Lead
// //           </button>
// //         </div></div>

// //         <div className="flex flex-wrap items-center gap-2">
// //           {/* .dtatennn */}
// //           <div className="flex items-center gap-1">
// //             <input
// //               type="date"
// //               value={dateFrom}
// //               onChange={(e) => setDateFrom(e.target.value)}
// //               className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
// //             />
// //             <span className="text-gray-400 text-xs">–</span>
// //             <input
// //               type="date"
// //               value={dateTo}
// //               onChange={(e) => setDateTo(e.target.value)}
// //               className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
// //             />
// //           </div>
// // {/* .gread */}
// //           <div className="ml-auto flex items-center gap-1">
// //             <div className="flex items-center gap-1 bg-white border border-gray-200 rounded-lg p-0.5">
// //               {["", "A", "B", "C", "D"].map((g) => (
// //                 <button
// //                   key={g}
// //                   onClick={() => setGradeFilter(g)}
// //                   className={`px-2.5 py-1 rounded-md text-xs font-bold transition-all ${gradeActiveClass(g)}`}
// //                 >
// //                   {g === "" ? "Grade" : g}
// //                 </button>
// //               ))}
// //             </div>

// //             {filtersActive && (
// //               <button
// //                 onClick={clearFilters}
// //                 className="text-xs text-blue-600 hover:underline font-medium flex items-center gap-1"
// //               >
// //                 <Icon name="mdi:close-circle-outline" className="w-3.5 h-3.5" />
// //                 Clear filters
// //               </button>
// //             )}

// //             <button
// //               onClick={() => setCurrentView("table")}
// //               className={`p-1.5 rounded-md transition-all ${currentView === "table" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
// //               title="Table view"
// //             >
// //               <Icon name="mdi:table" className="w-4 h-4" />
// //             </button>
// //             <button
// //               onClick={() => setCurrentView("kanban")}
// //               className={`p-1.5 rounded-md transition-all ${currentView === "kanban" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
// //               title="Kanban view"
// //             >
// //               <Icon name="mdi:view-column-outline" className="w-4 h-4" />
// //             </button>
// //           </div>
// //         </div>
// //       </div>

// //       {/* Loading Skeleton */}
// //       {loading && (
// //         <div className="space-y-2">
// //           <div className="h-10 bg-gray-100 rounded-lg animate-pulse" />
// //           {[...Array(8)].map((_, i) => (
// //             <div
// //               key={i}
// //               className="h-12 bg-gray-50 rounded-lg animate-pulse"
// //               style={{ opacity: 1 - i * 0.08 }}
// //             />
// //           ))}
// //         </div>
// //       )}

// //       {/* TABLE VIEW */}
// //       {!loading && currentView === "table" && (
// //         <>
// //           {!filteredLeads.length ? (
// //             <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
// //               <div className="w-16 h-16 rounded-2xl bg-blue-50 flex items-center justify-center mb-4">
// //                 <Icon
// //                   name="mdi:account-search-outline"
// //                   className="w-8 h-8 text-blue-400"
// //                 />
// //               </div>
// //               <p className="text-base font-semibold text-gray-700 mb-1">
// //                 No leads found
// //               </p>
// //               <p className="text-sm text-gray-400 mb-5">
// //                 Try adjusting your filters or add a new lead.
// //               </p>
// //               <div className="flex gap-2">
// //                 <Link
// //                   to="/lead/import"
// //                   className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
// //                 >
// //                   <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
// //                   Import leads
// //                 </Link>
// //                 <button
// //                   onClick={openCreate}
// //                   className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
// //                 >
// //                   <Icon name="mdi:plus" className="w-4 h-4" />
// //                   Add manually
// //                 </button>
// //               </div>
// //             </div>
// //           ) : (
// //             <div className="bg-white rounded-xl border border-gray-100 shadow-sm overflow-hidden">
// //               <div className="overflow-x-auto">
// //                 <table
// //                   className="w-full table-fixed text-sm"
// //                   style={{ minWidth: "1040px" }}
// //                 >
// //                   <thead>
// //                     <tr className="bg-gray-50 border-b border-gray-100">
// //                       <th className="w-10 pl-4 py-2.5">
// //                         <input
// //                           type="checkbox"
// //                           checked={allPageSelected}
// //                           onChange={toggleSelectAll}
// //                           className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
// //                         />
// //                       </th>
// //                       <th className="w-[22%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
// //                         <button
// //                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
// //                           onClick={() => toggleSort("leadFirstName")}
// //                         >
// //                           Lead Name{" "}
// //                           <Icon
// //                             name={sortIcon("leadFirstName")}
// //                             className="w-3.5 h-3.5"
// //                           />
// //                         </button>
// //                       </th>
// //                       <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
// //                         Mobile
// //                       </th>
// //                       <th className="w-[11%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
// //                         Source
// //                       </th>
// //                       <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
// //                         <button
// //                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
// //                           onClick={() => toggleSort("leadStatus")}
// //                         >
// //                           Status{" "}
// //                           <Icon
// //                             name={sortIcon("leadStatus")}
// //                             className="w-3.5 h-3.5"
// //                           />
// //                         </button>
// //                       </th>
// //                       <th className="w-[9%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
// //                         Grade
// //                       </th>
// //                       <th className="w-[12%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden lg:table-cell">
// //                         Last Activity
// //                       </th>
// //                       <th className="w-[10%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden xl:table-cell">
// //                         <button
// //                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
// //                           onClick={() => toggleSort("leadCreatedDate")}
// //                         >
// //                           Created{" "}
// //                           <Icon
// //                             name={sortIcon("leadCreatedDate")}
// //                             className="w-3.5 h-3.5"
// //                           />
// //                         </button>
// //                       </th>
// //                       <th className="sticky right-0 z-20 w-28 bg-gray-50 py-2.5 pl-3 pr-4 text-right text-xs font-semibold text-gray-500 uppercase tracking-wide shadow-[-8px_0_12px_rgba(15,23,42,0.04)]">
// //                         Actions
// //                       </th>
// //                     </tr>
// //                   </thead>
// //                   <tbody className="divide-y divide-gray-50">
// //                     {pagedLeads.map((lead, idx) => {
// //                       const score = scoresMap[lead.leadId];
// //                       return (
// //                         <tr
// //                           key={lead.leadId}
// //                           className={`cursor-pointer transition-colors duration-100 ${
// //                             idx % 2 === 0 ? "bg-white" : "bg-gray-50/40"
// //                           } ${selectedIds.has(lead.leadId) ? "bg-blue-50/60" : "hover:bg-blue-50/40"}`}
// //                           onClick={() => openPanel(lead)}
// //                         >
// //                           <td
// //                             className="pl-4 py-2"
// //                             onClick={(e) => e.stopPropagation()}
// //                           >
// //                             <input
// //                               type="checkbox"
// //                               checked={selectedIds.has(lead.leadId)}
// //                               onChange={() => toggleSelect(lead.leadId)}
// //                               className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
// //                             />
// //                           </td>
// //                           <td className="px-3 py-2">
// //                             <div className="flex items-center gap-2.5">
// //                               <div
// //                                 className={`w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
// //                               >
// //                                 {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
// //                               </div>
// //                               <div className="min-w-0">
// //                                 <p className="font-medium text-gray-900 truncate leading-snug">
// //                                   {lead.leadFirstName} {lead.leadLastName}
// //                                 </p>
// //                                 {lead.leadOrganisationName && (
// //                                   <p className="text-xs text-gray-400 truncate leading-snug">
// //                                     {lead.leadOrganisationName}
// //                                   </p>
// //                                 )}
// //                               </div>
// //                             </div>
// //                           </td>
// //                           <td
// //                             className="px-3 py-2"
// //                             onClick={(e) => e.stopPropagation()}
// //                           >
// //                             {lead.leadMobileNo ? (
// //                               <a
// //                                 href={`tel:${lead.leadMobileNo}`}
// //                                 className="flex items-center gap-1 text-sm text-gray-700 hover:text-blue-600 transition-colors group"
// //                               >
// //                                 <Icon
// //                                   name="mdi:phone-outline"
// //                                   className="w-3.5 h-3.5 text-gray-400 group-hover:text-blue-500 shrink-0"
// //                                 />
// //                                 {lead.leadMobileNo}
// //                               </a>
// //                             ) : (
// //                               <span className="text-gray-300 text-xs">—</span>
// //                             )}
// //                           </td>
// //                           <td className="px-3 py-2">
// //                             {lead.leadSource ? (
// //                               <span
// //                                 className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
// //                               >
// //                                 {lead.leadSource}
// //                               </span>
// //                             ) : (
// //                               <span className="text-gray-300 text-xs">—</span>
// //                             )}
// //                           </td>
// //                           <td className="px-3 py-2">
// //                             <span
// //                               className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[lead.leadStatus] ?? "bg-gray-100 text-gray-600"}`}
// //                             >
// //                               {lead.leadStatus}
// //                             </span>
// //                           </td>
// //                           <td className="px-3 py-2">
// //                             {score ? (
// //                               <div className="flex items-center gap-1.5">
// //                                 <span
// //                                   className={`inline-flex items-center justify-center w-6 h-6 rounded-md text-xs font-bold border ${GRADE_BG[score.grade] ?? "bg-gray-100 text-gray-600"}`}
// //                                 >
// //                                   {score.grade}
// //                                 </span>
// //                                 <span className="text-xs text-gray-400 hidden xl:inline">
// //                                   {score.score}
// //                                 </span>
// //                               </div>
// //                             ) : (
// //                               <span className="text-gray-300 text-xs">—</span>
// //                             )}
// //                           </td>
// //                           <td className="px-3 py-2 hidden lg:table-cell">
// //                             <span className="text-xs text-gray-400">
// //                               {timeAgo(lead.leadCreatedDate)}
// //                             </span>
// //                           </td>
// //                           <td className="px-3 py-2 hidden xl:table-cell">
// //                             <span className="text-xs text-gray-500">
// //                               {formatDate(lead.leadCreatedDate)}
// //                             </span>
// //                           </td>
// //                           <td
// //                             className={`sticky right-0 pl-3 pr-4 py-2 shadow-[-8px_0_12px_rgba(15,23,42,0.04)] ${selectedIds.has(lead.leadId) ? "bg-blue-50" : idx % 2 === 0 ? "bg-white" : "bg-gray-50"}`}
// //                             onClick={(e) => e.stopPropagation()}
// //                           >
// //                             <div className="flex items-center justify-end gap-1">
// //                               <Link
// //                                 to={`/lead/${lead.leadId}`}
// //                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-blue-50 hover:text-blue-600 transition-colors"
// //                                 title="View detail"
// //                               >
// //                                 <Icon
// //                                   name="mdi:eye-outline"
// //                                   className="w-4 h-4"
// //                                 />
// //                               </Link>
// //                               <button
// //                                 onClick={(e) => openEdit(lead, e)}
// //                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-amber-50 hover:text-amber-600 transition-colors"
// //                                 title="Edit"
// //                               >
// //                                 <Icon
// //                                   name="mdi:pencil-outline"
// //                                   className="w-4 h-4"
// //                                 />
// //                               </button>
// //                               <button
// //                                 onClick={(e) => {
// //                                   e.stopPropagation();
// //                                   setDeleteId(lead.leadId);
// //                                 }}
// //                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-red-50 hover:text-red-600 transition-colors"
// //                                 title="Delete"
// //                               >
// //                                 <Icon
// //                                   name="mdi:trash-can-outline"
// //                                   className="w-4 h-4"
// //                                 />
// //                               </button>
// //                             </div>
// //                           </td>
// //                         </tr>
// //                       );
// //                     })}
// //                   </tbody>
// //                 </table>
// //               </div>

// //               {/* Pagination */}
// //               <div className="flex items-center justify-between px-4 py-3 border-t border-gray-100 bg-gray-50/50">
// //                 <div className="flex items-center gap-2">
// //                   <span className="text-xs text-gray-500">
// //                     Showing{" "}
// //                     {Math.min((currentPage - 1) * pageSize + 1, totalCount)}–
// //                     {Math.min(currentPage * pageSize, totalCount)} of{" "}
// //                     {totalCount}
// //                   </span>
// //                   <select
// //                     value={pageSize}
// //                     onChange={(e) => setPageSize(Number(e.target.value))}
// //                     className="text-xs border border-gray-200 rounded-md px-1.5 py-1 bg-white text-gray-600 focus:outline-none focus:ring-1 focus:ring-blue-500"
// //                   >
// //                     <option value={25}>25</option>
// //                     <option value={50}>50</option>
// //                     <option value={100}>100</option>
// //                   </select>
// //                   <span className="text-xs text-gray-400">per page</span>
// //                 </div>
// //                 <div className="flex items-center gap-1">
// //                   <button
// //                     disabled={currentPage <= 1}
// //                     onClick={() => setCurrentPage((p) => p - 1)}
// //                     className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
// //                   >
// //                     <Icon name="mdi:chevron-left" className="w-4 h-4" />
// //                   </button>
// //                   {[...Array(totalPages)].map((_, i) => {
// //                     const p = i + 1;
// //                     if (
// //                       p === 1 ||
// //                       p === totalPages ||
// //                       (p >= currentPage - 1 && p <= currentPage + 1)
// //                     ) {
// //                       return (
// //                         <button
// //                           key={p}
// //                           onClick={() => setCurrentPage(p)}
// //                           className={`w-8 h-8 rounded-lg text-xs font-medium transition-colors ${
// //                             p === currentPage
// //                               ? "bg-blue-600 text-white"
// //                               : "border border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
// //                           }`}
// //                         >
// //                           {p}
// //                         </button>
// //                       );
// //                     }
// //                     if (p === currentPage - 2 || p === currentPage + 2) {
// //                       return (
// //                         <span key={p} className="px-1 text-gray-400 text-xs">
// //                           …
// //                         </span>
// //                       );
// //                     }
// //                     return null;
// //                   })}
// //                   <button
// //                     disabled={currentPage >= totalPages}
// //                     onClick={() => setCurrentPage((p) => p + 1)}
// //                     className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
// //                   >
// //                     <Icon name="mdi:chevron-right" className="w-4 h-4" />
// //                   </button>
// //                 </div>
// //               </div>
// //             </div>
// //           )}
// //         </>
// //       )}

// //       {/* KANBAN VIEW */}
// //       {!loading && currentView === "kanban" && (
// //         <>
// //           {!filteredLeads.length ? (
// //             <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
// //               <Icon
// //                 name="mdi:view-column-outline"
// //                 className="w-12 h-12 text-gray-300 mb-3"
// //               />
// //               <p className="text-sm font-medium text-gray-500">
// //                 No leads to display
// //               </p>
// //               <button
// //                 onClick={openCreate}
// //                 className="mt-4 inline-flex items-center gap-1 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
// //               >
// //                 <Icon name="mdi:plus" className="w-4 h-4" />
// //                 Add Lead
// //               </button>
// //             </div>
// //           ) : (
// //             <div className="flex gap-3 overflow-x-auto pb-3">
// //               {kanbanColumns.map((col) => (
// //                 <div
// //                   key={col.status}
// //                   className="flex-none w-64 flex flex-col gap-2"
// //                 >
// //                   <div
// //                     className={`flex items-center justify-between px-3 py-2 bg-white rounded-xl border-t-2 shadow-sm ${KANBAN_HEADER[col.status] ?? "border-gray-300"}`}
// //                   >
// //                     <div className="flex items-center gap-2">
// //                       <span
// //                         className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[col.status] ?? "bg-gray-100 text-gray-600"}`}
// //                       >
// //                         {col.status}
// //                       </span>
// //                       <span className="text-xs text-gray-400 font-medium">
// //                         {col.leads.length}
// //                       </span>
// //                     </div>
// //                     <button
// //                       onClick={openCreate}
// //                       className="p-1 rounded-lg text-gray-400 hover:bg-gray-100 transition-colors"
// //                     >
// //                       <Icon name="mdi:plus" className="w-4 h-4" />
// //                     </button>
// //                   </div>
// //                   <div className="flex flex-col gap-2 max-h-[calc(100vh-260px)] overflow-y-auto">
// //                     {col.leads.map((lead) => {
// //                       const score = scoresMap[lead.leadId];
// //                       return (
// //                         <div
// //                           key={lead.leadId}
// //                           className="bg-white rounded-xl border border-gray-100 shadow-sm p-3 cursor-pointer hover:shadow-md hover:border-blue-200 transition-all group"
// //                           onClick={() => openPanel(lead)}
// //                         >
// //                           <div className="flex items-start justify-between gap-2 mb-2">
// //                             <div className="flex items-center gap-2 min-w-0">
// //                               <div
// //                                 className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
// //                               >
// //                                 {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
// //                               </div>
// //                               <div className="min-w-0">
// //                                 <p className="text-xs font-semibold text-gray-900 truncate leading-snug">
// //                                   {lead.leadFirstName} {lead.leadLastName}
// //                                 </p>
// //                                 {lead.leadOrganisationName && (
// //                                   <p className="text-[10px] text-gray-400 truncate">
// //                                     {lead.leadOrganisationName}
// //                                   </p>
// //                                 )}
// //                               </div>
// //                             </div>
// //                             {score && (
// //                               <span
// //                                 className={`inline-flex items-center justify-center w-5 h-5 rounded text-[10px] font-bold border shrink-0 ${GRADE_BG[score.grade]}`}
// //                               >
// //                                 {score.grade}
// //                               </span>
// //                             )}
// //                           </div>
// //                           <div className="flex items-center justify-between mt-2">
// //                             {lead.leadSource ? (
// //                               <span
// //                                 className={`text-[10px] px-1.5 py-0.5 rounded-full font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
// //                               >
// //                                 {lead.leadSource}
// //                               </span>
// //                             ) : (
// //                               <span className="text-[10px] text-gray-300">
// //                                 —
// //                               </span>
// //                             )}
// //                             <span className="text-[10px] text-gray-400">
// //                               {timeAgo(lead.leadCreatedDate)}
// //                             </span>
// //                           </div>
// //                           <div className="flex items-center gap-1 mt-2 opacity-0 group-hover:opacity-100 transition-opacity">
// //                             <Link
// //                               to={`/lead/${lead.leadId}`}
// //                               className="p-1 rounded text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors"
// //                               onClick={(e) => e.stopPropagation()}
// //                             >
// //                               <Icon
// //                                 name="mdi:eye-outline"
// //                                 className="w-3.5 h-3.5"
// //                               />
// //                             </Link>
// //                             <button
// //                               className="p-1 rounded text-gray-400 hover:text-amber-600 hover:bg-amber-50 transition-colors"
// //                               onClick={(e) => openEdit(lead, e)}
// //                             >
// //                               <Icon
// //                                 name="mdi:pencil-outline"
// //                                 className="w-3.5 h-3.5"
// //                               />
// //                             </button>
// //                             <button
// //                               className="p-1 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
// //                               onClick={(e) => {
// //                                 e.stopPropagation();
// //                                 setDeleteId(lead.leadId);
// //                               }}
// //                             >
// //                               <Icon
// //                                 name="mdi:trash-can-outline"
// //                                 className="w-3.5 h-3.5"
// //                               />
// //                             </button>
// //                           </div>
// //                         </div>
// //                       );
// //                     })}
// //                     {!col.leads.length && (
// //                       <div className="flex flex-col items-center justify-center py-6 rounded-xl border border-dashed border-gray-200 text-gray-400 text-xs">
// //                         <Icon
// //                           name="mdi:inbox-outline"
// //                           className="w-6 h-6 mb-1"
// //                         />
// //                         No leads
// //                       </div>
// //                     )}
// //                   </div>
// //                 </div>
// //               ))}
// //             </div>
// //           )}
// //         </>
// //       )}

// //       {/* Bulk action bar */}
// //       {selectedIds.size > 0 &&
// //         createPortal(
// //           <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-40 flex items-center gap-3 px-5 py-3 bg-gray-900 text-white rounded-2xl shadow-2xl shadow-gray-900/40">
// //             <span className="text-sm font-semibold">
// //               {selectedIds.size} selected
// //             </span>
// //             <div className="w-px h-4 bg-white/20" />
// //             <button
// //               onClick={bulkExport}
// //               className="flex items-center gap-1.5 text-sm text-gray-300 hover:text-white transition-colors"
// //             >
// //               <Icon name="mdi:download-outline" className="w-4 h-4" />
// //               Export CSV
// //             </button>
// //             <button
// //               onClick={bulkDelete}
// //               className="flex items-center gap-1.5 text-sm text-red-400 hover:text-red-300 transition-colors"
// //             >
// //               <Icon name="mdi:trash-can-outline" className="w-4 h-4" />
// //               Delete
// //             </button>
// //             <button
// //               onClick={() => setSelectedIds(new Set())}
// //               className="ml-1 p-1 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
// //             >
// //               <Icon name="mdi:close" className="w-4 h-4" />
// //             </button>
// //           </div>,
// //           document.body,
// //         )}

// //       {/* Right slide-over panel */}
// //       {showPanel &&
// //         panelLead &&
// //         createPortal(
// //           <div className="fixed inset-0 z-50 flex justify-end">
// //             <div
// //               className="absolute inset-0 bg-black/30 backdrop-blur-sm"
// //               onClick={() => setShowPanel(false)}
// //             />
// //             <div className="relative w-full max-w-[480px] h-full bg-white shadow-2xl flex flex-col overflow-hidden">
// //               <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 shrink-0">
// //                 <div className="flex items-center gap-3">
// //                   <div
// //                     className={`w-10 h-10 rounded-xl flex items-center justify-center text-sm font-bold ${avatarColor(panelLead.leadFirstName)}`}
// //                   >
// //                     {(panelLead.leadFirstName?.[0] ?? "?").toUpperCase()}
// //                   </div>
// //                   <div>
// //                     <p className="text-base font-semibold text-gray-900 leading-snug">
// //                       {panelLead.leadFirstName} {panelLead.leadLastName}
// //                     </p>
// //                     {panelLead.leadOrganisationName && (
// //                       <p className="text-xs text-gray-400">
// //                         {panelLead.leadOrganisationName}
// //                       </p>
// //                     )}
// //                   </div>
// //                 </div>
// //                 <button
// //                   onClick={() => setShowPanel(false)}
// //                   className="p-1.5 rounded-lg text-gray-400 hover:bg-gray-100 hover:text-gray-600 transition-colors"
// //                 >
// //                   <Icon name="mdi:close" className="w-5 h-5" />
// //                 </button>
// //               </div>

// //               <div className="flex-1 overflow-y-auto p-5 space-y-5">
// //                 <div className="flex flex-wrap items-center gap-2">
// //                   <span
// //                     className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${STATUS_BG[panelLead.leadStatus] ?? "bg-gray-100 text-gray-600"}`}
// //                   >
// //                     {panelLead.leadStatus}
// //                   </span>
// //                   {panelLead.leadSource && (
// //                     <span
// //                       className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${SOURCE_BG[panelLead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
// //                     >
// //                       {panelLead.leadSource}
// //                     </span>
// //                   )}
// //                   {scoresMap[panelLead.leadId] && (
// //                     <span
// //                       className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold border ${GRADE_BG[scoresMap[panelLead.leadId].grade]}`}
// //                     >
// //                       Grade {scoresMap[panelLead.leadId].grade} ·{" "}
// //                       {scoresMap[panelLead.leadId].score}/100
// //                     </span>
// //                   )}
// //                 </div>

// //                 <div className="bg-gray-50 rounded-xl p-4 space-y-3">
// //                   <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">
// //                     Contact Info
// //                   </p>
// //                   {panelLead.leadMobileNo && (
// //                     <div className="flex items-center gap-2.5">
// //                       <Icon
// //                         name="mdi:phone-outline"
// //                         className="w-4 h-4 text-gray-400 shrink-0"
// //                       />
// //                       <a
// //                         href={`tel:${panelLead.leadMobileNo}`}
// //                         className="text-sm text-gray-700 hover:text-blue-600 transition-colors"
// //                       >
// //                         {panelLead.leadMobileNo}
// //                       </a>
// //                     </div>
// //                   )}
// //                   {panelLead.leadEmail && (
// //                     <div className="flex items-center gap-2.5">
// //                       <Icon
// //                         name="mdi:email-outline"
// //                         className="w-4 h-4 text-gray-400 shrink-0"
// //                       />
// //                       <a
// //                         href={`mailto:${panelLead.leadEmail}`}
// //                         className="text-sm text-gray-700 hover:text-blue-600 transition-colors truncate"
// //                       >
// //                         {panelLead.leadEmail}
// //                       </a>
// //                     </div>
// //                   )}
// //                   {panelLead.leadWebsite && (
// //                     <div className="flex items-center gap-2.5">
// //                       <Icon
// //                         name="mdi:web"
// //                         className="w-4 h-4 text-gray-400 shrink-0"
// //                       />
// //                       <a
// //                         href={panelLead.leadWebsite}
// //                         target="_blank"
// //                         rel="noopener noreferrer"
// //                         className="text-sm text-blue-600 hover:underline truncate"
// //                       >
// //                         {panelLead.leadWebsite}
// //                       </a>
// //                     </div>
// //                   )}
// //                   {(panelLead.leadCity ||
// //                     panelLead.leadState ||
// //                     panelLead.leadCountry) && (
// //                     <div className="flex items-center gap-2.5">
// //                       <Icon
// //                         name="mdi:map-marker-outline"
// //                         className="w-4 h-4 text-gray-400 shrink-0"
// //                       />
// //                       <span className="text-sm text-gray-700">
// //                         {[
// //                           panelLead.leadCity,
// //                           panelLead.leadState,
// //                           panelLead.leadCountry,
// //                         ]
// //                           .filter(Boolean)
// //                           .join(", ")}
// //                       </span>
// //                     </div>
// //                   )}
// //                 </div>

// //                 {(panelLead.leadOrganisationName ||
// //                   panelLead.leadIndustry ||
// //                   panelLead.noOfEmployee) && (
// //                   <div className="bg-gray-50 rounded-xl p-4 space-y-3">
// //                     <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">
// //                       Company
// //                     </p>
// //                     {panelLead.leadOrganisationName && (
// //                       <div className="flex items-center gap-2.5">
// //                         <Icon
// //                           name="mdi:office-building-outline"
// //                           className="w-4 h-4 text-gray-400 shrink-0"
// //                         />
// //                         <span className="text-sm text-gray-700">
// //                           {panelLead.leadOrganisationName}
// //                         </span>
// //                       </div>
// //                     )}
// //                     {panelLead.leadIndustry && (
// //                       <div className="flex items-center gap-2.5">
// //                         <Icon
// //                           name="mdi:domain"
// //                           className="w-4 h-4 text-gray-400 shrink-0"
// //                         />
// //                         <span className="text-sm text-gray-700">
// //                           {panelLead.leadIndustry}
// //                         </span>
// //                       </div>
// //                     )}
// //                     {panelLead.noOfEmployee && (
// //                       <div className="flex items-center gap-2.5">
// //                         <Icon
// //                           name="mdi:account-group-outline"
// //                           className="w-4 h-4 text-gray-400 shrink-0"
// //                         />
// //                         <span className="text-sm text-gray-700">
// //                           {panelLead.noOfEmployee} employees
// //                         </span>
// //                       </div>
// //                     )}
// //                   </div>
// //                 )}

// //                 <div className="grid grid-cols-2 gap-3">
// //                   <div className="bg-gray-50 rounded-xl p-3">
// //                     <p className="text-xs text-gray-400 mb-1">Created</p>
// //                     <p className="text-sm font-medium text-gray-700">
// //                       {formatDate(panelLead.leadCreatedDate)}
// //                     </p>
// //                   </div>
// //                   {panelLead.inquiryDate && (
// //                     <div className="bg-gray-50 rounded-xl p-3">
// //                       <p className="text-xs text-gray-400 mb-1">Inquiry Date</p>
// //                       <p className="text-sm font-medium text-gray-700">
// //                         {formatDate(panelLead.inquiryDate)}
// //                       </p>
// //                     </div>
// //                   )}
// //                 </div>

// //                 {scoresMap[panelLead.leadId]?.topFactors?.length > 0 && (
// //                   <div className="bg-blue-50/60 rounded-xl p-4">
// //                     <p className="text-xs font-semibold text-blue-600 uppercase tracking-wide mb-3 flex items-center gap-1.5">
// //                       <Icon name="mdi:brain" className="w-4 h-4" />
// //                       AI Score Factors
// //                     </p>
// //                     <div className="space-y-1.5">
// //                       {scoresMap[panelLead.leadId].topFactors.map((factor) => (
// //                         <div
// //                           key={factor}
// //                           className="flex items-center gap-2 text-xs text-gray-600"
// //                         >
// //                           <Icon
// //                             name="mdi:check-circle"
// //                             className="w-3.5 h-3.5 text-blue-500 shrink-0"
// //                           />
// //                           {factor}
// //                         </div>
// //                       ))}
// //                     </div>
// //                   </div>
// //                 )}

// //                 {panelLead.leadReason && (
// //                   <div className="bg-gray-50 rounded-xl p-4">
// //                     <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2">
// //                       Notes
// //                     </p>
// //                     <p className="text-sm text-gray-700 leading-relaxed">
// //                       {panelLead.leadReason}
// //                     </p>
// //                   </div>
// //                 )}
// //               </div>

// //               <div className="px-5 py-4 border-t border-gray-100 flex items-center gap-2 bg-gray-50/50 shrink-0">
// //                 <Link
// //                   to={`/lead/${panelLead.leadId}`}
// //                   className="flex-1 inline-flex items-center justify-center gap-1.5 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
// //                 >
// //                   <Icon name="mdi:open-in-new" className="w-4 h-4" />
// //                   Full Detail
// //                 </Link>
// //                 <button
// //                   onClick={() => openEdit(panelLead)}
// //                   className="flex-1 inline-flex items-center justify-center gap-1.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
// //                 >
// //                   <Icon name="mdi:pencil-outline" className="w-4 h-4" />
// //                   Edit Lead
// //                 </button>
// //                 <button
// //                   onClick={() => {
// //                     setDeleteId(panelLead.leadId);
// //                     setShowPanel(false);
// //                   }}
// //                   className="p-2 rounded-lg border border-gray-200 text-gray-400 hover:bg-red-50 hover:text-red-600 hover:border-red-200 transition-colors"
// //                   title="Delete"
// //                 >
// //                   <Icon name="mdi:trash-can-outline" className="w-4 h-4" />
// //                 </button>
// //               </div>
// //             </div>
// //           </div>,
// //           document.body,
// //         )}

// //       {/* Create / Edit Slide-over */}
// //       {showModal &&
// //         createPortal(
// //           <div className="fixed inset-0 z-50 flex justify-end">
// //             <div
// //               className="absolute inset-0 bg-black/30 backdrop-blur-[2px]"
// //               onClick={() => setShowModal(false)}
// //             />
// //             <div className="relative w-full max-w-[640px] h-full bg-white shadow-2xl flex flex-col">
// //               <div className="flex items-center gap-3 px-6 py-5 border-b border-gray-100 bg-gradient-to-r from-blue-600 to-indigo-600 shrink-0">
// //                 <div className="w-9 h-9 rounded-xl bg-white/20 flex items-center justify-center shrink-0">
// //                   <Icon
// //                     name={
// //                       editingLead
// //                         ? "mdi:pencil-outline"
// //                         : "mdi:account-plus-outline"
// //                     }
// //                     className="w-5 h-5 text-white"
// //                   />
// //                 </div>
// //                 <div className="flex-1 min-w-0">
// //                   <h2 className="text-base font-bold text-white leading-tight">
// //                     {editingLead ? "Edit Lead" : "New Lead"}
// //                   </h2>
// //                   <p className="text-xs text-blue-100 mt-0.5">
// //                     {editingLead
// //                       ? `Updating: ${editingLead.leadFirstName} ${editingLead.leadLastName ?? ""}`
// //                       : "Fill in the details to create a new lead"}
// //                   </p>
// //                 </div>
// //                 <button
// //                   onClick={() => setShowModal(false)}
// //                   className="w-8 h-8 rounded-lg flex items-center justify-center text-white/70 hover:bg-white/20 hover:text-white transition-colors"
// //                 >
// //                   <Icon name="mdi:close" className="w-5 h-5" />
// //                 </button>
// //               </div>
// //               <div className="flex-1 overflow-y-auto px-6 py-6">
// //                 <LeadForm
// //                   key={editingLead?.leadId ?? "create"}
// //                   ref={leadFormRef}
// //                   initial={editingLead}
// //                   loading={modalSaving}
// //                   onSubmit={handleSave}
// //                 />
// //               </div>
// //               <div className="flex items-center justify-between gap-3 px-6 py-4 border-t border-gray-100 bg-gray-50/70 shrink-0">
// //                 <div className="text-xs text-gray-400">
// //                   <span className="text-red-500">*</span> Required fields
// //                 </div>
// //                 <div className="flex items-center gap-2">
// //                   <button
// //                     onClick={() => setShowModal(false)}
// //                     className="px-5 py-2.5 rounded-lg border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-100 transition-colors"
// //                   >
// //                     Cancel
// //                   </button>
// //                   <button
// //                     type="button"
// //                     onClick={() =>
// //                       document.getElementById("lead-form")?.requestSubmit?.()
// //                     }
// //                     disabled={modalSaving}
// //                     className="inline-flex items-center gap-2 px-6 py-2.5 rounded-lg bg-blue-600 text-sm font-semibold text-white hover:bg-blue-700 disabled:opacity-60 transition-colors shadow-sm"
// //                   >
// //                     {modalSaving ? (
// //                       <Icon
// //                         name="mdi:loading"
// //                         className="w-4 h-4 animate-spin"
// //                       />
// //                     ) : (
// //                       <Icon
// //                         name={
// //                           editingLead
// //                             ? "mdi:check-circle-outline"
// //                             : "mdi:plus-circle-outline"
// //                         }
// //                         className="w-4 h-4"
// //                       />
// //                     )}
// //                     {modalSaving
// //                       ? "Saving…"
// //                       : editingLead
// //                         ? "Update Lead"
// //                         : "Create Lead"}
// //                   </button>
// //                 </div>
// //               </div>
// //             </div>
// //           </div>,
// //           document.body,
// //         )}

// //       <AppConfirmDialog
// //         open={deleteId !== null}
// //         title="Delete Lead"
// //         message="Are you sure you want to delete this lead? This action cannot be undone."
// //         onConfirm={handleDelete}
// //         onCancel={() => setDeleteId(null)}
// //       />

// //       {/* Toast */}
// //       {toast &&
// //         createPortal(
// //           <div
// //             className={`fixed bottom-6 right-6 z-[60] flex items-center gap-2.5 px-4 py-3 rounded-xl shadow-lg text-sm font-medium ${
// //               toast.type === "success"
// //                 ? "bg-emerald-600 text-white"
// //                 : "bg-red-600 text-white"
// //             }`}
// //           >
// //             <Icon
// //               name={
// //                 toast.type === "success"
// //                   ? "mdi:check-circle"
// //                   : "mdi:alert-circle"
// //               }
// //               className="w-5 h-5 shrink-0"
// //             />
// //             {toast.msg}
// //           </div>,
// //           document.body,
// //         )}
// //     </div>
// //   );
// // }

// import { useState, useEffect, useMemo, useCallback, useRef } from "react";
// import { createPortal } from "react-dom";
// import { Link, useOutletContext } from "react-router-dom";
// import { useLead } from "../../hooks/useLead";
// import { LEAD_SOURCES } from "../../utils/constants";
// import { formatDate } from "../../utils/format";
// import AppConfirmDialog from "../../components/common/AppConfirmDialog";
// import LeadForm from "../../components/lead/LeadForm";
// import Icon from "../../components/Icon";

// const STATUS_BG = {
//   "New Lead": "bg-blue-100 text-blue-700",
//   NotContacted: "bg-gray-100 text-gray-600",
//   Contacted: "bg-indigo-100 text-indigo-700",
//   Working: "bg-cyan-100 text-cyan-700",
//   "Qualified Lead": "bg-purple-100 text-purple-700",
//   QuotationSent: "bg-orange-100 text-orange-700",
//   Negotiation: "bg-yellow-100 text-yellow-700",
//   Converted: "bg-emerald-100 text-emerald-700",
//   Won: "bg-emerald-100 text-emerald-700",
//   Lost: "bg-red-100 text-red-700",
//   Open: "bg-blue-100 text-blue-700",
//   "On Hold": "bg-gray-100 text-gray-600",
// };
// const SOURCE_BG = {
//   Website: "bg-sky-100 text-sky-700",
//   Indiamart: "bg-orange-100 text-orange-700",
//   Referral: "bg-violet-100 text-violet-700",
//   "Cold Call": "bg-slate-100 text-slate-600",
//   Email: "bg-blue-100 text-blue-700",
//   "Social Media": "bg-pink-100 text-pink-700",
//   "Trade Show": "bg-amber-100 text-amber-700",
//   Advertisement: "bg-lime-100 text-lime-700",
//   Other: "bg-gray-100 text-gray-500",
// };
// const GRADE_BG = {
//   A: "bg-emerald-100 text-emerald-700 border-emerald-200",
//   B: "bg-blue-100 text-blue-700 border-blue-200",
//   C: "bg-amber-100 text-amber-700 border-amber-200",
//   D: "bg-red-100 text-red-700 border-red-200",
// };
// const KANBAN_HEADER = {
//   "New Lead": "border-blue-400",
//   Contacted: "border-indigo-400",
//   Working: "border-cyan-400",
//   "Qualified Lead": "border-purple-400",
//   Won: "border-emerald-400",
//   Lost: "border-red-400",
// };
// const KANBAN_STATUSES = [
//   "New Lead",
//   "Contacted",
//   "Working",
//   "Qualified Lead",
//   "Won",
//   "Lost",
// ];
// const STATUS_TABS = [
//   "All",
//   "New Lead",
//   "Contacted",
//   "Working",
//   "Qualified Lead",
//   "Won",
//   "Lost",
// ];
// const AVATAR_COLORS = [
//   "bg-blue-100 text-blue-700",
//   "bg-violet-100 text-violet-700",
//   "bg-emerald-100 text-emerald-700",
//   "bg-amber-100 text-amber-700",
//   "bg-rose-100 text-rose-700",
//   "bg-cyan-100 text-cyan-700",
// ];

// function avatarColor(name) {
//   return AVATAR_COLORS[(name?.charCodeAt(0) || 0) % AVATAR_COLORS.length];
// }

// function timeAgo(dateStr) {
//   if (!dateStr) return "—";
//   const diff = Date.now() - new Date(dateStr).getTime();
//   const mins = Math.floor(diff / 60000);
//   if (mins < 1) return "just now";
//   if (mins < 60) return `${mins}m ago`;
//   const hrs = Math.floor(mins / 60);
//   if (hrs < 24) return `${hrs}h ago`;
//   const days = Math.floor(hrs / 24);
//   if (days < 30) return `${days}d ago`;
//   return `${Math.floor(days / 30)}mo ago`;
// }

// export default function LeadListPage() {
//   const { getAll, create, update, remove, getAllScores, exportLeads, importLeads } =
//     useLead();
//   const leadFormRef = useRef(null);
//   const fileInputRef = useRef(null);

//   const [allLeads, setAllLeads] = useState([]);
//   const [scores, setScores] = useState([]);
//   const [loading, setLoading] = useState(false);
//   const [activeStatus, setActiveStatus] = useState("All");
//   const [searchQuery, setSearchQuery] = useState("");
//   const [sourceFilter, setSourceFilter] = useState("");
//   const [gradeFilter, setGradeFilter] = useState("");
//   const [dateFrom, setDateFrom] = useState("");
//   const [dateTo, setDateTo] = useState("");
//   const [sortKey, setSortKey] = useState("leadCreatedDate");
//   const [sortDir, setSortDir] = useState("desc");
//   const [currentView, setCurrentView] = useState("table");
//   const [pageSize, setPageSize] = useState(25);
//   const [currentPage, setCurrentPage] = useState(1);

//   const [panelLead, setPanelLead] = useState(null);
//   const [showPanel, setShowPanel] = useState(false);

//   const [showModal, setShowModal] = useState(false);
//   const [editingLead, setEditingLead] = useState(null);
//   const [modalSaving, setModalSaving] = useState(false);

//   // Import modal states
//   const [showImportModal, setShowImportModal] = useState(false);
//   const [importFile, setImportFile] = useState(null);
//   const [importing, setImporting] = useState(false);
//   const [importPreview, setImportPreview] = useState([]);

//   const [deleteId, setDeleteId] = useState(null);
//   const [selectedIds, setSelectedIds] = useState(new Set());

//   const [toast, setToast] = useState(null);
//   const toastTimer = useRef(null);

//   function showToast(type, msg) {
//     if (toastTimer.current) clearTimeout(toastTimer.current);
//     setToast({ type, msg });
//     toastTimer.current = setTimeout(() => setToast(null), 3000);
//   }

//   const loadAll = useCallback(async () => {
//     setLoading(true);
//     try {
//       const leads = await getAll();
//       setAllLeads(leads ?? []);
//       getAllScores()
//         .then((s) => setScores(s ?? []))
//         .catch(() => {});
//     } finally {
//       setLoading(false);
//     }
//   }, []); // eslint-disable-line

//   useEffect(() => {
//     loadAll();
//   }, [loadAll]);

//   const scoresMap = useMemo(() => {
//     const m = {};
//     for (const s of scores) m[s.leadId] = s;
//     return m;
//   }, [scores]);

//   const filtersActive = useMemo(
//     () =>
//       searchQuery !== "" ||
//       sourceFilter !== "" ||
//       gradeFilter !== "" ||
//       dateFrom !== "" ||
//       dateTo !== "" ||
//       activeStatus !== "All",
//     [searchQuery, sourceFilter, gradeFilter, dateFrom, dateTo, activeStatus],
//   );

//   const filteredLeads = useMemo(() => {
//     let list = allLeads;
//     if (activeStatus !== "All")
//       list = list.filter((l) => l.leadStatus === activeStatus);
//     if (searchQuery) {
//       const q = searchQuery.toLowerCase();
//       list = list.filter(
//         (l) =>
//           `${l.leadFirstName} ${l.leadLastName ?? ""}`
//             .toLowerCase()
//             .includes(q) ||
//           (l.leadMobileNo ?? "").includes(q) ||
//           (l.leadEmail ?? "").toLowerCase().includes(q) ||
//           (l.leadOrganisationName ?? "").toLowerCase().includes(q),
//       );
//     }
//     if (sourceFilter) list = list.filter((l) => l.leadSource === sourceFilter);
//     if (gradeFilter)
//       list = list.filter((l) => scoresMap[l.leadId]?.grade === gradeFilter);
//     if (dateFrom)
//       list = list.filter(
//         (l) => l.leadCreatedDate && l.leadCreatedDate >= dateFrom,
//       );
//     if (dateTo)
//       list = list.filter(
//         (l) => l.leadCreatedDate && l.leadCreatedDate <= dateTo + "T23:59:59",
//       );

//     return [...list].sort((a, b) => {
//       let va = "",
//         vb = "";
//       if (sortKey === "leadFirstName") {
//         va = `${a.leadFirstName} ${a.leadLastName ?? ""}`.toLowerCase();
//         vb = `${b.leadFirstName} ${b.leadLastName ?? ""}`.toLowerCase();
//       } else if (sortKey === "leadStatus") {
//         va = a.leadStatus;
//         vb = b.leadStatus;
//       } else {
//         va = a.leadCreatedDate ?? "";
//         vb = b.leadCreatedDate ?? "";
//       }
//       return sortDir === "asc" ? va.localeCompare(vb) : vb.localeCompare(va);
//     });
//   }, [
//     allLeads,
//     activeStatus,
//     searchQuery,
//     sourceFilter,
//     gradeFilter,
//     dateFrom,
//     dateTo,
//     sortKey,
//     sortDir,
//     scoresMap,
//   ]);

//   const totalCount = filteredLeads.length;
//   const totalPages = Math.ceil(totalCount / pageSize);
//   const { setHeaderBadge } = useOutletContext();

//   useEffect(() => {
//     setHeaderBadge?.(totalCount);
//     return () => setHeaderBadge?.(null);
//   }, [setHeaderBadge, totalCount]);

//   const pagedLeads = useMemo(() => {
//     const start = (currentPage - 1) * pageSize;
//     return filteredLeads.slice(start, start + pageSize);
//   }, [filteredLeads, currentPage, pageSize]);

//   useEffect(() => {
//     setCurrentPage(1);
//     setSelectedIds(new Set());
//   }, [
//     searchQuery,
//     sourceFilter,
//     gradeFilter,
//     dateFrom,
//     dateTo,
//     activeStatus,
//     sortKey,
//     sortDir,
//     pageSize,
//   ]);

//   const kanbanColumns = useMemo(
//     () =>
//       KANBAN_STATUSES.map((s) => ({
//         status: s,
//         leads: filteredLeads.filter((l) => l.leadStatus === s),
//       })),
//     [filteredLeads],
//   );

//   const allPageSelected = useMemo(
//     () =>
//       pagedLeads.length > 0 &&
//       pagedLeads.every((l) => selectedIds.has(l.leadId)),
//     [pagedLeads, selectedIds],
//   );

//   function toggleSelectAll() {
//     if (allPageSelected) {
//       setSelectedIds((prev) => {
//         const n = new Set(prev);
//         pagedLeads.forEach((l) => n.delete(l.leadId));
//         return n;
//       });
//     } else {
//       setSelectedIds((prev) => {
//         const n = new Set(prev);
//         pagedLeads.forEach((l) => n.add(l.leadId));
//         return n;
//       });
//     }
//   }

//   function toggleSelect(id) {
//     setSelectedIds((prev) => {
//       const n = new Set(prev);
//       n.has(id) ? n.delete(id) : n.add(id);
//       return n;
//     });
//   }

//   function toggleSort(key) {
//     if (sortKey === key) setSortDir((d) => (d === "asc" ? "desc" : "asc"));
//     else {
//       setSortKey(key);
//       setSortDir("asc");
//     }
//   }

//   function clearFilters() {
//     setSearchQuery("");
//     setSourceFilter("");
//     setGradeFilter("");
//     setDateFrom("");
//     setDateTo("");
//     setActiveStatus("All");
//     setSortKey("leadCreatedDate");
//     setSortDir("desc");
//   }

//   async function bulkExport() {
//     const selected = allLeads.filter((l) => selectedIds.has(l.leadId));
//     const headers = [
//       "ID",
//       "Name",
//       "Mobile",
//       "Email",
//       "Organization",
//       "Status",
//       "Source",
//       "Date",
//     ];
//     const rows = selected.map((l) => [
//       l.leadId,
//       `${l.leadFirstName} ${l.leadLastName ?? ""}`.trim(),
//       l.leadMobileNo ?? "",
//       l.leadEmail ?? "",
//       l.leadOrganisationName ?? "",
//       l.leadStatus,
//       l.leadSource ?? "",
//       formatDate(l.leadCreatedDate),
//     ]);
//     const csv = [headers, ...rows].map((r) => r.join(",")).join("\n");
//     const blob = new Blob([csv], { type: "text/csv" });
//     const url = URL.createObjectURL(blob);
//     const a = document.createElement("a");
//     a.href = url;
//     a.download = "leads.csv";
//     a.click();
//     URL.revokeObjectURL(url);
//   }

//   async function bulkDelete() {
//     if (!selectedIds.size) return;
//     if (!confirm(`Delete ${selectedIds.size} selected leads?`)) return;
//     setLoading(true);
//     try {
//       await Promise.all([...selectedIds].map((id) => remove(id)));
//       showToast("success", `${selectedIds.size} leads deleted.`);
//       setSelectedIds(new Set());
//       await loadAll();
//     } catch {
//       showToast("error", "Some deletes failed.");
//     } finally {
//       setLoading(false);
//     }
//   }

//   // Handle file selection for import
//   const handleFileSelect = (e) => {
//     const file = e.target.files[0];
//     if (!file) return;

//     if (!file.name.endsWith('.csv')) {
//       showToast("error", "Please select a CSV file");
//       return;
//     }

//     setImportFile(file);

//     // Preview CSV content
//     const reader = new FileReader();
//     reader.onload = (event) => {
//       const text = event.target.result;
//       const lines = text.split('\n').slice(0, 6);
//       const preview = lines.map(line => line.split(','));
//       setImportPreview(preview);
//     };
//     reader.readAsText(file);
//   };

//   // Handle import submission
//   const handleImport = async () => {
//     if (!importFile) {
//       showToast("error", "Please select a file first");
//       return;
//     }

//     setImporting(true);
//     try {
//       const formData = new FormData();
//       formData.append("file", importFile);

//       if (importLeads) {
//         await importLeads(formData);
//         showToast("success", "Leads imported successfully");
//         setShowImportModal(false);
//         setImportFile(null);
//         setImportPreview([]);
//         await loadAll();
//       } else {
//         // Fallback: manual CSV parsing if importLeads function doesn't exist
//         const reader = new FileReader();
//         reader.onload = async (event) => {
//           const text = event.target.result;
//           const lines = text.split('\n');
//           const headers = lines[0].split(',');

//           for (let i = 1; i < lines.length; i++) {
//             if (lines[i].trim()) {
//               const values = lines[i].split(',');
//               const leadData = {};
//               headers.forEach((header, idx) => {
//                 leadData[header.trim()] = values[idx]?.trim() || '';
//               });
//               await create(leadData, {});
//             }
//           }
//           showToast("success", "Leads imported successfully");
//           setShowImportModal(false);
//           setImportFile(null);
//           setImportPreview([]);
//           await loadAll();
//         };
//         reader.readAsText(importFile);
//       }
//     } catch (error) {
//       showToast("error", "Failed to import leads");
//     } finally {
//       setImporting(false);
//     }
//   };

//   function openCreate() {
//     setEditingLead(null);
//     setShowModal(true);
//   }

//   function openEdit(lead, e) {
//     e?.stopPropagation();
//     setEditingLead({ ...lead });
//     setShowPanel(false);
//     setShowModal(true);
//   }

//   function openPanel(lead) {
//     setPanelLead(lead);
//     setShowPanel(true);
//   }

//   async function handleSave(formData) {
//     setModalSaving(true);
//     try {
//       if (editingLead?.leadId) {
//         await update(editingLead.leadId, formData, {});
//         showToast("success", "Lead updated.");
//       } else {
//         await create(formData, {});
//         showToast("success", "Lead created.");
//       }
//       setShowModal(false);
//       await loadAll();
//     } catch {
//       showToast("error", "Failed to save lead.");
//     } finally {
//       setModalSaving(false);
//     }
//   }

//   async function handleDelete() {
//     if (!deleteId) return;
//     setLoading(true);
//     try {
//       await remove(deleteId);
//       showToast("success", "Lead deleted.");
//       if (panelLead?.leadId === deleteId) setShowPanel(false);
//       await loadAll();
//     } catch {
//       showToast("error", "Failed to delete lead.");
//     } finally {
//       setDeleteId(null);
//       setLoading(false);
//     }
//   }

//   function sortIcon(key) {
//     if (sortKey !== key) return "mdi:unfold-more-horizontal";
//     return sortDir === "asc" ? "mdi:chevron-up" : "mdi:chevron-down";
//   }

//   const gradeActiveClass = (g) => {
//     if (gradeFilter !== g) return "text-gray-500 hover:bg-gray-100";
//     if (g === "A") return "bg-emerald-500 text-white";
//     if (g === "B") return "bg-blue-500 text-white";
//     if (g === "C") return "bg-amber-500 text-white";
//     if (g === "D") return "bg-red-500 text-white";
//     return "bg-gray-800 text-white";
//   };

//   return (
//     <div className="animate-fade-in flex flex-col gap-0">
//       {/* Top Bar */}
//       <div className="flex items-center justify-between gap-4 ">
//         <div className="flex items-center gap-3">
//           {/* <h1 className="text-xl font-semibold text-gray-900 leading-none">
//             Leads
//           </h1> */}
//           {/* <span className="inline-flex items-center justify-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-700 min-w-[2rem]"> */}
//           {/* {totalCount} */}
//           {/* </span> */}
//         </div>

//       </div>

//       {/* Filter Bar */}
//       <div className="  flex flex-col gap-3 mb-3">
//         {/* .. left*/}
//         <div className="flex justify-between">
//           {/* ............. */}
//            <div className="-mt- flex flex-wrap items-center gap-2">
//           {/* ..left side  */}
//           <div className="flex items-center gap-1 flex-wrap">
//             {STATUS_TABS.map((s) => (
//               <button
//                 key={s}
//                 onClick={() => setActiveStatus(s)}
//                 className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all duration-150 border ${
//                   activeStatus === s
//                     ? "bg-blue-600 text-white border-blue-600 shadow-sm"
//                     : "bg-white text-gray-600 border-gray-200 hover:border-blue-300 hover:text-blue-600"
//                 }`}
//               >
//                 {s}
//               </button>
//             ))}
//           </div>

//           <select
//             value={sourceFilter}
//             onChange={(e) => setSourceFilter(e.target.value)}
//             className="text-xs border border-gray-200 rounded-lg px-3 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
//           >
//             <option value="">All Sources</option>
//             {LEAD_SOURCES.map((src) => (
//               <option key={src} value={src}>
//                 {src}
//               </option>
//             ))}
//           </select>
//         </div>
//           <div className="flex items-center gap-2 p-4">
//           <div className="relative w-72 mr-auto">
//             <Icon
//               name="mdi:magnify"
//               className="absolute left-2.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none"
//             />
//             <input
//               type="text"
//               value={searchQuery}
//               onChange={(e) => setSearchQuery(e.target.value)}
//               placeholder="Search name, mobile, email, org..."
//               className="pl-8 pr-3 py-2 w-full text-sm border border-gray-200 rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400 placeholder-gray-400"
//             />
//           </div>

//           {/* Import Button - Now opens modal instead of Link */}
//           <button
//             onClick={() => setShowImportModal(true)}
//             className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 hover:border-gray-300 transition-colors shadow-sm"
//           >
//             <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
//             Import
//           </button>

//           <button
//             onClick={openCreate}
//             className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors shadow-sm shadow-blue-200"
//           >
//             <Icon name="mdi:plus" className="w-4 h-4" />
//             New Lead
//           </button>
//         </div></div>

//         <div className="flex flex-wrap items-center gap-2">
//           {/* .dtatennn */}
//           <div className="flex items-center gap-1">
//             <input
//               type="date"
//               value={dateFrom}
//               onChange={(e) => setDateFrom(e.target.value)}
//               className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
//             />
//             <span className="text-gray-400 text-xs">–</span>
//             <input
//               type="date"
//               value={dateTo}
//               onChange={(e) => setDateTo(e.target.value)}
//               className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
//             />
//           </div>
// {/* .gread */}
//           <div className="ml-auto flex items-center gap-1">
//             <div className="flex items-center gap-1 bg-white border border-gray-200 rounded-lg p-0.5">
//               {["", "A", "B", "C", "D"].map((g) => (
//                 <button
//                   key={g}
//                   onClick={() => setGradeFilter(g)}
//                   className={`px-2.5 py-1 rounded-md text-xs font-bold transition-all ${gradeActiveClass(g)}`}
//                 >
//                   {g === "" ? "Grade" : g}
//                 </button>
//               ))}
//             </div>

//             {filtersActive && (
//               <button
//                 onClick={clearFilters}
//                 className="text-xs text-blue-600 hover:underline font-medium flex items-center gap-1"
//               >
//                 <Icon name="mdi:close-circle-outline" className="w-3.5 h-3.5" />
//                 Clear filters
//               </button>
//             )}

//             <button
//               onClick={() => setCurrentView("table")}
//               className={`p-1.5 rounded-md transition-all ${currentView === "table" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
//               title="Table view"
//             >
//               <Icon name="mdi:table" className="w-4 h-4" />
//             </button>
//             <button
//               onClick={() => setCurrentView("kanban")}
//               className={`p-1.5 rounded-md transition-all ${currentView === "kanban" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
//               title="Kanban view"
//             >
//               <Icon name="mdi:view-column-outline" className="w-4 h-4" />
//             </button>
//           </div>
//         </div>
//       </div>

//       {/* Loading Skeleton */}
//       {loading && (
//         <div className="space-y-2">
//           <div className="h-10 bg-gray-100 rounded-lg animate-pulse" />
//           {[...Array(8)].map((_, i) => (
//             <div
//               key={i}
//               className="h-12 bg-gray-50 rounded-lg animate-pulse"
//               style={{ opacity: 1 - i * 0.08 }}
//             />
//           ))}
//         </div>
//       )}

//       {/* TABLE VIEW */}
//       {!loading && currentView === "table" && (
//         <>
//           {!filteredLeads.length ? (
//             <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
//               <div className="w-16 h-16 rounded-2xl bg-blue-50 flex items-center justify-center mb-4">
//                 <Icon
//                   name="mdi:account-search-outline"
//                   className="w-8 h-8 text-blue-400"
//                 />
//               </div>
//               <p className="text-base font-semibold text-gray-700 mb-1">
//                 No leads found
//               </p>
//               <p className="text-sm text-gray-400 mb-5">
//                 Try adjusting your filters or add a new lead.
//               </p>
//               <div className="flex gap-2">
//                 <button
//                   onClick={() => setShowImportModal(true)}
//                   className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
//                 >
//                   <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
//                   Import leads
//                 </button>
//                 <button
//                   onClick={openCreate}
//                   className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
//                 >
//                   <Icon name="mdi:plus" className="w-4 h-4" />
//                   Add manually
//                 </button>
//               </div>
//             </div>
//           ) : (
//             <div className="bg-white rounded-xl border border-gray-100 shadow-sm overflow-hidden">
//               <div className="overflow-x-auto">
//                 <table
//                   className="w-full table-fixed text-sm"
//                   style={{ minWidth: "1040px" }}
//                 >
//                   <thead>
//                     <tr className="bg-gray-50 border-b border-gray-100">
//                       <th className="w-10 pl-4 py-2.5">
//                         <input
//                           type="checkbox"
//                           checked={allPageSelected}
//                           onChange={toggleSelectAll}
//                           className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
//                         />
//                       </th>
//                       <th className="w-[22%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
//                         <button
//                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
//                           onClick={() => toggleSort("leadFirstName")}
//                         >
//                           Lead Name{" "}
//                           <Icon
//                             name={sortIcon("leadFirstName")}
//                             className="w-3.5 h-3.5"
//                           />
//                         </button>
//                       </th>
//                       <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
//                         Mobile
//                       </th>
//                       <th className="w-[11%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
//                         Source
//                       </th>
//                       <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
//                         <button
//                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
//                           onClick={() => toggleSort("leadStatus")}
//                         >
//                           Status{" "}
//                           <Icon
//                             name={sortIcon("leadStatus")}
//                             className="w-3.5 h-3.5"
//                           />
//                         </button>
//                       </th>
//                       <th className="w-[9%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
//                         Grade
//                       </th>
//                       <th className="w-[12%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden lg:table-cell">
//                         Last Activity
//                       </th>
//                       <th className="w-[10%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden xl:table-cell">
//                         <button
//                           className="flex items-center gap-1 hover:text-gray-700 transition-colors"
//                           onClick={() => toggleSort("leadCreatedDate")}
//                         >
//                           Created{" "}
//                           <Icon
//                             name={sortIcon("leadCreatedDate")}
//                             className="w-3.5 h-3.5"
//                           />
//                         </button>
//                       </th>
//                       <th className="sticky right-0 z-20 w-28 bg-gray-50 py-2.5 pl-3 pr-4 text-right text-xs font-semibold text-gray-500 uppercase tracking-wide shadow-[-8px_0_12px_rgba(15,23,42,0.04)]">
//                         Actions
//                       </th>
//                     </tr>
//                   </thead>
//                   <tbody className="divide-y divide-gray-50">
//                     {pagedLeads.map((lead, idx) => {
//                       const score = scoresMap[lead.leadId];
//                       return (
//                         <tr
//                           key={lead.leadId}
//                           className={`cursor-pointer transition-colors duration-100 ${
//                             idx % 2 === 0 ? "bg-white" : "bg-gray-50/40"
//                           } ${selectedIds.has(lead.leadId) ? "bg-blue-50/60" : "hover:bg-blue-50/40"}`}
//                           onClick={() => openPanel(lead)}
//                         >
//                           <td
//                             className="pl-4 py-2"
//                             onClick={(e) => e.stopPropagation()}
//                           >
//                             <input
//                               type="checkbox"
//                               checked={selectedIds.has(lead.leadId)}
//                               onChange={() => toggleSelect(lead.leadId)}
//                               className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
//                             />
//                           </td>
//                           <td className="px-3 py-2">
//                             <div className="flex items-center gap-2.5">
//                               <div
//                                 className={`w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
//                               >
//                                 {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
//                               </div>
//                               <div className="min-w-0">
//                                 <p className="font-medium text-gray-900 truncate leading-snug">
//                                   {lead.leadFirstName} {lead.leadLastName}
//                                 </p>
//                                 {lead.leadOrganisationName && (
//                                   <p className="text-xs text-gray-400 truncate leading-snug">
//                                     {lead.leadOrganisationName}
//                                   </p>
//                                 )}
//                               </div>
//                             </div>
//                           </td>
//                           <td
//                             className="px-3 py-2"
//                             onClick={(e) => e.stopPropagation()}
//                           >
//                             {lead.leadMobileNo ? (
//                               <a
//                                 href={`tel:${lead.leadMobileNo}`}
//                                 className="flex items-center gap-1 text-sm text-gray-700 hover:text-blue-600 transition-colors group"
//                               >
//                                 <Icon
//                                   name="mdi:phone-outline"
//                                   className="w-3.5 h-3.5 text-gray-400 group-hover:text-blue-500 shrink-0"
//                                 />
//                                 {lead.leadMobileNo}
//                               </a>
//                             ) : (
//                               <span className="text-gray-300 text-xs">—</span>
//                             )}
//                           </td>
//                           <td className="px-3 py-2">
//                             {lead.leadSource ? (
//                               <span
//                                 className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
//                               >
//                                 {lead.leadSource}
//                               </span>
//                             ) : (
//                               <span className="text-gray-300 text-xs">—</span>
//                             )}
//                           </td>
//                           <td className="px-3 py-2">
//                             <span
//                               className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[lead.leadStatus] ?? "bg-gray-100 text-gray-600"}`}
//                             >
//                               {lead.leadStatus}
//                             </span>
//                           </td>
//                           <td className="px-3 py-2">
//                             {score ? (
//                               <div className="flex items-center gap-1.5">
//                                 <span
//                                   className={`inline-flex items-center justify-center w-6 h-6 rounded-md text-xs font-bold border ${GRADE_BG[score.grade] ?? "bg-gray-100 text-gray-600"}`}
//                                 >
//                                   {score.grade}
//                                 </span>
//                                 <span className="text-xs text-gray-400 hidden xl:inline">
//                                   {score.score}
//                                 </span>
//                               </div>
//                             ) : (
//                               <span className="text-gray-300 text-xs">—</span>
//                             )}
//                           </td>
//                           <td className="px-3 py-2 hidden lg:table-cell">
//                             <span className="text-xs text-gray-400">
//                               {timeAgo(lead.leadCreatedDate)}
//                             </span>
//                           </td>
//                           <td className="px-3 py-2 hidden xl:table-cell">
//                             <span className="text-xs text-gray-500">
//                               {formatDate(lead.leadCreatedDate)}
//                             </span>
//                           </td>
//                           <td
//                             className={`sticky right-0 pl-3 pr-4 py-2 shadow-[-8px_0_12px_rgba(15,23,42,0.04)] ${selectedIds.has(lead.leadId) ? "bg-blue-50" : idx % 2 === 0 ? "bg-white" : "bg-gray-50"}`}
//                             onClick={(e) => e.stopPropagation()}
//                           >
//                             <div className="flex items-center justify-end gap-1">
//                               <Link
//                                 to={`/lead/${lead.leadId}`}
//                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-blue-50 hover:text-blue-600 transition-colors"
//                                 title="View detail"
//                               >
//                                 <Icon
//                                   name="mdi:eye-outline"
//                                   className="w-4 h-4"
//                                 />
//                               </Link>
//                               <button
//                                 onClick={(e) => openEdit(lead, e)}
//                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-amber-50 hover:text-amber-600 transition-colors"
//                                 title="Edit"
//                               >
//                                 <Icon
//                                   name="mdi:pencil-outline"
//                                   className="w-4 h-4"
//                                 />
//                               </button>
//                               <button
//                                 onClick={(e) => {
//                                   e.stopPropagation();
//                                   setDeleteId(lead.leadId);
//                                 }}
//                                 className="p-1.5 rounded-lg text-gray-400 hover:bg-red-50 hover:text-red-600 transition-colors"
//                                 title="Delete"
//                               >
//                                 <Icon
//                                   name="mdi:trash-can-outline"
//                                   className="w-4 h-4"
//                                 />
//                               </button>
//                             </div>
//                           </td>
//                         </tr>
//                       );
//                     })}
//                   </tbody>
//                 </table>
//               </div>

//               {/* Pagination */}
//               <div className="flex items-center justify-between px-4 py-3 border-t border-gray-100 bg-gray-50/50">
//                 <div className="flex items-center gap-2">
//                   <span className="text-xs text-gray-500">
//                     Showing{" "}
//                     {Math.min((currentPage - 1) * pageSize + 1, totalCount)}–
//                     {Math.min(currentPage * pageSize, totalCount)} of{" "}
//                     {totalCount}
//                   </span>
//                   <select
//                     value={pageSize}
//                     onChange={(e) => setPageSize(Number(e.target.value))}
//                     className="text-xs border border-gray-200 rounded-md px-1.5 py-1 bg-white text-gray-600 focus:outline-none focus:ring-1 focus:ring-blue-500"
//                   >
//                     <option value={25}>25</option>
//                     <option value={50}>50</option>
//                     <option value={100}>100</option>
//                   </select>
//                   <span className="text-xs text-gray-400">per page</span>
//                 </div>
//                 <div className="flex items-center gap-1">
//                   <button
//                     disabled={currentPage <= 1}
//                     onClick={() => setCurrentPage((p) => p - 1)}
//                     className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
//                   >
//                     <Icon name="mdi:chevron-left" className="w-4 h-4" />
//                   </button>
//                   {[...Array(totalPages)].map((_, i) => {
//                     const p = i + 1;
//                     if (
//                       p === 1 ||
//                       p === totalPages ||
//                       (p >= currentPage - 1 && p <= currentPage + 1)
//                     ) {
//                       return (
//                         <button
//                           key={p}
//                           onClick={() => setCurrentPage(p)}
//                           className={`w-8 h-8 rounded-lg text-xs font-medium transition-colors ${
//                             p === currentPage
//                               ? "bg-blue-600 text-white"
//                               : "border border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
//                           }`}
//                         >
//                           {p}
//                         </button>
//                       );
//                     }
//                     if (p === currentPage - 2 || p === currentPage + 2) {
//                       return (
//                         <span key={p} className="px-1 text-gray-400 text-xs">
//                           …
//                         </span>
//                       );
//                     }
//                     return null;
//                   })}
//                   <button
//                     disabled={currentPage >= totalPages}
//                     onClick={() => setCurrentPage((p) => p + 1)}
//                     className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
//                   >
//                     <Icon name="mdi:chevron-right" className="w-4 h-4" />
//                   </button>
//                 </div>
//               </div>
//             </div>
//           )}
//         </>
//       )}

//       {/* KANBAN VIEW */}
//       {!loading && currentView === "kanban" && (
//         <>
//           {!filteredLeads.length ? (
//             <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
//               <Icon
//                 name="mdi:view-column-outline"
//                 className="w-12 h-12 text-gray-300 mb-3"
//               />
//               <p className="text-sm font-medium text-gray-500">
//                 No leads to display
//               </p>
//               <button
//                 onClick={openCreate}
//                 className="mt-4 inline-flex items-center gap-1 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
//               >
//                 <Icon name="mdi:plus" className="w-4 h-4" />
//                 Add Lead
//               </button>
//             </div>
//           ) : (
//             <div className="flex gap-3 overflow-x-auto pb-3">
//               {kanbanColumns.map((col) => (
//                 <div
//                   key={col.status}
//                   className="flex-none w-64 flex flex-col gap-2"
//                 >
//                   <div
//                     className={`flex items-center justify-between px-3 py-2 bg-white rounded-xl border-t-2 shadow-sm ${KANBAN_HEADER[col.status] ?? "border-gray-300"}`}
//                   >
//                     <div className="flex items-center gap-2">
//                       <span
//                         className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[col.status] ?? "bg-gray-100 text-gray-600"}`}
//                       >
//                         {col.status}
//                       </span>
//                       <span className="text-xs text-gray-400 font-medium">
//                         {col.leads.length}
//                       </span>
//                     </div>
//                     <button
//                       onClick={openCreate}
//                       className="p-1 rounded-lg text-gray-400 hover:bg-gray-100 transition-colors"
//                     >
//                       <Icon name="mdi:plus" className="w-4 h-4" />
//                     </button>
//                   </div>
//                   <div className="flex flex-col gap-2 max-h-[calc(100vh-260px)] overflow-y-auto">
//                     {col.leads.map((lead) => {
//                       const score = scoresMap[lead.leadId];
//                       return (
//                         <div
//                           key={lead.leadId}
//                           className="bg-white rounded-xl border border-gray-100 shadow-sm p-3 cursor-pointer hover:shadow-md hover:border-blue-200 transition-all group"
//                           onClick={() => openPanel(lead)}
//                         >
//                           <div className="flex items-start justify-between gap-2 mb-2">
//                             <div className="flex items-center gap-2 min-w-0">
//                               <div
//                                 className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
//                               >
//                                 {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
//                               </div>
//                               <div className="min-w-0">
//                                 <p className="text-xs font-semibold text-gray-900 truncate leading-snug">
//                                   {lead.leadFirstName} {lead.leadLastName}
//                                 </p>
//                                 {lead.leadOrganisationName && (
//                                   <p className="text-[10px] text-gray-400 truncate">
//                                     {lead.leadOrganisationName}
//                                   </p>
//                                 )}
//                               </div>
//                             </div>
//                             {score && (
//                               <span
//                                 className={`inline-flex items-center justify-center w-5 h-5 rounded text-[10px] font-bold border shrink-0 ${GRADE_BG[score.grade]}`}
//                               >
//                                 {score.grade}
//                               </span>
//                             )}
//                           </div>
//                           <div className="flex items-center justify-between mt-2">
//                             {lead.leadSource ? (
//                               <span
//                                 className={`text-[10px] px-1.5 py-0.5 rounded-full font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
//                               >
//                                 {lead.leadSource}
//                               </span>
//                             ) : (
//                               <span className="text-[10px] text-gray-300">
//                                 —
//                               </span>
//                             )}
//                             <span className="text-[10px] text-gray-400">
//                               {timeAgo(lead.leadCreatedDate)}
//                             </span>
//                           </div>
//                           <div className="flex items-center gap-1 mt-2 opacity-0 group-hover:opacity-100 transition-opacity">
//                             <Link
//                               to={`/lead/${lead.leadId}`}
//                               className="p-1 rounded text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors"
//                               onClick={(e) => e.stopPropagation()}
//                             >
//                               <Icon
//                                 name="mdi:eye-outline"
//                                 className="w-3.5 h-3.5"
//                               />
//                             </Link>
//                             <button
//                               className="p-1 rounded text-gray-400 hover:text-amber-600 hover:bg-amber-50 transition-colors"
//                               onClick={(e) => openEdit(lead, e)}
//                             >
//                               <Icon
//                                 name="mdi:pencil-outline"
//                                 className="w-3.5 h-3.5"
//                               />
//                             </button>
//                             <button
//                               className="p-1 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
//                               onClick={(e) => {
//                                 e.stopPropagation();
//                                 setDeleteId(lead.leadId);
//                               }}
//                             >
//                               <Icon
//                                 name="mdi:trash-can-outline"
//                                 className="w-3.5 h-3.5"
//                               />
//                             </button>
//                           </div>
//                         </div>
//                       );
//                     })}
//                     {!col.leads.length && (
//                       <div className="flex flex-col items-center justify-center py-6 rounded-xl border border-dashed border-gray-200 text-gray-400 text-xs">
//                         <Icon
//                           name="mdi:inbox-outline"
//                           className="w-6 h-6 mb-1"
//                         />
//                         No leads
//                       </div>
//                     )}
//                   </div>
//                 </div>
//               ))}
//             </div>
//           )}
//         </>
//       )}

//       {/* Import Modal */}
//       {showImportModal &&
//         createPortal(
//           <div className="fixed inset-0 z-50 flex items-center justify-center">
//             <div
//               className="absolute inset-0 bg-black/50 backdrop-blur-sm"
//               onClick={() => {
//                 setShowImportModal(false);
//                 setImportFile(null);
//                 setImportPreview([]);
//               }}
//             />
//             <div className="relative w-full max-w-lg bg-white rounded-2xl shadow-2xl overflow-hidden">
//               <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 bg-gradient-to-r from-blue-600 to-indigo-600">
//                 <div className="flex items-center gap-2">
//                   <Icon name="mdi:cloud-upload" className="w-5 h-5 text-white" />
//                   <h2 className="text-lg font-semibold text-white">Import Leads</h2>
//                 </div>
//                 <button
//                   onClick={() => {
//                     setShowImportModal(false);
//                     setImportFile(null);
//                     setImportPreview([]);
//                   }}
//                   className="p-1.5 rounded-lg text-white/70 hover:bg-white/20 transition-colors"
//                 >
//                   <Icon name="mdi:close" className="w-5 h-5" />
//                 </button>
//               </div>

//               <div className="p-6 space-y-4">
//                 <div className="bg-blue-50 rounded-lg p-3 text-sm text-blue-700">
//                   <Icon name="mdi:information" className="w-4 h-4 inline mr-1" />
//                   Upload a CSV file with the following columns: First Name, Last Name, Email, Mobile, Organization, Source, Status
//                 </div>

//                 <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-400 transition-colors">
//                   <input
//                     ref={fileInputRef}
//                     type="file"
//                     accept=".csv"
//                     onChange={handleFileSelect}
//                     className="hidden"
//                   />
//                   <Icon name="mdi:file-delimited-outline" className="w-12 h-12 text-gray-400 mx-auto mb-3" />
//                   <p className="text-sm text-gray-600 mb-2">
//                     {importFile ? importFile.name : "Click to select a CSV file"}
//                   </p>
//                   <button
//                     onClick={() => fileInputRef.current?.click()}
//                     className="text-sm text-blue-600 hover:text-blue-700 font-medium"
//                   >
//                     Choose File
//                   </button>
//                 </div>

//                 {importPreview.length > 0 && (
//                   <div className="bg-gray-50 rounded-lg p-3">
//                     <p className="text-xs font-semibold text-gray-600 mb-2">Preview:</p>
//                     <div className="overflow-x-auto">
//                       <table className="text-xs">
//                         <tbody>
//                           {importPreview.map((row, idx) => (
//                             <tr key={idx}>
//                               {row.map((cell, cellIdx) => (
//                                 <td key={cellIdx} className="px-2 py-1 border border-gray-200">
//                                   {cell}
//                                 </td>
//                               ))}
//                             </tr>
//                           ))}
//                         </tbody>
//                       </table>
//                     </div>
//                   </div>
//                 )}
//               </div>

//               <div className="flex justify-end gap-3 px-6 py-4 border-t border-gray-100 bg-gray-50">
//                 <button
//                   onClick={() => {
//                     setShowImportModal(false);
//                     setImportFile(null);
//                     setImportPreview([]);
//                   }}
//                   className="px-4 py-2 rounded-lg border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-100 transition-colors"
//                 >
//                   Cancel
//                 </button>
//                 <button
//                   onClick={handleImport}
//                   disabled={!importFile || importing}
//                   className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
//                 >
//                   {importing ? (
//                     <Icon name="mdi:loading" className="w-4 h-4 animate-spin" />
//                   ) : (
//                     <Icon name="mdi:cloud-upload" className="w-4 h-4" />
//                   )}
//                   {importing ? "Importing..." : "Import"}
//                 </button>
//               </div>
//             </div>
//           </div>,
//           document.body,
//         )}

//       {/* Bulk action bar */}
//       {selectedIds.size > 0 &&
//         createPortal(
//           <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-40 flex items-center gap-3 px-5 py-3 bg-gray-900 text-white rounded-2xl shadow-2xl shadow-gray-900/40">
//             <span className="text-sm font-semibold">
//               {selectedIds.size} selected
//             </span>
//             <div className="w-px h-4 bg-white/20" />
//             <button
//               onClick={bulkExport}
//               className="flex items-center gap-1.5 text-sm text-gray-300 hover:text-white transition-colors"
//             >
//               <Icon name="mdi:download-outline" className="w-4 h-4" />
//               Export CSV
//             </button>
//             <button
//               onClick={bulkDelete}
//               className="flex items-center gap-1.5 text-sm text-red-400 hover:text-red-300 transition-colors"
//             >
//               <Icon name="mdi:trash-can-outline" className="w-4 h-4" />
//               Delete
//             </button>
//             <button
//               onClick={() => setSelectedIds(new Set())}
//               className="ml-1 p-1 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
//             >
//               <Icon name="mdi:close" className="w-4 h-4" />
//             </button>
//           </div>,
//           document.body,
//         )}

//       {/* Right slide-over panel */}
//       {showPanel &&
//         panelLead &&
//         createPortal(
//           <div className="fixed inset-0 z-50 flex justify-end">
//             <div
//               className="absolute inset-0 bg-black/30 backdrop-blur-sm"
//               onClick={() => setShowPanel(false)}
//             />
//             <div className="relative w-full max-w-[480px] h-full bg-white shadow-2xl flex flex-col overflow-hidden">
//               <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 shrink-0">
//                 <div className="flex items-center gap-3">
//                   <div
//                     className={`w-10 h-10 rounded-xl flex items-center justify-center text-sm font-bold ${avatarColor(panelLead.leadFirstName)}`}
//                   >
//                     {(panelLead.leadFirstName?.[0] ?? "?").toUpperCase()}
//                   </div>
//                   <div>
//                     <p className="text-base font-semibold text-gray-900 leading-snug">
//                       {panelLead.leadFirstName} {panelLead.leadLastName}
//                     </p>
//                     {panelLead.leadOrganisationName && (
//                       <p className="text-xs text-gray-400">
//                         {panelLead.leadOrganisationName}
//                       </p>
//                     )}
//                   </div>
//                 </div>
//                 <button
//                   onClick={() => setShowPanel(false)}
//                   className="p-1.5 rounded-lg text-gray-400 hover:bg-gray-100 hover:text-gray-600 transition-colors"
//                 >
//                   <Icon name="mdi:close" className="w-5 h-5" />
//                 </button>
//               </div>

//               <div className="flex-1 overflow-y-auto p-5 space-y-5">
//                 <div className="flex flex-wrap items-center gap-2">
//                   <span
//                     className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${STATUS_BG[panelLead.leadStatus] ?? "bg-gray-100 text-gray-600"}`}
//                   >
//                     {panelLead.leadStatus}
//                   </span>
//                   {panelLead.leadSource && (
//                     <span
//                       className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${SOURCE_BG[panelLead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
//                     >
//                       {panelLead.leadSource}
//                     </span>
//                   )}
//                   {scoresMap[panelLead.leadId] && (
//                     <span
//                       className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-bold border ${GRADE_BG[scoresMap[panelLead.leadId].grade]}`}
//                     >
//                       Grade {scoresMap[panelLead.leadId].grade} ·{" "}
//                       {scoresMap[panelLead.leadId].score}/100
//                     </span>
//                   )}
//                 </div>

//                 <div className="bg-gray-50 rounded-xl p-4 space-y-3">
//                   <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">
//                     Contact Info
//                   </p>
//                   {panelLead.leadMobileNo && (
//                     <div className="flex items-center gap-2.5">
//                       <Icon
//                         name="mdi:phone-outline"
//                         className="w-4 h-4 text-gray-400 shrink-0"
//                       />
//                       <a
//                         href={`tel:${panelLead.leadMobileNo}`}
//                         className="text-sm text-gray-700 hover:text-blue-600 transition-colors"
//                       >
//                         {panelLead.leadMobileNo}
//                       </a>
//                     </div>
//                   )}
//                   {panelLead.leadEmail && (
//                     <div className="flex items-center gap-2.5">
//                       <Icon
//                         name="mdi:email-outline"
//                         className="w-4 h-4 text-gray-400 shrink-0"
//                       />
//                       <a
//                         href={`mailto:${panelLead.leadEmail}`}
//                         className="text-sm text-gray-700 hover:text-blue-600 transition-colors truncate"
//                       >
//                         {panelLead.leadEmail}
//                       </a>
//                     </div>
//                   )}
//                   {panelLead.leadWebsite && (
//                     <div className="flex items-center gap-2.5">
//                       <Icon
//                         name="mdi:web"
//                         className="w-4 h-4 text-gray-400 shrink-0"
//                       />
//                       <a
//                         href={panelLead.leadWebsite}
//                         target="_blank"
//                         rel="noopener noreferrer"
//                         className="text-sm text-blue-600 hover:underline truncate"
//                       >
//                         {panelLead.leadWebsite}
//                       </a>
//                     </div>
//                   )}
//                   {(panelLead.leadCity ||
//                     panelLead.leadState ||
//                     panelLead.leadCountry) && (
//                     <div className="flex items-center gap-2.5">
//                       <Icon
//                         name="mdi:map-marker-outline"
//                         className="w-4 h-4 text-gray-400 shrink-0"
//                       />
//                       <span className="text-sm text-gray-700">
//                         {[
//                           panelLead.leadCity,
//                           panelLead.leadState,
//                           panelLead.leadCountry,
//                         ]
//                           .filter(Boolean)
//                           .join(", ")}
//                       </span>
//                     </div>
//                   )}
//                 </div>

//                 {(panelLead.leadOrganisationName ||
//                   panelLead.leadIndustry ||
//                   panelLead.noOfEmployee) && (
//                   <div className="bg-gray-50 rounded-xl p-4 space-y-3">
//                     <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">
//                       Company
//                     </p>
//                     {panelLead.leadOrganisationName && (
//                       <div className="flex items-center gap-2.5">
//                         <Icon
//                           name="mdi:office-building-outline"
//                           className="w-4 h-4 text-gray-400 shrink-0"
//                         />
//                         <span className="text-sm text-gray-700">
//                           {panelLead.leadOrganisationName}
//                         </span>
//                       </div>
//                     )}
//                     {panelLead.leadIndustry && (
//                       <div className="flex items-center gap-2.5">
//                         <Icon
//                           name="mdi:domain"
//                           className="w-4 h-4 text-gray-400 shrink-0"
//                         />
//                         <span className="text-sm text-gray-700">
//                           {panelLead.leadIndustry}
//                         </span>
//                       </div>
//                     )}
//                     {panelLead.noOfEmployee && (
//                       <div className="flex items-center gap-2.5">
//                         <Icon
//                           name="mdi:account-group-outline"
//                           className="w-4 h-4 text-gray-400 shrink-0"
//                         />
//                         <span className="text-sm text-gray-700">
//                           {panelLead.noOfEmployee} employees
//                         </span>
//                       </div>
//                     )}
//                   </div>
//                 )}

//                 <div className="grid grid-cols-2 gap-3">
//                   <div className="bg-gray-50 rounded-xl p-3">
//                     <p className="text-xs text-gray-400 mb-1">Created</p>
//                     <p className="text-sm font-medium text-gray-700">
//                       {formatDate(panelLead.leadCreatedDate)}
//                     </p>
//                   </div>
//                   {panelLead.inquiryDate && (
//                     <div className="bg-gray-50 rounded-xl p-3">
//                       <p className="text-xs text-gray-400 mb-1">Inquiry Date</p>
//                       <p className="text-sm font-medium text-gray-700">
//                         {formatDate(panelLead.inquiryDate)}
//                       </p>
//                     </div>
//                   )}
//                 </div>

//                 {scoresMap[panelLead.leadId]?.topFactors?.length > 0 && (
//                   <div className="bg-blue-50/60 rounded-xl p-4">
//                     <p className="text-xs font-semibold text-blue-600 uppercase tracking-wide mb-3 flex items-center gap-1.5">
//                       <Icon name="mdi:brain" className="w-4 h-4" />
//                       AI Score Factors
//                     </p>
//                     <div className="space-y-1.5">
//                       {scoresMap[panelLead.leadId].topFactors.map((factor) => (
//                         <div
//                           key={factor}
//                           className="flex items-center gap-2 text-xs text-gray-600"
//                         >
//                           <Icon
//                             name="mdi:check-circle"
//                             className="w-3.5 h-3.5 text-blue-500 shrink-0"
//                           />
//                           {factor}
//                         </div>
//                       ))}
//                     </div>
//                   </div>
//                 )}

//                 {panelLead.leadReason && (
//                   <div className="bg-gray-50 rounded-xl p-4">
//                     <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2">
//                       Notes
//                     </p>
//                     <p className="text-sm text-gray-700 leading-relaxed">
//                       {panelLead.leadReason}
//                     </p>
//                   </div>
//                 )}
//               </div>

//               <div className="px-5 py-4 border-t border-gray-100 flex items-center gap-2 bg-gray-50/50 shrink-0">
//                 <Link
//                   to={`/lead/${panelLead.leadId}`}
//                   className="flex-1 inline-flex items-center justify-center gap-1.5 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
//                 >
//                   <Icon name="mdi:open-in-new" className="w-4 h-4" />
//                   Full Detail
//                 </Link>
//                 <button
//                   onClick={() => openEdit(panelLead)}
//                   className="flex-1 inline-flex items-center justify-center gap-1.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
//                 >
//                   <Icon name="mdi:pencil-outline" className="w-4 h-4" />
//                   Edit Lead
//                 </button>
//                 <button
//                   onClick={() => {
//                     setDeleteId(panelLead.leadId);
//                     setShowPanel(false);
//                   }}
//                   className="p-2 rounded-lg border border-gray-200 text-gray-400 hover:bg-red-50 hover:text-red-600 hover:border-red-200 transition-colors"
//                   title="Delete"
//                 >
//                   <Icon name="mdi:trash-can-outline" className="w-4 h-4" />
//                 </button>
//               </div>
//             </div>
//           </div>,
//           document.body,
//         )}

//       {/* Create / Edit Slide-over */}
//       {showModal &&
//         createPortal(
//           <div className="fixed inset-0 z-50 flex justify-end">
//             <div
//               className="absolute inset-0 bg-black/30 backdrop-blur-[2px]"
//               onClick={() => setShowModal(false)}
//             />
//             <div className="relative w-full max-w-[640px] h-full bg-white shadow-2xl flex flex-col">
//               <div className="flex items-center gap-3 px-6 py-5 border-b border-gray-100 bg-gradient-to-r from-blue-600 to-indigo-600 shrink-0">
//                 <div className="w-9 h-9 rounded-xl bg-white/20 flex items-center justify-center shrink-0">
//                   <Icon
//                     name={
//                       editingLead
//                         ? "mdi:pencil-outline"
//                         : "mdi:account-plus-outline"
//                     }
//                     className="w-5 h-5 text-white"
//                   />
//                 </div>
//                 <div className="flex-1 min-w-0">
//                   <h2 className="text-base font-bold text-white leading-tight">
//                     {editingLead ? "Edit Lead" : "New Lead"}
//                   </h2>
//                   <p className="text-xs text-blue-100 mt-0.5">
//                     {editingLead
//                       ? `Updating: ${editingLead.leadFirstName} ${editingLead.leadLastName ?? ""}`
//                       : "Fill in the details to create a new lead"}
//                   </p>
//                 </div>
//                 <button
//                   onClick={() => setShowModal(false)}
//                   className="w-8 h-8 rounded-lg flex items-center justify-center text-white/70 hover:bg-white/20 hover:text-white transition-colors"
//                 >
//                   <Icon name="mdi:close" className="w-5 h-5" />
//                 </button>
//               </div>
//               <div className="flex-1 overflow-y-auto px-6 py-6">
//                 <LeadForm
//                   key={editingLead?.leadId ?? "create"}
//                   ref={leadFormRef}
//                   initial={editingLead}
//                   loading={modalSaving}
//                   onSubmit={handleSave}
//                 />
//               </div>
//               <div className="flex items-center justify-between gap-3 px-6 py-4 border-t border-gray-100 bg-gray-50/70 shrink-0">
//                 <div className="text-xs text-gray-400">
//                   <span className="text-red-500">*</span> Required fields
//                 </div>
//                 <div className="flex items-center gap-2">
//                   <button
//                     onClick={() => setShowModal(false)}
//                     className="px-5 py-2.5 rounded-lg border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-100 transition-colors"
//                   >
//                     Cancel
//                   </button>
//                   <button
//                     type="button"
//                     onClick={() =>
//                       document.getElementById("lead-form")?.requestSubmit?.()
//                     }
//                     disabled={modalSaving}
//                     className="inline-flex items-center gap-2 px-6 py-2.5 rounded-lg bg-blue-600 text-sm font-semibold text-white hover:bg-blue-700 disabled:opacity-60 transition-colors shadow-sm"
//                   >
//                     {modalSaving ? (
//                       <Icon
//                         name="mdi:loading"
//                         className="w-4 h-4 animate-spin"
//                       />
//                     ) : (
//                       <Icon
//                         name={
//                           editingLead
//                             ? "mdi:check-circle-outline"
//                             : "mdi:plus-circle-outline"
//                         }
//                         className="w-4 h-4"
//                       />
//                     )}
//                     {modalSaving
//                       ? "Saving…"
//                       : editingLead
//                         ? "Update Lead"
//                         : "Create Lead"}
//                   </button>
//                 </div>
//               </div>
//             </div>
//           </div>,
//           document.body,
//         )}

//       <AppConfirmDialog
//         open={deleteId !== null}
//         title="Delete Lead"
//         message="Are you sure you want to delete this lead? This action cannot be undone."
//         onConfirm={handleDelete}
//         onCancel={() => setDeleteId(null)}
//       />

//       {/* Toast */}
//       {toast &&
//         createPortal(
//           <div
//             className={`fixed bottom-6 right-6 z-[60] flex items-center gap-2.5 px-4 py-3 rounded-xl shadow-lg text-sm font-medium ${
//               toast.type === "success"
//                 ? "bg-emerald-600 text-white"
//                 : "bg-red-600 text-white"
//             }`}
//           >
//             <Icon
//               name={
//                 toast.type === "success"
//                   ? "mdi:check-circle"
//                   : "mdi:alert-circle"
//               }
//               className="w-5 h-5 shrink-0"
//             />
//             {toast.msg}
//           </div>,
//           document.body,
//         )}
//     </div>
//   );
// }

import { useState, useEffect, useMemo, useCallback, useRef } from "react";
import { createPortal } from "react-dom";
import { Link, useOutletContext } from "react-router-dom";
import { useLead } from "../../hooks/useLead";
import { LEAD_SOURCES } from "../../utils/constants";
import { formatDate } from "../../utils/format";
import AppConfirmDialog from "../../components/common/AppConfirmDialog";
import LeadForm from "../../components/lead/LeadForm";
import Icon from "../../components/Icon";

const STATUS_BG = {
  "New Lead": "bg-blue-100 text-blue-700",
  NotContacted: "bg-gray-100 text-gray-600",
  Contacted: "bg-indigo-100 text-indigo-700",
  Working: "bg-cyan-100 text-cyan-700",
  "Qualified Lead": "bg-purple-100 text-purple-700",
  QuotationSent: "bg-orange-100 text-orange-700",
  Negotiation: "bg-yellow-100 text-yellow-700",
  Converted: "bg-emerald-100 text-emerald-700",
  Won: "bg-emerald-100 text-emerald-700",
  Lost: "bg-red-100 text-red-700",
  Open: "bg-blue-100 text-blue-700",
  "On Hold": "bg-gray-100 text-gray-600",
};
const SOURCE_BG = {
  Website: "bg-sky-100 text-sky-700",
  Indiamart: "bg-orange-100 text-orange-700",
  Referral: "bg-violet-100 text-violet-700",
  "Cold Call": "bg-slate-100 text-slate-600",
  Email: "bg-blue-100 text-blue-700",
  "Social Media": "bg-pink-100 text-pink-700",
  "Trade Show": "bg-amber-100 text-amber-700",
  Advertisement: "bg-lime-100 text-lime-700",
  Other: "bg-gray-100 text-gray-500",
};
const GRADE_BG = {
  A: "bg-emerald-100 text-emerald-700 border-emerald-200",
  B: "bg-blue-100 text-blue-700 border-blue-200",
  C: "bg-amber-100 text-amber-700 border-amber-200",
  D: "bg-red-100 text-red-700 border-red-200",
};
const KANBAN_HEADER = {
  "New Lead": "border-blue-400",
  Contacted: "border-indigo-400",
  Working: "border-cyan-400",
  "Qualified Lead": "border-purple-400",
  Won: "border-emerald-400",
  Lost: "border-red-400",
};
const KANBAN_STATUSES = [
  "New Lead",
  "Contacted",
  "Working",
  "Qualified Lead",
  "Won",
  "Lost",
];
const STATUS_TABS = [
  "All",
  "New Lead",
  "Contacted",
  "Working",
  "Qualified Lead",
  "Won",
  "Lost",
];
const AVATAR_COLORS = [
  "bg-blue-100 text-blue-700",
  "bg-violet-100 text-violet-700",
  "bg-emerald-100 text-emerald-700",
  "bg-amber-100 text-amber-700",
  "bg-rose-100 text-rose-700",
  "bg-cyan-100 text-cyan-700",
];

function avatarColor(name) {
  return AVATAR_COLORS[(name?.charCodeAt(0) || 0) % AVATAR_COLORS.length];
}

function timeAgo(dateStr) {
  if (!dateStr) return "—";
  const diff = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return "just now";
  if (mins < 60) return `${mins}m ago`;
  const hrs = Math.floor(mins / 60);
  if (hrs < 24) return `${hrs}h ago`;
  const days = Math.floor(hrs / 24);
  if (days < 30) return `${days}d ago`;
  return `${Math.floor(days / 30)}mo ago`;
}

export default function LeadListPage() {
  const { getAll, create, update, remove, getAllScores, exportLeads } =
    useLead();
  const leadFormRef = useRef(null);
  const fileInputRef = useRef(null);

  const [allLeads, setAllLeads] = useState([]);
  const [scores, setScores] = useState([]);
  const [loading, setLoading] = useState(false);
  const [activeStatus, setActiveStatus] = useState("All");
  const [searchQuery, setSearchQuery] = useState("");
  const [sourceFilter, setSourceFilter] = useState("");
  const [gradeFilter, setGradeFilter] = useState("");
  const [dateFrom, setDateFrom] = useState("");
  const [dateTo, setDateTo] = useState("");
  const [sortKey, setSortKey] = useState("leadCreatedDate");
  const [sortDir, setSortDir] = useState("desc");
  const [currentView, setCurrentView] = useState("table");
  const [pageSize, setPageSize] = useState(25);
  const [currentPage, setCurrentPage] = useState(1);

  const [panelLead, setPanelLead] = useState(null);
  const [showPanel, setShowPanel] = useState(false);

  const [showModal, setShowModal] = useState(false);
  const [editingLead, setEditingLead] = useState(null);
  const [modalSaving, setModalSaving] = useState(false);

  // Import modal states
  const [showImportModal, setShowImportModal] = useState(false);
  const [importFile, setImportFile] = useState(null);
  const [importing, setImporting] = useState(false);
  const [importPreview, setImportPreview] = useState([]);
  const [importProgress, setImportProgress] = useState({
    current: 0,
    total: 0,
  });

  const [deleteId, setDeleteId] = useState(null);
  const [selectedIds, setSelectedIds] = useState(new Set());

  const [toast, setToast] = useState(null);
  const toastTimer = useRef(null);

  function showToast(type, msg) {
    if (toastTimer.current) clearTimeout(toastTimer.current);
    setToast({ type, msg });
    toastTimer.current = setTimeout(() => setToast(null), 3000);
  }

  const loadAll = useCallback(async () => {
    setLoading(true);
    try {
      const leads = await getAll();
      setAllLeads(leads ?? []);
      getAllScores()
        .then((s) => setScores(s ?? []))
        .catch(() => {});
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadAll();
  }, [loadAll]);

  const scoresMap = useMemo(() => {
    const m = {};
    for (const s of scores) m[s.leadId] = s;
    return m;
  }, [scores]);

  const filtersActive = useMemo(
    () =>
      searchQuery !== "" ||
      sourceFilter !== "" ||
      gradeFilter !== "" ||
      dateFrom !== "" ||
      dateTo !== "" ||
      activeStatus !== "All",
    [searchQuery, sourceFilter, gradeFilter, dateFrom, dateTo, activeStatus],
  );

  const filteredLeads = useMemo(() => {
    let list = allLeads;
    if (activeStatus !== "All")
      list = list.filter((l) => l.leadStatus === activeStatus);
    if (searchQuery) {
      const q = searchQuery.toLowerCase();
      list = list.filter(
        (l) =>
          `${l.leadFirstName} ${l.leadLastName ?? ""}`
            .toLowerCase()
            .includes(q) ||
          (l.leadMobileNo ?? "").includes(q) ||
          (l.leadEmail ?? "").toLowerCase().includes(q) ||
          (l.leadOrganisationName ?? "").toLowerCase().includes(q),
      );
    }
    if (sourceFilter) list = list.filter((l) => l.leadSource === sourceFilter);
    if (gradeFilter)
      list = list.filter((l) => scoresMap[l.leadId]?.grade === gradeFilter);
    if (dateFrom)
      list = list.filter(
        (l) => l.leadCreatedDate && l.leadCreatedDate >= dateFrom,
      );
    if (dateTo)
      list = list.filter(
        (l) => l.leadCreatedDate && l.leadCreatedDate <= dateTo + "T23:59:59",
      );

    return [...list].sort((a, b) => {
      let va = "",
        vb = "";
      if (sortKey === "leadFirstName") {
        va = `${a.leadFirstName} ${a.leadLastName ?? ""}`.toLowerCase();
        vb = `${b.leadFirstName} ${b.leadLastName ?? ""}`.toLowerCase();
      } else if (sortKey === "leadStatus") {
        va = a.leadStatus;
        vb = b.leadStatus;
      } else {
        va = a.leadCreatedDate ?? "";
        vb = b.leadCreatedDate ?? "";
      }
      return sortDir === "asc" ? va.localeCompare(vb) : vb.localeCompare(va);
    });
  }, [
    allLeads,
    activeStatus,
    searchQuery,
    sourceFilter,
    gradeFilter,
    dateFrom,
    dateTo,
    sortKey,
    sortDir,
    scoresMap,
  ]);

  const totalCount = filteredLeads.length;
  const totalPages = Math.ceil(totalCount / pageSize);
  const { setHeaderBadge } = useOutletContext();

  useEffect(() => {
    setHeaderBadge?.(totalCount);
    return () => setHeaderBadge?.(null);
  }, [setHeaderBadge, totalCount]);

  const pagedLeads = useMemo(() => {
    const start = (currentPage - 1) * pageSize;
    return filteredLeads.slice(start, start + pageSize);
  }, [filteredLeads, currentPage, pageSize]);

  useEffect(() => {
    setCurrentPage(1);
    setSelectedIds(new Set());
  }, [
    searchQuery,
    sourceFilter,
    gradeFilter,
    dateFrom,
    dateTo,
    activeStatus,
    sortKey,
    sortDir,
    pageSize,
  ]);

  const kanbanColumns = useMemo(
    () =>
      KANBAN_STATUSES.map((s) => ({
        status: s,
        leads: filteredLeads.filter((l) => l.leadStatus === s),
      })),
    [filteredLeads],
  );

  const allPageSelected = useMemo(
    () =>
      pagedLeads.length > 0 &&
      pagedLeads.every((l) => selectedIds.has(l.leadId)),
    [pagedLeads, selectedIds],
  );

  function toggleSelectAll() {
    if (allPageSelected) {
      setSelectedIds((prev) => {
        const n = new Set(prev);
        pagedLeads.forEach((l) => n.delete(l.leadId));
        return n;
      });
    } else {
      setSelectedIds((prev) => {
        const n = new Set(prev);
        pagedLeads.forEach((l) => n.add(l.leadId));
        return n;
      });
    }
  }

  function toggleSelect(id) {
    setSelectedIds((prev) => {
      const n = new Set(prev);
      n.has(id) ? n.delete(id) : n.add(id);
      return n;
    });
  }

  function toggleSort(key) {
    if (sortKey === key) setSortDir((d) => (d === "asc" ? "desc" : "asc"));
    else {
      setSortKey(key);
      setSortDir("asc");
    }
  }

  function clearFilters() {
    setSearchQuery("");
    setSourceFilter("");
    setGradeFilter("");
    setDateFrom("");
    setDateTo("");
    setActiveStatus("All");
    setSortKey("leadCreatedDate");
    setSortDir("desc");
  }

  async function bulkExport() {
    const selected = allLeads.filter((l) => selectedIds.has(l.leadId));
    const headers = [
      "First Name",
      "Last Name",
      "Mobile",
      "Email",
      "Organization",
      "Status",
      "Source",
      "Date",
    ];
    const rows = selected.map((l) => [
      l.leadFirstName ?? "",
      l.leadLastName ?? "",
      l.leadMobileNo ?? "",
      l.leadEmail ?? "",
      l.leadOrganisationName ?? "",
      l.leadStatus ?? "",
      l.leadSource ?? "",
      formatDate(l.leadCreatedDate),
    ]);
    const csv = [headers, ...rows].map((r) => r.join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `leads_export_${new Date().toISOString().split("T")[0]}.csv`;
    a.click();
    URL.revokeObjectURL(url);
    showToast("success", "Export completed");
  }

  async function bulkDelete() {
    if (!selectedIds.size) return;
    if (!confirm(`Delete ${selectedIds.size} selected leads?`)) return;
    setLoading(true);
    try {
      await Promise.all([...selectedIds].map((id) => remove(id)));
      showToast("success", `${selectedIds.size} leads deleted.`);
      setSelectedIds(new Set());
      await loadAll();
    } catch {
      showToast("error", "Some deletes failed.");
    } finally {
      setLoading(false);
    }
  }

  // Handle file selection for import
  const handleFileSelect = (e) => {
    const file = e.target.files[0];
    if (!file) return;

    if (!file.name.endsWith(".csv") && !file.name.endsWith(".xlsx")) {
      showToast("error", "Please select a CSV file");
      return;
    }

    setImportFile(file);

    // Preview CSV content
    const reader = new FileReader();
    reader.onload = (event) => {
      const text = event.target.result;
      const lines = text.split("\n").slice(0, 6);
      const preview = lines.map((line) => line.split(","));
      setImportPreview(preview);
    };
    reader.readAsText(file);
  };

  // Parse CSV line properly (handles quoted values)
  const parseCSVLine = (line) => {
    const result = [];
    let inQuotes = false;
    let currentValue = "";

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        inQuotes = !inQuotes;
      } else if (char === "," && !inQuotes) {
        result.push(currentValue.trim());
        currentValue = "";
      } else {
        currentValue += char;
      }
    }
    result.push(currentValue.trim());
    return result;
  };

  // Map CSV headers to lead fields
  const mapCSVToLead = (headers, values) => {
    const leadData = {};

    // Define header mappings (case insensitive)
    const fieldMappings = {
      "first name": "leadFirstName",
      firstname: "leadFirstName",
      first_name: "leadFirstName",
      "last name": "leadLastName",
      lastname: "leadLastName",
      last_name: "leadLastName",
      name: "leadFirstName",
      mobile: "leadMobileNo",
      phone: "leadMobileNo",
      contact: "leadMobileNo",
      email: "leadEmail",
      "email address": "leadEmail",
      organization: "leadOrganisationName",
      company: "leadOrganisationName",
      organisation: "leadOrganisationName",
      status: "leadStatus",
      "lead status": "leadStatus",
      source: "leadSource",
      "lead source": "leadSource",
    };

    headers.forEach((header, index) => {
      const normalizedHeader = header
        .toLowerCase()
        .trim()
        .replace(/^["']|["']$/g, "");
      const mappedField = fieldMappings[normalizedHeader];
      if (mappedField && values[index]) {
        leadData[mappedField] = values[index]
          .replace(/^["']|["']$/g, "")
          .trim();
      }
    });

    // Set default status if not provided
    if (!leadData.leadStatus) {
      leadData.leadStatus = "New Lead";
    }

    return leadData;
  };

  // Handle import submission
  const handleImport = async () => {
    if (!importFile) {
      showToast("error", "Please select a file first");
      return;
    }

    setImporting(true);
    setImportProgress({ current: 0, total: 0 });

    try {
      const reader = new FileReader();

      reader.onload = async (event) => {
        const text = event.target.result;
        const lines = text.split("\n").filter((line) => line.trim());

        if (lines.length < 2) {
          showToast("error", "CSV file is empty or invalid");
          setImporting(false);
          return;
        }

        // Parse headers
        const headers = parseCSVLine(lines[0]);
        let successCount = 0;
        let errorCount = 0;

        setImportProgress({ current: 0, total: lines.length - 1 });

        // Process each row (skip header)
        for (let i = 1; i < lines.length; i++) {
          try {
            const values = parseCSVLine(lines[i]);
            const leadData = mapCSVToLead(headers, values);

            // Validate required fields
            if (
              !leadData.leadFirstName &&
              !leadData.leadMobileNo &&
              !leadData.leadEmail
            ) {
              errorCount++;
              continue;
            }

            // Create lead
            await create(leadData, {});
            successCount++;
            setImportProgress({ current: i, total: lines.length - 1 });
          } catch (error) {
            errorCount++;
            console.error("Error importing row:", error);
          }
        }

        // Show result
        if (successCount > 0) {
          showToast(
            "success",
            `Imported ${successCount} leads successfully${errorCount > 0 ? `, ${errorCount} failed` : ""}`,
          );
          await loadAll();
        } else {
          showToast(
            "error",
            "No leads were imported. Please check your CSV format.",
          );
        }

        setShowImportModal(false);
        setImportFile(null);
        setImportPreview([]);
        setImporting(false);
        setImportProgress({ current: 0, total: 0 });
      };

      reader.onerror = () => {
        showToast("error", "Failed to read file");
        setImporting(false);
      };

      reader.readAsText(importFile);
    } catch (error) {
      showToast("error", "Failed to import leads: " + error.message);
      setImporting(false);
    }
  };

  function openCreate() {
    setEditingLead(null);
    setShowModal(true);
  }

  function openEdit(lead, e) {
  if (e) {
    e.stopPropagation();
  }
  console.log("Opening edit for lead:", lead); // Debug log
  setEditingLead({ ...lead });
  setShowPanel(false);
  setShowModal(true);
}
  function openPanel(lead) {
    setPanelLead(lead);
    setShowPanel(true);
  }

  async function handleSave(formData) {
    setModalSaving(true);
    try {
      if (editingLead?.leadId) {
        await update(editingLead.leadId, formData, {});
        showToast("success", "Lead updated.");
      } else {
        await create(formData, {});
        showToast("success", "Lead created.");
      }
      setShowModal(false);
      await loadAll();
    } catch {
      showToast("error", "Failed to save lead.");
    } finally {
      setModalSaving(false);
    }
  }

  async function handleDelete() {
    if (!deleteId) return;
    setLoading(true);
    try {
      await remove(deleteId);
      showToast("success", "Lead deleted.");
      if (panelLead?.leadId === deleteId) setShowPanel(false);
      await loadAll();
    } catch {
      showToast("error", "Failed to delete lead.");
    } finally {
      setDeleteId(null);
      setLoading(false);
    }
  }

  function sortIcon(key) {
    if (sortKey !== key) return "mdi:unfold-more-horizontal";
    return sortDir === "asc" ? "mdi:chevron-up" : "mdi:chevron-down";
  }

  const gradeActiveClass = (g) => {
    if (gradeFilter !== g) return "text-gray-500 hover:bg-gray-100";
    if (g === "A") return "bg-emerald-500 text-white";
    if (g === "B") return "bg-blue-500 text-white";
    if (g === "C") return "bg-amber-500 text-white";
    if (g === "D") return "bg-red-500 text-white";
    return "bg-gray-800 text-white";
  };

  // Download sample CSV template
  const downloadSampleCSV = () => {
    const headers = [
      "First Name",
      "Last Name",
      "Mobile",
      "Email",
      "Organization",
      "Status",
      "Source",
    ];
    const sampleRow = [
      "John",
      "Doe",
      "9876543210",
      "john@example.com",
      "ABC Corp",
      "New Lead",
      "Website",
    ];
    const csv = [headers, sampleRow].map((row) => row.join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "sample_leads_import.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="animate-fade-in flex flex-col gap-0">
      {/* Filter Bar */}
      <div className="flex flex-col gap-3 mb-3">
        <div className="flex justify-between">
          <div className="flex flex-wrap items-center gap-2">
            <div className="flex items-center gap-1 flex-wrap">
              {STATUS_TABS.map((s) => (
                <button
                  key={s}
                  onClick={() => setActiveStatus(s)}
                  className={`px-3 py-1.5 rounded-full text-xs font-semibold transition-all duration-150 border ${
                    activeStatus === s
                      ? "bg-blue-600 text-white border-blue-600 shadow-sm"
                      : "bg-white text-gray-600 border-gray-200 hover:border-blue-300 hover:text-blue-600"
                  }`}
                >
                  {s}
                </button>
              ))}
            </div>

            <select
              value={sourceFilter}
              onChange={(e) => setSourceFilter(e.target.value)}
              className="text-xs border border-gray-200 rounded-lg px-3 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
            >
              <option value="">All Sources</option>
              {LEAD_SOURCES.map((src) => (
                <option key={src} value={src}>
                  {src}
                </option>
              ))}
            </select>
          </div>

          <div className="flex items-center gap-2">
            <div className="relative w-72">
              <Icon
                name="mdi:magnify"
                className="absolute left-2.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none"
              />
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Search name, mobile, email, org..."
                className="pl-8 pr-3 py-2 w-full text-sm border border-gray-200 rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400 placeholder-gray-400"
              />
            </div>

            <button
              onClick={() => setShowImportModal(true)}
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 hover:border-gray-300 transition-colors shadow-sm"
            >
              <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
              Import
            </button>

            <button
              onClick={openCreate}
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors shadow-sm shadow-blue-200"
            >
              <Icon name="mdi:plus" className="w-4 h-4" />
              New Lead
            </button>
          </div>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          <div className="flex items-center gap-1">
            <input
              type="date"
              value={dateFrom}
              onChange={(e) => setDateFrom(e.target.value)}
              className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
            />
            <span className="text-gray-400 text-xs">–</span>
            <input
              type="date"
              value={dateTo}
              onChange={(e) => setDateTo(e.target.value)}
              className="text-xs border border-gray-200 rounded-lg px-2.5 py-1.5 bg-white text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400"
            />
          </div>

          <div className="ml-auto flex items-center gap-1">
            <div className="flex items-center gap-1 bg-white border border-gray-200 rounded-lg p-0.5">
              {["", "A", "B", "C", "D"].map((g) => (
                <button
                  key={g}
                  onClick={() => setGradeFilter(g)}
                  className={`px-2.5 py-1 rounded-md text-xs font-bold transition-all ${gradeActiveClass(g)}`}
                >
                  {g === "" ? "Grade" : g}
                </button>
              ))}
            </div>

            {filtersActive && (
              <button
                onClick={clearFilters}
                className="text-xs text-blue-600 hover:underline font-medium flex items-center gap-1"
              >
                <Icon name="mdi:close-circle-outline" className="w-3.5 h-3.5" />
                Clear filters
              </button>
            )}

            <button
              onClick={() => setCurrentView("table")}
              className={`p-1.5 rounded-md transition-all ${currentView === "table" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
              title="Table view"
            >
              <Icon name="mdi:table" className="w-4 h-4" />
            </button>
            <button
              onClick={() => setCurrentView("kanban")}
              className={`p-1.5 rounded-md transition-all ${currentView === "kanban" ? "bg-blue-600 text-white shadow-sm" : "text-gray-500 hover:bg-gray-100"}`}
              title="Kanban view"
            >
              <Icon name="mdi:view-column-outline" className="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      {/* Loading Skeleton */}
      {loading && (
        <div className="space-y-2">
          <div className="h-10 bg-gray-100 rounded-lg animate-pulse" />
          {[...Array(8)].map((_, i) => (
            <div
              key={i}
              className="h-12 bg-gray-50 rounded-lg animate-pulse"
              style={{ opacity: 1 - i * 0.08 }}
            />
          ))}
        </div>
      )}

      {/* TABLE VIEW */}
      {!loading && currentView === "table" && (
        <>
          {!filteredLeads.length ? (
            <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
              <div className="w-16 h-16 rounded-2xl bg-blue-50 flex items-center justify-center mb-4">
                <Icon
                  name="mdi:account-search-outline"
                  className="w-8 h-8 text-blue-400"
                />
              </div>
              <p className="text-base font-semibold text-gray-700 mb-1">
                No leads found
              </p>
              <p className="text-sm text-gray-400 mb-5">
                Try adjusting your filters or add a new lead.
              </p>
              <div className="flex gap-2">
                <button
                  onClick={() => setShowImportModal(true)}
                  className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg border border-gray-200 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
                >
                  <Icon name="mdi:cloud-upload-outline" className="w-4 h-4" />
                  Import leads
                </button>
                <button
                  onClick={openCreate}
                  className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
                >
                  <Icon name="mdi:plus" className="w-4 h-4" />
                  Add manually
                </button>
              </div>
            </div>
          ) : (
            <div className="bg-white rounded-xl border border-gray-100 shadow-sm overflow-hidden">
              <div className="overflow-x-auto">
                <table
                  className="w-full table-fixed text-sm"
                  style={{ minWidth: "1040px" }}
                >
                  <thead>
                    <tr className="bg-gray-50 border-b border-gray-100">
                      <th className="w-10 pl-4 py-2.5">
                        <input
                          type="checkbox"
                          checked={allPageSelected}
                          onChange={toggleSelectAll}
                          className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                        />
                      </th>
                      <th className="w-[22%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        <button
                          className="flex items-center gap-1 hover:text-gray-700 transition-colors"
                          onClick={() => toggleSort("leadFirstName")}
                        >
                          Lead Name{" "}
                          <Icon
                            name={sortIcon("leadFirstName")}
                            className="w-3.5 h-3.5"
                          />
                        </button>
                      </th>
                      <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        Mobile
                      </th>
                      <th className="w-[11%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        Source
                      </th>
                      <th className="w-[14%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        <button
                          className="flex items-center gap-1 hover:text-gray-700 transition-colors"
                          onClick={() => toggleSort("leadStatus")}
                        >
                          Status{" "}
                          <Icon
                            name={sortIcon("leadStatus")}
                            className="w-3.5 h-3.5"
                          />
                        </button>
                      </th>
                      <th className="w-[9%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        Grade
                      </th>
                      <th className="w-[12%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden lg:table-cell">
                        Last Activity
                      </th>
                      <th className="w-[10%] py-2.5 px-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide hidden xl:table-cell">
                        <button
                          className="flex items-center gap-1 hover:text-gray-700 transition-colors"
                          onClick={() => toggleSort("leadCreatedDate")}
                        >
                          Created{" "}
                          <Icon
                            name={sortIcon("leadCreatedDate")}
                            className="w-3.5 h-3.5"
                          />
                        </button>
                      </th>
                      <th className="sticky right-0 z-20 w-28 bg-gray-50 py-2.5 pl-3 pr-4 text-right text-xs font-semibold text-gray-500 uppercase tracking-wide shadow-[-8px_0_12px_rgba(15,23,42,0.04)]">
                        Actions
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-50">
                    {pagedLeads.map((lead, idx) => {
                      const score = scoresMap[lead.leadId];
                      return (
                        <tr
                          key={lead.leadId}
                          className={`cursor-pointer transition-colors duration-100 ${
                            idx % 2 === 0 ? "bg-white" : "bg-gray-50/40"
                          } ${selectedIds.has(lead.leadId) ? "bg-blue-50/60" : "hover:bg-blue-50/40"}`}
                          onClick={() => openPanel(lead)}
                        >
                          <td
                            className="pl-4 py-2"
                            onClick={(e) => e.stopPropagation()}
                          >
                            <input
                              type="checkbox"
                              checked={selectedIds.has(lead.leadId)}
                              onChange={() => toggleSelect(lead.leadId)}
                              className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                            />
                          </td>
                          <td className="px-3 py-2">
                            <div className="flex items-center gap-2.5">
                              <div
                                className={`w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
                              >
                                {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
                              </div>
                              <div className="min-w-0">
                                <p className="font-medium text-gray-900 truncate leading-snug">
                                  {lead.leadFirstName} {lead.leadLastName}
                                </p>
                                {lead.leadOrganisationName && (
                                  <p className="text-xs text-gray-400 truncate leading-snug">
                                    {lead.leadOrganisationName}
                                  </p>
                                )}
                              </div>
                            </div>
                          </td>
                          <td
                            className="px-3 py-2"
                            onClick={(e) => e.stopPropagation()}
                          >
                            {lead.leadMobileNo ? (
                              <a
                                href={`tel:${lead.leadMobileNo}`}
                                className="flex items-center gap-1 text-sm text-gray-700 hover:text-blue-600 transition-colors group"
                              >
                                <Icon
                                  name="mdi:phone-outline"
                                  className="w-3.5 h-3.5 text-gray-400 group-hover:text-blue-500 shrink-0"
                                />
                                {lead.leadMobileNo}
                              </a>
                            ) : (
                              <span className="text-gray-300 text-xs">—</span>
                            )}
                          </td>
                          <td className="px-3 py-2">
                            {lead.leadSource ? (
                              <span
                                className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
                              >
                                {lead.leadSource}
                              </span>
                            ) : (
                              <span className="text-gray-300 text-xs">—</span>
                            )}
                          </td>
                          <td className="px-3 py-2">
                            <span
                              className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[lead.leadStatus] ?? "bg-gray-100 text-gray-600"}`}
                            >
                              {lead.leadStatus}
                            </span>
                          </td>
                          <td className="px-3 py-2">
                            {score ? (
                              <div className="flex items-center gap-1.5">
                                <span
                                  className={`inline-flex items-center justify-center w-6 h-6 rounded-md text-xs font-bold border ${GRADE_BG[score.grade] ?? "bg-gray-100 text-gray-600"}`}
                                >
                                  {score.grade}
                                </span>
                                <span className="text-xs text-gray-400 hidden xl:inline">
                                  {score.score}
                                </span>
                              </div>
                            ) : (
                              <span className="text-gray-300 text-xs">—</span>
                            )}
                          </td>
                          <td className="px-3 py-2 hidden lg:table-cell">
                            <span className="text-xs text-gray-400">
                              {timeAgo(lead.leadCreatedDate)}
                            </span>
                          </td>
                          <td className="px-3 py-2 hidden xl:table-cell">
                            <span className="text-xs text-gray-500">
                              {formatDate(lead.leadCreatedDate)}
                            </span>
                          </td>
                          <td
                            className={`sticky right-0 pl-3 pr-4 py-2 shadow-[-8px_0_12px_rgba(15,23,42,0.04)] ${selectedIds.has(lead.leadId) ? "bg-blue-50" : idx % 2 === 0 ? "bg-white" : "bg-gray-50"}`}
                            onClick={(e) => e.stopPropagation()}
                          >
                            <div className="flex items-center justify-end gap-1">
                              <Link
                                to={`/lead/${lead.leadId}`}
                                className="p-1.5 rounded-lg text-gray-400 hover:bg-blue-50 hover:text-blue-600 transition-colors"
                                title="View detail"
                              >
                                <Icon
                                  name="mdi:eye-outline"
                                  className="w-4 h-4"
                                />
                              </Link>
                              <button
                                onClick={(e) => openEdit(lead, e)}
                                className="p-1.5 rounded-lg text-gray-400 hover:bg-amber-50 hover:text-amber-600 transition-colors"
                                title="Edit"
                              >
                                <Icon
                                  name="mdi:pencil-outline"
                                  className="w-4 h-4"
                                />
                              </button>
                              <button
                                onClick={(e) => {
                                  e.stopPropagation();
                                  setDeleteId(lead.leadId);
                                }}
                                className="p-1.5 rounded-lg text-gray-400 hover:bg-red-50 hover:text-red-600 transition-colors"
                                title="Delete"
                              >
                                <Icon
                                  name="mdi:trash-can-outline"
                                  className="w-4 h-4"
                                />
                              </button>
                            </div>
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>

              {/* Pagination */}
              <div className="flex items-center justify-between px-4 py-3 border-t border-gray-100 bg-gray-50/50">
                <div className="flex items-center gap-2">
                  <span className="text-xs text-gray-500">
                    Showing{" "}
                    {Math.min((currentPage - 1) * pageSize + 1, totalCount)}–
                    {Math.min(currentPage * pageSize, totalCount)} of{" "}
                    {totalCount}
                  </span>
                  <select
                    value={pageSize}
                    onChange={(e) => setPageSize(Number(e.target.value))}
                    className="text-xs border border-gray-200 rounded-md px-1.5 py-1 bg-white text-gray-600 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  >
                    <option value={25}>25</option>
                    <option value={50}>50</option>
                    <option value={100}>100</option>
                  </select>
                  <span className="text-xs text-gray-400">per page</span>
                </div>
                <div className="flex items-center gap-1">
                  <button
                    disabled={currentPage <= 1}
                    onClick={() => setCurrentPage((p) => p - 1)}
                    className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                  >
                    <Icon name="mdi:chevron-left" className="w-4 h-4" />
                  </button>
                  {[...Array(totalPages)].map((_, i) => {
                    const p = i + 1;
                    if (
                      p === 1 ||
                      p === totalPages ||
                      (p >= currentPage - 1 && p <= currentPage + 1)
                    ) {
                      return (
                        <button
                          key={p}
                          onClick={() => setCurrentPage(p)}
                          className={`w-8 h-8 rounded-lg text-xs font-medium transition-colors ${
                            p === currentPage
                              ? "bg-blue-600 text-white"
                              : "border border-gray-200 bg-white text-gray-600 hover:bg-gray-50"
                          }`}
                        >
                          {p}
                        </button>
                      );
                    }
                    if (p === currentPage - 2 || p === currentPage + 2) {
                      return (
                        <span key={p} className="px-1 text-gray-400 text-xs">
                          …
                        </span>
                      );
                    }
                    return null;
                  })}
                  <button
                    disabled={currentPage >= totalPages}
                    onClick={() => setCurrentPage((p) => p + 1)}
                    className="p-1.5 rounded-lg border border-gray-200 bg-white text-gray-500 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                  >
                    <Icon name="mdi:chevron-right" className="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          )}
        </>
      )}

      {/* KANBAN VIEW */}
      {!loading && currentView === "kanban" && (
        <>
          {!filteredLeads.length ? (
            <div className="flex flex-col items-center justify-center py-20 bg-white rounded-xl border border-gray-100 shadow-sm">
              <Icon
                name="mdi:view-column-outline"
                className="w-12 h-12 text-gray-300 mb-3"
              />
              <p className="text-sm font-medium text-gray-500">
                No leads to display
              </p>
              <button
                onClick={openCreate}
                className="mt-4 inline-flex items-center gap-1 px-3.5 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
              >
                <Icon name="mdi:plus" className="w-4 h-4" />
                Add Lead
              </button>
            </div>
          ) : (
            <div className="flex gap-3 overflow-x-auto pb-3">
              {kanbanColumns.map((col) => (
                <div
                  key={col.status}
                  className="flex-none w-64 flex flex-col gap-2"
                >
                  <div
                    className={`flex items-center justify-between px-3 py-2 bg-white rounded-xl border-t-2 shadow-sm ${KANBAN_HEADER[col.status] ?? "border-gray-300"}`}
                  >
                    <div className="flex items-center gap-2">
                      <span
                        className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold ${STATUS_BG[col.status] ?? "bg-gray-100 text-gray-600"}`}
                      >
                        {col.status}
                      </span>
                      <span className="text-xs text-gray-400 font-medium">
                        {col.leads.length}
                      </span>
                    </div>
                    <button
                      onClick={openCreate}
                      className="p-1 rounded-lg text-gray-400 hover:bg-gray-100 transition-colors"
                    >
                      <Icon name="mdi:plus" className="w-4 h-4" />
                    </button>
                  </div>
                  <div className="flex flex-col gap-2 max-h-[calc(100vh-260px)] overflow-y-auto">
                    {col.leads.map((lead) => {
                      const score = scoresMap[lead.leadId];
                      return (
                        <div
                          key={lead.leadId}
                          className="bg-white rounded-xl border border-gray-100 shadow-sm p-3 cursor-pointer hover:shadow-md hover:border-blue-200 transition-all group"
                          onClick={() => openPanel(lead)}
                        >
                          <div className="flex items-start justify-between gap-2 mb-2">
                            <div className="flex items-center gap-2 min-w-0">
                              <div
                                className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${avatarColor(lead.leadFirstName)}`}
                              >
                                {(lead.leadFirstName?.[0] ?? "?").toUpperCase()}
                              </div>
                              <div className="min-w-0">
                                <p className="text-xs font-semibold text-gray-900 truncate leading-snug">
                                  {lead.leadFirstName} {lead.leadLastName}
                                </p>
                                {lead.leadOrganisationName && (
                                  <p className="text-[10px] text-gray-400 truncate">
                                    {lead.leadOrganisationName}
                                  </p>
                                )}
                              </div>
                            </div>
                            {score && (
                              <span
                                className={`inline-flex items-center justify-center w-5 h-5 rounded text-[10px] font-bold border shrink-0 ${GRADE_BG[score.grade]}`}
                              >
                                {score.grade}
                              </span>
                            )}
                          </div>
                          <div className="flex items-center justify-between mt-2">
                            {lead.leadSource ? (
                              <span
                                className={`text-[10px] px-1.5 py-0.5 rounded-full font-medium ${SOURCE_BG[lead.leadSource] ?? "bg-gray-100 text-gray-500"}`}
                              >
                                {lead.leadSource}
                              </span>
                            ) : (
                              <span className="text-[10px] text-gray-300">
                                —
                              </span>
                            )}
                            <span className="text-[10px] text-gray-400">
                              {timeAgo(lead.leadCreatedDate)}
                            </span>
                          </div>
                          <div className="flex items-center gap-1 mt-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <Link
                              to={`/lead/${lead.leadId}`}
                              className="p-1 rounded text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors"
                              onClick={(e) => e.stopPropagation()}
                            >
                              <Icon
                                name="mdi:eye-outline"
                                className="w-3.5 h-3.5"
                              />
                            </Link>
                            <button
                              className="p-1 rounded text-gray-400 hover:text-amber-600 hover:bg-amber-50 transition-colors"
                              onClick={(e) => openEdit(lead, e)}
                            >
                              <Icon
                                name="mdi:pencil-outline"
                                className="w-3.5 h-3.5"
                              />
                            </button>
                            <button
                              className="p-1 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                              onClick={(e) => {
                                e.stopPropagation();
                                setDeleteId(lead.leadId);
                              }}
                            >
                              <Icon
                                name="mdi:trash-can-outline"
                                className="w-3.5 h-3.5"
                              />
                            </button>
                          </div>
                        </div>
                      );
                    })}
                    {!col.leads.length && (
                      <div className="flex flex-col items-center justify-center py-6 rounded-xl border border-dashed border-gray-200 text-gray-400 text-xs">
                        <Icon
                          name="mdi:inbox-outline"
                          className="w-6 h-6 mb-1"
                        />
                        No leads
                      </div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </>
      )}

      {/* Import Modal */}
      {showImportModal &&
        createPortal(
          <div className="fixed inset-0 z-50 flex items-center justify-center">
            <div
              className="absolute inset-0 bg-black/50 backdrop-blur-sm"
              onClick={() => {
                setShowImportModal(false);
                setImportFile(null);
                setImportPreview([]);
              }}
            />
            <div className="relative w-full max-w-lg bg-white rounded-2xl shadow-2xl overflow-hidden">
              <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 bg-gradient-to-r from-blue-600 to-indigo-600">
                <div className="flex items-center gap-2">
                  <Icon
                    name="mdi:cloud-upload"
                    className="w-5 h-5 text-white"
                  />
                  <h2 className="text-lg font-semibold text-white">
                    Import Leads
                  </h2>
                </div>
                <button
                  onClick={() => {
                    setShowImportModal(false);
                    setImportFile(null);
                    setImportPreview([]);
                  }}
                  className="p-1.5 rounded-lg text-white/70 hover:bg-white/20 transition-colors"
                >
                  <Icon name="mdi:close" className="w-5 h-5" />
                </button>
              </div>

              <div className="p-6 space-y-4">
                <div className="bg-blue-50 rounded-lg p-3 text-sm text-blue-700">
                  <Icon
                    name="mdi:information"
                    className="w-4 h-4 inline mr-1"
                  />
                  Upload a CSV file with the following columns: First Name, Last
                  Name, Mobile, Email, Organization, Status, Source
                </div>

                {/* Download Sample Template */}
                <button
                  onClick={downloadSampleCSV}
                  className="text-sm text-blue-600 hover:text-blue-700 font-medium flex items-center gap-1"
                >
                  <Icon name="mdi:download" className="w-4 h-4" />
                  Download Sample CSV Template
                </button>

                <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-400 transition-colors">
                  <input
                    ref={fileInputRef}
                    type="file"
                    accept=".csv"
                    onChange={handleFileSelect}
                    className="hidden"
                  />
                  <Icon
                    name="mdi:file-delimited-outline"
                    className="w-12 h-12 text-gray-400 mx-auto mb-3"
                  />
                  <p className="text-sm text-gray-600 mb-2">
                    {importFile
                      ? importFile.name
                      : "Click to select a CSV file"}
                  </p>
                  <button
                    onClick={() => fileInputRef.current?.click()}
                    className="text-sm text-blue-600 hover:text-blue-700 font-medium"
                  >
                    Choose File
                  </button>
                </div>

                {importPreview.length > 0 && (
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-xs font-semibold text-gray-600 mb-2">
                      Preview:
                    </p>
                    <div className="overflow-x-auto">
                      <table className="text-xs">
                        <tbody>
                          {importPreview.map((row, idx) => (
                            <tr key={idx}>
                              {row.map((cell, cellIdx) => (
                                <td
                                  key={cellIdx}
                                  className="px-2 py-1 border border-gray-200"
                                >
                                  {cell}
                                </td>
                              ))}
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}

                {/* Import Progress */}
                {importing && importProgress.total > 0 && (
                  <div className="bg-gray-50 rounded-lg p-3">
                    <div className="flex justify-between text-xs text-gray-600 mb-1">
                      <span>Importing...</span>
                      <span>
                        {importProgress.current} / {importProgress.total}
                      </span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-1.5">
                      <div
                        className="bg-blue-600 h-1.5 rounded-full transition-all duration-300"
                        style={{
                          width: `${(importProgress.current / importProgress.total) * 100}%`,
                        }}
                      />
                    </div>
                  </div>
                )}
              </div>

              <div className="flex justify-end gap-3 px-6 py-4 border-t border-gray-100 bg-gray-50">
                <button
                  onClick={() => {
                    setShowImportModal(false);
                    setImportFile(null);
                    setImportPreview([]);
                  }}
                  disabled={importing}
                  className="px-4 py-2 rounded-lg border border-gray-200 text-sm font-medium text-gray-600 hover:bg-gray-100 transition-colors disabled:opacity-50"
                >
                  Cancel
                </button>
                <button
                  onClick={handleImport}
                  disabled={!importFile || importing}
                  className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-sm font-medium text-white hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  {importing ? (
                    <Icon name="mdi:loading" className="w-4 h-4 animate-spin" />
                  ) : (
                    <Icon name="mdi:cloud-upload" className="w-4 h-4" />
                  )}
                  {importing
                    ? `Importing ${importProgress.current}/${importProgress.total}`
                    : "Import"}
                </button>
              </div>
            </div>
          </div>,
          document.body,
        )}

      {/* Bulk action bar */}
      {selectedIds.size > 0 &&
        createPortal(
          <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-40 flex items-center gap-3 px-5 py-3 bg-gray-900 text-white rounded-2xl shadow-2xl shadow-gray-900/40">
            <span className="text-sm font-semibold">
              {selectedIds.size} selected
            </span>
            <div className="w-px h-4 bg-white/20" />
            <button
              onClick={bulkExport}
              className="flex items-center gap-1.5 text-sm text-gray-300 hover:text-white transition-colors"
            >
              <Icon name="mdi:download-outline" className="w-4 h-4" />
              Export CSV
            </button>
            <button
              onClick={bulkDelete}
              className="flex items-center gap-1.5 text-sm text-red-400 hover:text-red-300 transition-colors"
            >
              <Icon name="mdi:trash-can-outline" className="w-4 h-4" />
              Delete
            </button>
            <button
              onClick={() => setSelectedIds(new Set())}
              className="ml-1 p-1 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
            >
              <Icon name="mdi:close" className="w-4 h-4" />
            </button>
          </div>,
          document.body,
        )}

      <AppConfirmDialog
        open={deleteId !== null}
        title="Delete Lead"
        message="Are you sure you want to delete this lead? This action cannot be undone."
        onConfirm={handleDelete}
        onCancel={() => setDeleteId(null)}
      />

      {/* Toast */}
      {toast &&
        createPortal(
          <div
            className={`fixed bottom-6 right-6 z-[60] flex items-center gap-2.5 px-4 py-3 rounded-xl shadow-lg text-sm font-medium ${
              toast.type === "success"
                ? "bg-emerald-600 text-white"
                : "bg-red-600 text-white"
            }`}
          >
            <Icon
              name={
                toast.type === "success"
                  ? "mdi:check-circle"
                  : "mdi:alert-circle"
              }
              className="w-5 h-5 shrink-0"
            />
            {toast.msg}
          </div>,
          document.body,
        )}
    </div>
  );
}
