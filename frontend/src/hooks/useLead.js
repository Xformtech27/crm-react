import { useApi } from "./useApi";
import { objectToFormData } from "../utils/format";

export function useLead() {
  const api = useApi();

  const getAll = () => api.get("/leads");

  const exportLeads = async (selectedIds = null) => {
    // If selectedIds is provided, export only those leads; otherwise export all
    const body = selectedIds?.length ? { leadIds: selectedIds } : {};
    const res = await api.post("/leads/export", body, { responseType: "blob" });
    return res;
  };
  const getById = (id) => api.get(`/leads/${id}`);
  const getByStatus = (status) =>
    api.get(`/leads/status/${encodeURIComponent(status)}`);

  const create = (lead, files) =>
    api.postForm("/leads", objectToFormData("lead", lead, files));

  const update = (id, lead, files) =>
    api.putForm(`/leads/${id}`, objectToFormData("lead", lead, files));

  const remove = (id) => api.del(`/leads/${id}`);
  const updateStatus = (id, status) =>
    api.patch(`/leads/${id}/status`, { status });

  const getNotes = (id) => api.get(`/leads/${id}/notes`);
  const addNote = (id, noteText) =>
    api.post(`/leads/${id}/notes`, { noteText });

  const getReminders = (id) => api.get(`/leads/${id}/reminders`);
  const addReminder = (id, reminderText, reminderDate) =>
    api.post(`/leads/${id}/reminders`, { reminderText, reminderDate });

  const convertToOpportunity = (id) => api.post(`/leads/${id}/convert`, {});

  const importFromIndiamart = (fromDate, toDate) =>
    api.post("/leads/import/indiamart", { fromDate, toDate });

  const getScore = (id) => api.get(`/leads/${id}/score`);
  const getAllScores = () => api.get("/leads/scores");

  return {
    getAll,
    getById,
    getByStatus,
    create,
    update,
    remove,
    updateStatus,
    getNotes,
    addNote,
    getReminders,
    addReminder,
    convertToOpportunity,
    importFromIndiamart,
    getScore,
    getAllScores,
  };
}
