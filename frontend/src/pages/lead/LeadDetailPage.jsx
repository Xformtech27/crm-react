import { useState, useEffect, useMemo, useCallback, useRef } from "react";
import { createPortal } from "react-dom";
import { Link, useParams, useNavigate } from "react-router-dom";
import { useLead } from "../../hooks/useLead";
import { useTask } from "../../hooks/useTask";
import { useOpportunity } from "../../hooks/useOpportunity";
import { useOrganization } from "../../hooks/useOrganization";
import { useContact } from "../../hooks/useContact";
import { LEAD_STATUSES } from "../../utils/constants";
import { formatDate, formatDateTime } from "../../utils/format";
import AppConfirmDialog from "../../components/common/AppConfirmDialog";
import Icon from "../../components/Icon";

function gradeClass(grade) {
  if (grade === "A") return "bg-emerald-100 text-emerald-700";
  if (grade === "B") return "bg-blue-100 text-blue-700";
  if (grade === "C") return "bg-amber-100 text-amber-700";
  return "bg-red-100 text-red-700";
}
function avatarClass(grade) {
  if (grade === "A") return "bg-emerald-500 text-white";
  if (grade === "B") return "bg-blue-500 text-white";
  if (grade === "C") return "bg-amber-500 text-white";
  return "bg-red-500 text-white";
}
function statusClass(status) {
  if (status === "Qualified Lead" || status === "Won")
    return "bg-emerald-100 text-emerald-700";
  if (status === "Contacted") return "bg-amber-100 text-amber-700";
  if (status === "Lost") return "bg-red-100 text-red-700";
  if (status === "Inactive") return "bg-gray-100 text-gray-700";
  return "bg-blue-100 text-blue-700";
}
function timelineBorder(type) {
  if (type === "note") return "border-l-blue-500";
  if (type === "status") return "border-l-emerald-500";
  if (type === "reminder") return "border-l-amber-500";
  if (type === "email") return "border-l-violet-500";
  return "border-l-gray-400";
}

const TABS = [
  { key: "overview", label: "Overview" },
  { key: "activity", label: "Activity" },
  { key: "notes", label: "Notes" },
  { key: "reminders", label: "Reminders" },
  { key: "documents", label: "Documents" },
  { key: "related", label: "Related" },
];

export default function LeadDetailPage() {
  const { id: idStr } = useParams();
  const id = Number(idStr);
  const navigate = useNavigate();
  const {
    getById,
    update,
    remove,
    updateStatus,
    getNotes,
    addNote,
    getReminders,
    addReminder,
    convertToOpportunity,
    getScore,
  } = useLead();
  const { getAll: getAllTasks } = useTask();
  const { getAll: getAllOpportunities } = useOpportunity();
  const { getAll: getAllOrganizations } = useOrganization();
  const { getAll: getAllContacts } = useContact();

  const [lead, setLead] = useState(null);
  const [score, setScore] = useState(null);
  const [notes, setNotes] = useState([]);
  const [reminders, setReminders] = useState([]);
  const [opportunities, setOpportunities] = useState([]);
  const [organizations, setOrganizations] = useState([]);
  const [contacts, setContacts] = useState([]);
  const [tasks, setTasks] = useState([]);
  const [pageLoading, setPageLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState(false);
  const [activeTab, setActiveTab] = useState("overview");
  const [showEditPanel, setShowEditPanel] = useState(false);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
  const [noteText, setNoteText] = useState("");
  const [reminderText, setReminderText] = useState("");
  const [reminderDate, setReminderDate] = useState("");
  const [noteDrafts, setNoteDrafts] = useState({});
  const [editingNoteId, setEditingNoteId] = useState(null);
  const [reminderDone, setReminderDone] = useState({});
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [editingField, setEditingField] = useState(null);
  const [inlineValue, setInlineValue] = useState("");
  const [toast, setToast] = useState(null);
  const toastTimer = useRef(null);
  const uploadInput = useRef(null);

  const [leadForm, setLeadForm] = useState({
    leadFirstName: "",
    leadLastName: "",
    leadTitle: "",
    leadEmail: "",
    leadMobileNo: "",
    leadPhoneNo: "",
    leadOrganisationName: "",
    leadWebsite: "",
    leadIndustry: "",
    leadStatus: "New Lead",
    leadSource: "",
    leadCountry: "",
    leadCity: "",
    leadState: "",
    leadAddress: "",
    noOfEmployee: undefined,
    leadType: "",
    designation: "",
    leadReason: "",
  });

  function showToastMsg(type, message) {
    if (toastTimer.current) clearTimeout(toastTimer.current);
    setToast({ type, message });
    toastTimer.current = setTimeout(() => setToast(null), 3000);
  }

  function populateEditForm(l) {
    setLeadForm({
      leadFirstName: l.leadFirstName || "",
      leadLastName: l.leadLastName || "",
      leadTitle: l.leadTitle || "",
      leadEmail: l.leadEmail || "",
      leadMobileNo: l.leadMobileNo || "",
      leadPhoneNo: l.leadPhoneNo || "",
      leadOrganisationName: l.leadOrganisationName || "",
      leadWebsite: l.leadWebsite || "",
      leadIndustry: l.leadIndustry || "",
      leadStatus: l.leadStatus || "New Lead",
      leadSource: l.leadSource || "",
      leadCountry: l.leadCountry || "",
      leadCity: l.leadCity || "",
      leadState: l.leadState || "",
      leadAddress: l.leadAddress || "",
      noOfEmployee: l.noOfEmployee,
      leadType: l.leadType || "",
      designation: l.designation || "",
      leadReason: l.leadReason || "",
    });
  }

  const loadAll = useCallback(async () => {
    setPageLoading(true);
    try {
      const baseLead = await getById(id);
      setLead(baseLead);
      const [n, r, s, opp, org, con, t] = await Promise.all([
        getNotes(id),
        getReminders(id),
        getScore(id).catch(() => null),
        getAllOpportunities().catch(() => []),
        getAllOrganizations().catch(() => []),
        getAllContacts().catch(() => []),
        getAllTasks().catch(() => []),
      ]);
      setNotes(n ?? []);
      setReminders(r ?? []);
      setScore(s);
      setOpportunities(opp ?? []);
      setOrganizations(org ?? []);
      setContacts(con ?? []);
      setTasks(t ?? []);
      populateEditForm(baseLead);
    } finally {
      setPageLoading(false);
    }
  }, [id]); // eslint-disable-line

  useEffect(() => {
    loadAll();
  }, [loadAll]);

  const leadName = useMemo(() => {
    if (!lead) return "Lead";
    return `${lead.leadFirstName} ${lead.leadLastName || ""}`.trim();
  }, [lead]);

  const initials = useMemo(() => {
    const parts = leadName.split(" ").filter(Boolean);
    return (parts[0]?.[0] || "L") + (parts[1]?.[0] || "");
  }, [leadName]);

  const filesFromLead = useMemo(() => {
    if (!lead) return [];
    return [
      lead.uploadDocument,
      lead.uploadDocument1,
      lead.uploadDocument2,
      lead.uploadDocument3,
    ]
      .filter(Boolean)
      .map((path, idx) => ({
        id: `${idx}-${path}`,
        path,
        name: path.split("/").pop() || `Document ${idx + 1}`,
        uploadedAt: lead.leadCreatedDate,
        size: "Unknown",
      }));
  }, [lead]);

  const relatedOpportunity = useMemo(
    () => opportunities.find((o) => o.leadIdFk === id) || null,
    [opportunities, id],
  );
  const relatedOrganization = useMemo(() => {
    if (!lead?.leadOrganisationName) return null;
    const orgName = lead.leadOrganisationName.toLowerCase();
    return (
      organizations.find(
        (o) => o.organizationName?.toLowerCase() === orgName,
      ) || null
    );
  }, [lead, organizations]);
  const relatedContact = useMemo(() => {
    if (!lead?.leadEmail && !lead?.leadMobileNo) return null;
    return (
      contacts.find(
        (c) =>
          (lead?.leadEmail && c.contactEmail === lead.leadEmail) ||
          (lead?.leadMobileNo && c.contactMobileNo === lead.leadMobileNo),
      ) || null
    );
  }, [lead, contacts]);
  const linkedTasks = useMemo(() => {
    const key = leadName.toLowerCase();
    return tasks
      .filter(
        (t) =>
          String(t.taskRelatedTo || "")
            .toLowerCase()
            .includes(String(id)) ||
          String(t.taskRelatedTo || "")
            .toLowerCase()
            .includes(key),
      )
      .slice(0, 6);
  }, [tasks, leadName, id]);

  const infoFields = useMemo(() => {
    if (!lead) return [];
    return [
      {
        label: "First Name",
        key: "leadFirstName",
        value: lead.leadFirstName,
        required: true,
      },
      { label: "Last Name", key: "leadLastName", value: lead.leadLastName },
      { label: "Title", key: "leadTitle", value: lead.leadTitle },
      { label: "Designation", key: "designation", value: lead.designation },
      { label: "Email", key: "leadEmail", value: lead.leadEmail },
      { label: "Mobile", key: "leadMobileNo", value: lead.leadMobileNo },
      { label: "Phone", key: "leadPhoneNo", value: lead.leadPhoneNo },
      {
        label: "Organization",
        key: "leadOrganisationName",
        value: lead.leadOrganisationName,
      },
      { label: "Website", key: "leadWebsite", value: lead.leadWebsite },
      { label: "Industry", key: "leadIndustry", value: lead.leadIndustry },
      { label: "Source", key: "leadSource", value: lead.leadSource },
      { label: "Type", key: "leadType", value: lead.leadType },
      {
        label: "Employees",
        key: "noOfEmployee",
        value: lead.noOfEmployee?.toString(),
      },
      { label: "Address", key: "leadAddress", value: lead.leadAddress },
      { label: "City", key: "leadCity", value: lead.leadCity },
      { label: "State", key: "leadState", value: lead.leadState },
      { label: "Country", key: "leadCountry", value: lead.leadCountry },
      {
        label: "Inquiry Date",
        key: "inquiryDate",
        value: lead.inquiryDate ? formatDate(lead.inquiryDate) : "",
      },
    ];
  }, [lead]);

  const customFields = useMemo(() => {
    if (!lead) return [];
    return [
      { label: "Lead Reason", value: lead.leadReason || "Not set" },
      { label: "Unique Query ID", value: lead.uniqueQueryId || "Not set" },
      {
        label: "Created",
        value: lead.leadCreatedDate
          ? formatDateTime(lead.leadCreatedDate)
          : "Not set",
      },
    ];
  }, [lead]);

  const timelineItems = useMemo(() => {
    const items = [];
    if (lead?.leadCreatedDate)
      items.push({
        id: "created",
        type: "status",
        text: `${leadName} created as lead`,
        date: lead.leadCreatedDate,
      });
    notes.forEach((n) =>
      items.push({
        id: `note-${n.leadNoteId}`,
        type: "note",
        text: n.noteText,
        date: n.noteDate,
      }),
    );
    reminders.forEach((r) =>
      items.push({
        id: `reminder-${r.leadReminderId}`,
        type: "reminder",
        text: `Reminder: ${r.reminderText}`,
        date: r.reminderDate,
      }),
    );
    filesFromLead.forEach((f) =>
      items.push({
        id: `doc-${f.id}`,
        type: "document",
        text: `Document uploaded: ${f.name}`,
        date: lead?.leadCreatedDate,
      }),
    );
    return items.sort(
      (a, b) =>
        new Date(b.date || "").getTime() - new Date(a.date || "").getTime(),
    );
  }, [lead, notes, reminders, filesFromLead, leadName]);

  async function changeStatus(status) {
    setActionLoading(true);
    try {
      const updated = await updateStatus(lead.leadId, status);
      setLead(updated);
      showToastMsg("success", "Status updated.");
    } catch {
      showToastMsg("error", "Failed to update status.");
    } finally {
      setActionLoading(false);
    }
  }

  async function submitNote(e) {
    e.preventDefault();
    if (!noteText.trim()) return;
    setActionLoading(true);
    try {
      const note = await addNote(id, noteText.trim());
      setNotes((p) => [note, ...p]);
      setNoteText("");
      showToastMsg("success", "Note added.");
    } catch {
      showToastMsg("error", "Failed to add note.");
    } finally {
      setActionLoading(false);
    }
  }

  function startEditNote(note) {
    setEditingNoteId(note.leadNoteId);
    setNoteDrafts((p) => ({ ...p, [note.leadNoteId]: note.noteText }));
  }
  function saveEditNote(noteId) {
    setNotes((p) =>
      p.map((n) =>
        n.leadNoteId === noteId
          ? { ...n, noteText: noteDrafts[noteId] || n.noteText }
          : n,
      ),
    );
    setEditingNoteId(null);
    showToastMsg("success", "Note updated.");
  }
  function deleteNote(noteId) {
    setNotes((p) => p.filter((n) => n.leadNoteId !== noteId));
    showToastMsg("success", "Note deleted.");
  }

  async function submitReminder(e) {
    e.preventDefault();
    if (!reminderText.trim() || !reminderDate) return;
    setActionLoading(true);
    try {
      const rem = await addReminder(
        id,
        reminderText.trim(),
        new Date(reminderDate).toISOString(),
      );
      setReminders((p) => [rem, ...p]);
      setReminderText("");
      setReminderDate("");
      showToastMsg("success", "Reminder added.");
    } catch {
      showToastMsg("error", "Failed to add reminder.");
    } finally {
      setActionLoading(false);
    }
  }

  function toggleReminderDone(reminderId) {
    setReminderDone((p) => ({ ...p, [reminderId]: !p[reminderId] }));
  }

  async function handleConvert() {
    setActionLoading(true);
    try {
      await convertToOpportunity(id);
      showToastMsg("success", "Converted to opportunity.");
      await loadAll();
    } catch {
      showToastMsg("error", "Conversion failed.");
    } finally {
      setActionLoading(false);
    }
  }

  async function handleDelete() {
    setActionLoading(true);
    try {
      await remove(lead.leadId);
      navigate("/lead");
    } catch {
      showToastMsg("error", "Failed to delete lead.");
    } finally {
      setActionLoading(false);
    }
  }

  async function saveEditPanel() {
    setActionLoading(true);
    try {
      const updated = await update(lead.leadId, leadForm, {});
      setLead(updated);
      setShowEditPanel(false);
      showToastMsg("success", "Lead updated.");
    } catch {
      showToastMsg("error", "Failed to update lead.");
    } finally {
      setActionLoading(false);
    }
  }

  function beginInlineEdit(field, value) {
    setEditingField(field);
    setInlineValue(value == null ? "" : String(value));
  }

  async function saveInlineEdit(field) {
    const payload = {};
    payload[field] =
      field === "noOfEmployee"
        ? inlineValue
          ? Number(inlineValue)
          : undefined
        : inlineValue;
    setActionLoading(true);
    try {
      const updated = await update(lead.leadId, payload, {});
      setLead(updated);
      showToastMsg("success", "Field updated.");
    } catch {
      showToastMsg("error", "Inline update failed.");
    } finally {
      setEditingField(null);
      setActionLoading(false);
    }
  }

  async function uploadFiles(files) {
    if (!files?.length || !lead) return;
    const slots = [
      "uploadDocument",
      "uploadDocument1",
      "uploadDocument2",
      "uploadDocument3",
    ];
    const fileMap = {};
    let idx = 0;
    for (const slot of slots) {
      if (idx >= files.length) break;
      fileMap[slot] = files[idx];
      idx++;
    }
    setUploading(true);
    setUploadProgress(10);
    const timer = setInterval(
      () => setUploadProgress((p) => Math.min(p + 15, 90)),
      150,
    );
    try {
      await update(lead.leadId, {}, fileMap);
      setUploadProgress(100);
      showToastMsg("success", `${files.length} file(s) uploaded.`);
      await loadAll();
    } catch {
      showToastMsg("error", "Upload failed.");
    } finally {
      clearInterval(timer);
      setTimeout(() => {
        setUploading(false);
        setUploadProgress(0);
      }, 300);
    }
  }

  const grade = score?.grade || "D";

  if (pageLoading)
    return (
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-[246px_minmax(0,1fr)_336px]">
        <div className="space-y-3">
          <div className="h-36 skeleton" />
          <div className="h-64 skeleton" />
        </div>
        <div className="space-y-3">
          <div className="h-12 skeleton" />
          <div className="h-80 skeleton" />
        </div>
        <div className="space-y-3">
          <div className="h-40 skeleton" />
          <div className="h-36 skeleton" />
        </div>
      </div>
    );

  if (!lead)
    return (
      <div className="card p-10 text-center">
        <Icon
          name="mdi:alert-triangle-outline"
          className="h-9 w-9 text-red-500 mx-auto mb-3"
        />
        <h2 className="text-xl font-semibold text-gray-900">Lead not found</h2>
        <p className="text-base text-gray-500 mt-2">
          This lead may have been deleted or moved.
        </p>
        <Link to="/lead" className="btn-primary mt-5 inline-block">
          Go to Lead List
        </Link>
      </div>
    );

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between gap-3">
        <Link
          to="/lead"
          className="inline-flex items-center gap-1 text-sm text-gray-500 hover:text-gray-700"
        >
          <Icon name="mdi:arrow-left" className="h-4 w-4" />
          Back to Leads
        </Link>
        <div className="flex items-center gap-2">
          <button
            className="btn-secondary h-9 px-3 text-sm"
            onClick={() => navigate("/task")}
          >
            <Icon name="mdi:clipboard-check-outline" className="h-4 w-4" />
            Add Task
          </button>
          <button
            className="btn-secondary h-9 px-3 text-sm"
            onClick={() => setActiveTab("reminders")}
          >
            <Icon name="mdi:bell-outline" className="h-4 w-4" />
            Add Reminder
          </button>
          <button
            className="btn-secondary h-9 px-3 text-sm"
            onClick={() => navigate("/calendar")}
          >
            <Icon name="mdi:calendar-plus-outline" className="h-4 w-4" />
            Add Event
          </button>
          <button
            className="btn-secondary h-11 px-5"
            onClick={() => setShowEditPanel(true)}
          >
            <Icon name="mdi:pencil-outline" className="h-4 w-4" />
            Edit Lead
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 items-start gap-5 xl:grid-cols-[246px_minmax(0,1fr)_336px]">
        {/* Left Sidebar */}
        <aside className="xl:sticky xl:top-24 h-fit card p-5 space-y-4">
          <div className="flex flex-col items-center text-center gap-3">
            <div
              className={`h-24 w-24 rounded-full flex items-center justify-center text-2xl font-semibold ${avatarClass(grade)}`}
            >
              {initials}
            </div>
            <div>
              <h1 className="text-xl font-semibold text-gray-900 leading-tight">
                {leadName}
              </h1>
              <p className="text-sm text-gray-500">Lead #{lead.leadId}</p>
            </div>
            <span className={`badge text-sm px-3 py-1.5 ${gradeClass(grade)}`}>
              Grade {grade}
            </span>
          </div>

          <div className="space-y-2">
            <label className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
              Status
            </label>
            <select
              value={lead.leadStatus}
              disabled={actionLoading}
              onChange={(e) => changeStatus(e.target.value)}
              className="input-field text-sm w-full"
            >
              {LEAD_STATUSES.map((s) => (
                <option key={s} value={s}>
                  {s}
                </option>
              ))}
            </select>
            <span className={`badge ${statusClass(lead.leadStatus)}`}>
              {lead.leadStatus}
            </span>
          </div>

          <div className="border-t border-gray-100 pt-3 space-y-2 text-sm">
            <a
              href={`tel:${lead.leadMobileNo || ""}`}
              className="flex items-center gap-2 text-gray-700 hover:text-blue-600"
            >
              <Icon name="mdi:phone-outline" className="h-4 w-4" />
              <span>{lead.leadMobileNo || "No mobile"}</span>
            </a>
            <a
              href={`mailto:${lead.leadEmail || ""}`}
              className="flex items-center gap-2 text-gray-700 hover:text-blue-600"
            >
              <Icon name="mdi:email-outline" className="h-4 w-4" />
              <span className="truncate">{lead.leadEmail || "No email"}</span>
            </a>
            <div className="flex items-center gap-2 text-gray-700">
              <Icon name="mdi:link-variant" className="h-4 w-4" />
              <span>{lead.leadSource || "Unknown source"}</span>
            </div>
            <div className="flex items-center gap-2 text-gray-700">
              <Icon name="mdi:account-circle-outline" className="h-4 w-4" />
              <span>
                Assigned:{" "}
                {lead.userIdFk ? `User ${lead.userIdFk}` : "Unassigned"}
              </span>
            </div>
          </div>

          <div className="border-t border-gray-100 pt-3 space-y-2">
            <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
              Actions
            </p>
            <button
              className="w-full btn-secondary justify-start"
              onClick={() => setShowEditPanel(true)}
            >
              <Icon name="mdi:pencil-outline" className="h-4 w-4" />
              Edit
            </button>
            <button
              className="w-full btn-primary justify-start"
              disabled={actionLoading}
              onClick={handleConvert}
            >
              <Icon name="mdi:briefcase-outline" className="h-4 w-4" />
              Convert to Opportunity
            </button>
            <button
              className="w-full btn-danger justify-start"
              disabled={actionLoading}
              onClick={() => setShowDeleteConfirm(true)}
            >
              <Icon name="mdi:trash-can-outline" className="h-4 w-4" />
              Delete
            </button>
            <a
              href={`mailto:${lead.leadEmail || ""}`}
              className="w-full btn-secondary justify-start flex items-center gap-2"
            >
              <Icon name="mdi:send-outline" className="h-4 w-4" />
              Send Email
            </a>
            <div className="grid grid-cols-3 gap-2 pt-1">
              <button
                className="btn-secondary justify-center px-1 py-2 text-xs"
                onClick={() => navigate("/task")}
              >
                <Icon name="mdi:clipboard-check-outline" className="h-4 w-4" />
                <span className="ml-1">Task</span>
              </button>
              <button
                className="btn-secondary justify-center px-1 py-2 text-xs"
                onClick={() => setActiveTab("reminders")}
              >
                <Icon name="mdi:bell-outline" className="h-4 w-4" />
                <span className="ml-1">Reminder</span>
              </button>
              <button
                className="btn-secondary justify-center px-1 py-2 text-xs"
                onClick={() => navigate("/calendar")}
              >
                <Icon name="mdi:calendar-plus-outline" className="h-4 w-4" />
                <span className="ml-1">Event</span>
              </button>
            </div>
          </div>

          <div className="border-t border-gray-100 pt-3">
            <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2">
              Tags
            </p>
            <div className="flex flex-wrap gap-1.5">
              <span className="badge bg-blue-100 text-blue-700">
                {lead.leadStatus}
              </span>
              <span className="badge bg-gray-100 text-gray-700">
                {lead.leadSource || "Source: N/A"}
              </span>
              <span className="badge bg-emerald-100 text-emerald-700">
                {lead.leadType || "Type: N/A"}
              </span>
            </div>
          </div>
        </aside>

        {/* Main */}
        <main className="min-w-0 card p-5 sm:p-6 space-y-5">
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-gray-100 pb-3">
            <div className="flex min-w-0 flex-wrap items-center gap-1">
              {TABS.map((tab) => (
                <button
                  key={tab.key}
                  className={`h-10 px-4 rounded-lg text-sm font-medium transition-colors ${activeTab === tab.key ? "bg-blue-600 text-white" : "text-gray-600 hover:bg-gray-100"}`}
                  onClick={() => setActiveTab(tab.key)}
                >
                  {tab.label}
                </button>
              ))}
            </div>
            <select
              className="input-field h-10 w-48 shrink-0 text-sm"
              value={activeTab}
              onChange={(e) => setActiveTab(e.target.value)}
            >
              {TABS.map((t) => (
                <option key={t.key} value={t.key}>
                  {t.label}
                </option>
              ))}
            </select>
          </div>

          {activeTab === "overview" && (
            <section className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {infoFields.map((field) => (
                  <div
                    key={field.key}
                    className="rounded-lg border border-gray-100 p-3 bg-white"
                  >
                    <p className="text-xs text-gray-500 font-medium mb-1">
                      {field.label}
                      {field.required && (
                        <span className="text-red-500">*</span>
                      )}
                    </p>
                    {editingField === field.key ? (
                      <div className="flex items-center gap-2">
                        <input
                          value={inlineValue}
                          onChange={(e) => setInlineValue(e.target.value)}
                          className="input-field text-sm"
                        />
                        <button
                          className="btn-primary btn-sm"
                          onClick={() => saveInlineEdit(field.key)}
                        >
                          Save
                        </button>
                        <button
                          className="btn-secondary btn-sm"
                          onClick={() => setEditingField(null)}
                        >
                          Cancel
                        </button>
                      </div>
                    ) : (
                      <button
                        className="text-sm text-left text-gray-800 hover:text-blue-600"
                        onClick={() =>
                          beginInlineEdit(field.key, field.value || "")
                        }
                      >
                        {field.value || "Click to add value"}
                      </button>
                    )}
                  </div>
                ))}
              </div>
              <div className="rounded-lg border border-gray-100 p-4">
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  Custom Fields
                </h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {customFields.map((field) => (
                    <div
                      key={field.label}
                      className="bg-gray-50 rounded-lg px-3 py-2"
                    >
                      <p className="text-xs text-gray-500">{field.label}</p>
                      <p className="text-sm text-gray-800">{field.value}</p>
                    </div>
                  ))}
                </div>
              </div>
            </section>
          )}

          {activeTab === "activity" && (
            <section className="space-y-3">
              <h3 className="text-lg font-semibold text-gray-900">
                Activity Timeline
              </h3>
              {!timelineItems.length ? (
                <div className="text-center py-10 text-gray-500 text-sm">
                  No activity yet.
                </div>
              ) : (
                <div className="space-y-2">
                  {timelineItems.map((item) => (
                    <div
                      key={item.id}
                      className={`bg-white rounded-r-lg border border-l-4 p-3 ${timelineBorder(item.type)}`}
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div className="flex items-start gap-2">
                          <div className="h-8 w-8 rounded-full bg-gray-100 flex items-center justify-center text-xs font-semibold text-gray-600">
                            {initials}
                          </div>
                          <div>
                            <p className="text-sm text-gray-800">{item.text}</p>
                            <p className="text-xs text-gray-500 mt-1">
                              {formatDateTime(item.date)}
                            </p>
                          </div>
                        </div>
                        <span className="text-xs uppercase text-gray-400">
                          {item.type}
                        </span>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </section>
          )}

          {activeTab === "notes" && (
            <section className="space-y-3">
              <h3 className="text-lg font-semibold text-gray-900">Notes</h3>
              <form className="space-y-2" onSubmit={submitNote}>
                <label className="text-sm font-medium text-gray-700">
                  Add Note <span className="text-red-500">*</span>
                </label>
                <textarea
                  value={noteText}
                  onChange={(e) => setNoteText(e.target.value)}
                  rows="3"
                  className="input-field min-h-[96px]"
                  placeholder="Write a note..."
                />
                <button className="btn-primary" disabled={actionLoading}>
                  Submit Note
                </button>
              </form>
              {!notes.length ? (
                <div className="text-center py-8 text-gray-500">
                  No notes yet.
                </div>
              ) : (
                <div className="space-y-2">
                  {notes.map((n) => (
                    <article
                      key={n.leadNoteId}
                      className="border border-gray-100 rounded-lg p-3 bg-white"
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div className="flex items-start gap-2 min-w-0">
                          <div className="h-8 w-8 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center text-xs font-semibold">
                            {initials}
                          </div>
                          <div className="min-w-0 w-full">
                            {editingNoteId === n.leadNoteId ? (
                              <textarea
                                value={noteDrafts[n.leadNoteId] || ""}
                                onChange={(e) =>
                                  setNoteDrafts((p) => ({
                                    ...p,
                                    [n.leadNoteId]: e.target.value,
                                  }))
                                }
                                rows="3"
                                className="input-field"
                              />
                            ) : (
                              <p className="text-sm text-gray-800 whitespace-pre-wrap">
                                {n.noteText}
                              </p>
                            )}
                            <p className="text-xs text-gray-500 mt-1">
                              {formatDateTime(n.noteDate)}
                            </p>
                          </div>
                        </div>
                        <div className="flex items-center gap-1">
                          {editingNoteId === n.leadNoteId ? (
                            <button
                              className="btn-primary btn-sm"
                              onClick={() => saveEditNote(n.leadNoteId)}
                            >
                              Save
                            </button>
                          ) : (
                            <button
                              className="p-1.5 rounded hover:bg-gray-100 text-gray-500"
                              onClick={() => startEditNote(n)}
                            >
                              <Icon
                                name="mdi:pencil-outline"
                                className="h-4 w-4"
                              />
                            </button>
                          )}
                          <button
                            className="p-1.5 rounded hover:bg-red-50 text-gray-500 hover:text-red-600"
                            onClick={() => deleteNote(n.leadNoteId)}
                          >
                            <Icon
                              name="mdi:trash-can-outline"
                              className="h-4 w-4"
                            />
                          </button>
                        </div>
                      </div>
                    </article>
                  ))}
                </div>
              )}
            </section>
          )}

          {activeTab === "reminders" && (
            <section className="space-y-3">
              <h3 className="text-lg font-semibold text-gray-900">Reminders</h3>
              <form
                className="grid grid-cols-1 md:grid-cols-2 gap-3 rounded-lg border border-gray-100 p-3 bg-white"
                onSubmit={submitReminder}
              >
                <div className="md:col-span-2">
                  <label className="text-sm font-medium text-gray-700 mb-1 block">
                    Reminder Text <span className="text-red-500">*</span>
                  </label>
                  <input
                    value={reminderText}
                    onChange={(e) => setReminderText(e.target.value)}
                    className="input-field"
                    placeholder="Follow-up call, proposal review..."
                  />
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700 mb-1 block">
                    Date & Time <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="datetime-local"
                    value={reminderDate}
                    onChange={(e) => setReminderDate(e.target.value)}
                    className="input-field"
                  />
                </div>
                <div className="flex items-end">
                  <button
                    className="btn-primary w-full justify-center"
                    disabled={actionLoading}
                  >
                    + Add Reminder
                  </button>
                </div>
              </form>
              {!reminders.length ? (
                <div className="text-center py-8 text-gray-500">
                  No reminders yet.
                </div>
              ) : (
                <div className="space-y-2">
                  {reminders.map((r) => (
                    <div
                      key={r.leadReminderId}
                      className="border border-gray-100 rounded-lg p-3 bg-white flex items-start justify-between gap-3"
                    >
                      <div className="flex items-start gap-2">
                        <div className="h-10 min-w-[40px] rounded-lg bg-amber-100 text-amber-700 flex items-center justify-center">
                          <Icon
                            name="mdi:calendar-outline"
                            className="h-4 w-4"
                          />
                        </div>
                        <div>
                          <p className="text-sm text-gray-800">
                            {r.reminderText}
                          </p>
                          <p className="text-xs text-gray-500 mt-1">
                            {formatDateTime(r.reminderDate)}
                          </p>
                        </div>
                      </div>
                      <label className="flex items-center gap-2 text-sm text-gray-600">
                        <input
                          type="checkbox"
                          checked={!!reminderDone[r.leadReminderId]}
                          onChange={() => toggleReminderDone(r.leadReminderId)}
                        />
                        <span
                          className={
                            reminderDone[r.leadReminderId]
                              ? "text-emerald-600"
                              : "text-gray-500"
                          }
                        >
                          {reminderDone[r.leadReminderId] ? "Done" : "Pending"}
                        </span>
                      </label>
                    </div>
                  ))}
                </div>
              )}
            </section>
          )}

          {activeTab === "documents" && (
            <section className="space-y-3">
              <h3 className="text-lg font-semibold text-gray-900">Documents</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {filesFromLead.map((doc) => (
                  <div
                    key={doc.id}
                    className="border border-gray-100 rounded-lg p-3 bg-white flex items-start justify-between gap-2"
                  >
                    <div className="flex items-start gap-2 min-w-0">
                      <Icon
                        name="mdi:file-document-outline"
                        className="h-5 w-5 text-gray-400 mt-0.5"
                      />
                      <div className="min-w-0">
                        <p className="text-sm font-medium text-gray-800 truncate">
                          {doc.name}
                        </p>
                        <p className="text-xs text-gray-500">
                          {doc.size} · {formatDate(doc.uploadedAt)}
                        </p>
                      </div>
                    </div>
                    <a
                      className="p-1.5 rounded hover:bg-gray-100 text-gray-500"
                      href={doc.path}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <Icon name="mdi:download-outline" className="h-4 w-4" />
                    </a>
                  </div>
                ))}
              </div>
              <div
                className="border-2 border-dashed border-gray-200 rounded-xl p-6 text-center bg-gray-50"
                onDrop={(e) => {
                  e.preventDefault();
                  uploadFiles(e.dataTransfer?.files);
                }}
                onDragOver={(e) => e.preventDefault()}
              >
                <Icon
                  name="mdi:paperclip"
                  className="h-7 w-7 text-gray-400 mx-auto mb-2"
                />
                <p className="text-sm text-gray-700">
                  Drag and drop files here, or click to upload
                </p>
                <button
                  className="btn-secondary mt-3"
                  onClick={() => uploadInput.current?.click()}
                >
                  <Icon name="mdi:plus" className="h-4 w-4" />
                  Choose Files
                </button>
                <input
                  ref={uploadInput}
                  type="file"
                  className="hidden"
                  multiple
                  onChange={(e) => uploadFiles(e.target.files)}
                />
                {uploading && (
                  <div className="mt-4">
                    <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
                      <div
                        className="h-full bg-blue-600 transition-all"
                        style={{ width: `${uploadProgress}%` }}
                      />
                    </div>
                    <p className="text-xs text-gray-500 mt-1">
                      Uploading... {uploadProgress}%
                    </p>
                  </div>
                )}
              </div>
            </section>
          )}

          {activeTab === "related" && (
            <section className="space-y-3">
              <h3 className="text-lg font-semibold text-gray-900">
                Related Records
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {[
                  {
                    label: "Opportunity",
                    main: relatedOpportunity?.oppName || "Not linked",
                    sub: relatedOpportunity?.oppStatus || "No status",
                  },
                  {
                    label: "Organization",
                    main:
                      relatedOrganization?.organizationName ||
                      lead.leadOrganisationName ||
                      "Not linked",
                    sub:
                      relatedOrganization?.organizationCity ||
                      lead.leadCity ||
                      "No location",
                  },
                  {
                    label: "Contact",
                    main: relatedContact?.contactName || leadName,
                    sub:
                      relatedContact?.contactEmail ||
                      lead.leadEmail ||
                      "No email",
                  },
                  {
                    label: "Linked Tasks",
                    main: `${linkedTasks.length} task(s)`,
                    sub: null,
                    action: () => setActiveTab("activity"),
                  },
                ].map((item) => (
                  <div
                    key={item.label}
                    className="border border-gray-100 rounded-lg p-4 bg-white"
                  >
                    <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">
                      {item.label}
                    </p>
                    <p className="text-sm text-gray-900 font-medium">
                      {item.main}
                    </p>
                    {item.sub && (
                      <p className="text-xs text-gray-500">{item.sub}</p>
                    )}
                    {item.action && (
                      <button
                        className="text-sm text-blue-600 mt-1"
                        onClick={item.action}
                      >
                        View activity
                      </button>
                    )}
                  </div>
                ))}
              </div>
            </section>
          )}
        </main>

        {/* Right Sidebar */}
        <aside className="xl:sticky xl:top-24 h-fit space-y-4">
          <div className="card p-5">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">
              Related
            </h3>
            <div className="space-y-2">
              {[
                {
                  label: "Linked Opportunity",
                  main: relatedOpportunity?.oppName || "Not linked",
                  sub: relatedOpportunity?.oppStatus || "No status",
                },
                {
                  label: "Linked Organization",
                  main:
                    relatedOrganization?.organizationName ||
                    lead.leadOrganisationName ||
                    "Not linked",
                },
                {
                  label: "Linked Contact",
                  main: relatedContact?.contactName || leadName,
                },
              ].map((item) => (
                <div
                  key={item.label}
                  className="rounded-lg border border-gray-100 p-4 bg-white"
                >
                  <p className="text-xs text-gray-500">{item.label}</p>
                  <p className="text-sm font-medium text-gray-900">
                    {item.main}
                  </p>
                  {item.sub && (
                    <p className="text-xs text-gray-500">{item.sub}</p>
                  )}
                </div>
              ))}
            </div>
          </div>

          <div className="card p-5">
            <h3 className="text-lg font-semibold text-gray-900 mb-3">
              Lead Score
            </h3>
            {score ? (
              <div className="space-y-2">
                <div className="flex items-end gap-2">
                  <p className="text-3xl font-bold text-gray-900">
                    {score.score}
                  </p>
                  <span className={`badge ${gradeClass(score.grade)}`}>
                    {score.grade}
                  </span>
                </div>
                <ul className="space-y-1">
                  {(score.topFactors ?? []).map((factor) => (
                    <li
                      key={factor}
                      className="flex items-start gap-2 text-sm text-gray-700"
                    >
                      <Icon
                        name="mdi:check-circle-outline"
                        className="h-4 w-4 text-emerald-500 mt-0.5"
                      />
                      <span>{factor}</span>
                    </li>
                  ))}
                </ul>
              </div>
            ) : (
              <p className="text-sm text-gray-500">Score not available</p>
            )}
          </div>

          <div className="card p-5">
            <div className="flex items-center justify-between mb-2">
              <h3 className="text-base font-semibold text-gray-900">
                Upcoming Tasks
              </h3>
              <button className="text-sm text-blue-600">+ Add task</button>
            </div>
            <div className="space-y-2">
              {linkedTasks.map((task) => (
                <div
                  key={task.taskId}
                  className="rounded-lg border border-gray-100 p-2.5 bg-white"
                >
                  <p className="text-sm font-medium text-gray-900">
                    {task.taskName}
                  </p>
                  <p className="text-xs text-gray-500">
                    {task.taskDueDate
                      ? formatDate(task.taskDueDate)
                      : "No due date"}
                  </p>
                </div>
              ))}
              {!linkedTasks.length && (
                <p className="text-sm text-gray-500">No linked tasks.</p>
              )}
            </div>
          </div>

          <div className="card p-5">
            <h3 className="text-base font-semibold text-gray-900 mb-2">Team</h3>
            <div className="flex items-center gap-2 rounded-lg border border-gray-100 p-2.5 bg-white">
              <div className="h-9 w-9 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center font-semibold text-sm">
                {lead.userIdFk ? `U${lead.userIdFk}` : "NA"}
              </div>
              <div className="min-w-0">
                <p className="text-sm font-medium text-gray-900 truncate">
                  {lead.userIdFk ? `User ${lead.userIdFk}` : "Unassigned"}
                </p>
                <p className="text-xs text-gray-500">Sales Representative</p>
              </div>
            </div>
            <button className="btn-secondary w-full mt-2 justify-center">
              Reassign
            </button>
          </div>
        </aside>
      </div>

      {showEditPanel &&
        createPortal(
          <div className="fixed inset-0 z-50 flex justify-end">
            <div
              className="absolute inset-0 bg-black/30"
              onClick={() => setShowEditPanel(false)}
            />
            <div className="slide-panel">
              <div className="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <h3 className="text-lg font-semibold text-gray-900">
                  Edit Lead
                </h3>
                <button
                  className="text-gray-500 hover:text-gray-700"
                  onClick={() => setShowEditPanel(false)}
                >
                  <Icon name="mdi:close" className="h-4 w-4" />
                </button>
              </div>
              <div className="p-4 flex-1 overflow-y-auto">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {[
                    {
                      label: "First Name",
                      key: "leadFirstName",
                      required: true,
                    },
                    { label: "Last Name", key: "leadLastName" },
                    { label: "Email", key: "leadEmail" },
                    { label: "Mobile", key: "leadMobileNo" },
                    { label: "Company", key: "leadOrganisationName" },
                  ].map((f) => (
                    <div key={f.key}>
                      <label className="text-sm font-medium text-gray-700 mb-1 block">
                        {f.label}
                        {f.required && <span className="text-red-500"> *</span>}
                      </label>
                      <input
                        value={leadForm[f.key] || ""}
                        onChange={(e) =>
                          setLeadForm((p) => ({
                            ...p,
                            [f.key]: e.target.value,
                          }))
                        }
                        className="input-field"
                      />
                    </div>
                  ))}
                  <div>
                    <label className="text-sm font-medium text-gray-700 mb-1 block">
                      Status <span className="text-red-500">*</span>
                    </label>
                    <select
                      value={leadForm.leadStatus}
                      onChange={(e) =>
                        setLeadForm((p) => ({
                          ...p,
                          leadStatus: e.target.value,
                        }))
                      }
                      className="input-field"
                    >
                      {LEAD_STATUSES.map((s) => (
                        <option key={s} value={s}>
                          {s}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="md:col-span-2">
                    <label className="text-sm font-medium text-gray-700 mb-1 block">
                      Reason
                    </label>
                    <textarea
                      value={leadForm.leadReason || ""}
                      onChange={(e) =>
                        setLeadForm((p) => ({
                          ...p,
                          leadReason: e.target.value,
                        }))
                      }
                      rows="3"
                      className="input-field"
                    />
                  </div>
                </div>
              </div>
              <div className="px-4 py-3 border-t border-gray-100 flex justify-end gap-2">
                <button
                  className="btn-secondary"
                  onClick={() => setShowEditPanel(false)}
                >
                  Cancel
                </button>
                <button
                  className="btn-primary"
                  disabled={actionLoading}
                  onClick={saveEditPanel}
                >
                  Save Changes
                </button>
              </div>
            </div>
          </div>,
          document.body,
        )}

      <AppConfirmDialog
        open={showDeleteConfirm}
        title="Delete Lead"
        message="Delete this lead permanently? This action cannot be undone."
        onConfirm={handleDelete}
        onCancel={() => setShowDeleteConfirm(false)}
      />

      {toast &&
        createPortal(
          <div
            className={`fixed bottom-6 right-6 z-[70] flex items-center gap-2 px-4 py-3 rounded-lg text-sm font-medium shadow-lg ${toast.type === "success" ? "bg-green-500 text-white" : "bg-red-500 text-white"}`}
          >
            <Icon
              name={
                toast.type === "success"
                  ? "mdi:check-circle-outline"
                  : "mdi:alert-triangle-outline"
              }
              className="h-4 w-4"
            />
            {toast.message}
          </div>,
          document.body,
        )}
    </div>
  );
}
