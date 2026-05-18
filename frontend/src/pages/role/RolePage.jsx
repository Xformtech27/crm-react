import { useState, useEffect } from "react";
import Icon from "../../components/Icon";
 
const initialRoles = [
  { id: 1, name: "Sales Rep", description: "Frontline sales team member", recordCount: 12 },
  { id: 2, name: "Manager", description: "Team manager with oversight", recordCount: 5 },
  { id: 3, name: "Admin", description: "Full system access", recordCount: 2 },
  { id: 4, name: "Viewer", description: "Read-only access", recordCount: 8 },
  { id: 5, name: "Editor", description: "Can edit content", recordCount: 15 },
];
 
export default function RolePage() {
  // Load roles from localStorage or use initialRoles
  const [roles, setRoles] = useState(() => {
    const savedRoles = localStorage.getItem("roles");
    return savedRoles ? JSON.parse(savedRoles) : initialRoles;
  });
 
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [editingRole, setEditingRole] = useState(null);
  const [roleName, setRoleName] = useState("");
  const [roleDescription, setRoleDescription] = useState("");
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [toast, setToast] = useState(null);
 
  // Save roles to localStorage whenever they change
  useEffect(() => {
    localStorage.setItem("roles", JSON.stringify(roles));
  }, [roles]);
 
  const showToast = (message, type = "success") => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };
 
  const filteredRoles = roles.filter((role) => {
    const matchesSearch = role.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         role.description.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesFilter = filterStatus === "all" ||
                         (filterStatus === "high" && role.recordCount > 10) ||
                         (filterStatus === "medium" && role.recordCount >= 5 && role.recordCount <= 10) ||
                         (filterStatus === "low" && role.recordCount < 5);
    return matchesSearch && matchesFilter;
  });
 
  const exportToCSV = () => {
    const headers = ["Role Name", "Description", "Record Count", "Created Date"];
    const csvData = filteredRoles.map(role => [
      role.name,
      role.description,
      role.recordCount,
      new Date().toLocaleDateString()
    ]);
 
    const csvContent = [headers, ...csvData].map(row => row.join(",")).join("\n");
    const blob = new Blob([csvContent], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `roles_export_${new Date().toISOString().split("T")[0]}.csv`;
    a.click();
    URL.revokeObjectURL(url);
    showToast("Export completed successfully", "success");
  };
 
  const openCreateDrawer = () => {
    setEditingRole(null);
    setRoleName("");
    setRoleDescription("");
    setDrawerOpen(true);
  };
 
  const openEditDrawer = (role) => {
    setEditingRole(role);
    setRoleName(role.name);
    setRoleDescription(role.description);
    setDrawerOpen(true);
  };
 
  const saveRole = () => {
    if (!roleName.trim()) {
      showToast("Role name is required", "error");
      return;
    }
 
    if (editingRole) {
      setRoles(roles.map(role =>
        role.id === editingRole.id
          ? { ...role, name: roleName.trim(), description: roleDescription }
          : role
      ));
      showToast(`Role "${roleName}" updated successfully`, "success");
    } else {
      const newRole = {
        id: Math.max(...roles.map(r => r.id), 0) + 1,
        name: roleName.trim(),
        description: roleDescription,
        recordCount: 0
      };
      setRoles([...roles, newRole]);
      showToast(`Role "${roleName}" created successfully`, "success");
    }
    setDrawerOpen(false);
  };
 
  const deleteRole = () => {
    if (deleteTarget) {
      setRoles(roles.filter(role => role.id !== deleteTarget.id));
      showToast(`Role "${deleteTarget.name}" deleted successfully`, "success");
      setDeleteTarget(null);
    }
  };
 
  return (
    <section className="min-h-[calc(100vh-2rem)] bg-white px-4 py-6 sm:px-6 lg:px-8">
      <div className="mx-auto max-w-7xl">
        {/* Header */}
        <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h1 className="text-2xl font-bold text-slate-900 sm:text-3xl">
              Role & Permission Management
            </h1>
            <p className="mt-1 text-sm text-slate-500">
              Fine-grained access control — define roles and assign module permissions
            </p>
          </div>
          <button
            onClick={openCreateDrawer}
            className="inline-flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white shadow-sm transition-colors hover:bg-blue-700"
          >
            <Icon name="mdi:plus" className="h-4 w-4" />
            Create Role
          </button>
        </div>
 
        {/* Search, Filter & Export Bar */}
        <div className="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex flex-1 gap-3">
            {/* Search Bar */}
            <div className="relative flex-1 max-w-md">
              <Icon
                name="mdi:magnify"
                className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
              />
              <input
                type="text"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder="Search by role name or description..."
                className="w-full rounded-lg border border-slate-200 bg-white py-2 pl-9 pr-3 text-sm text-slate-900 placeholder:text-slate-400 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
              />
            </div>
 
            {/* Filter Dropdown */}
            <select
              value={filterStatus}
              onChange={(e) => setFilterStatus(e.target.value)}
              className="rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm text-slate-700 focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
            >
              <option value="all">All Records</option>
              <option value="high">High Usage (&gt;10 records)</option>
              <option value="medium">Medium Usage (5-10 records)</option>
              <option value="low">Low Usage (&lt;5 records)</option>
            </select>
          </div>
 
          {/* Export Button */}
          <button
            onClick={exportToCSV}
            className="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-4 py-2 text-sm font-medium text-slate-700 transition-colors hover:bg-slate-50"
          >
            <Icon name="mdi:export" className="h-4 w-4" />
            Export CSV
          </button>
        </div>
 
        {/* Roles Table */}
        <div className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="border-b border-slate-200 bg-slate-50">
                <tr>
                  <th className="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-600">
                    # Record
                  </th>
                  <th className="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-600">
                    Role Name
                  </th>
                  <th className="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-slate-600">
                    Description
                  </th>
                  <th className="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-slate-600">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody>
                {filteredRoles.length === 0 ? (
                  <tr>
                    <td colSpan={4} className="px-5 py-12 text-center text-slate-400">
                      <Icon name="mdi:shield-account-outline" className="mx-auto h-10 w-10 opacity-40" />
                      <p className="mt-2">No roles found</p>
                    </td>
                  </tr>
                ) : (
                  filteredRoles.map((role, index) => (
                    <tr
                      key={role.id}
                      className={`border-b border-slate-100 transition-colors hover:bg-slate-50 ${
                        index % 2 === 0 ? "bg-white" : "bg-slate-50/30"
                      }`}
                    >
                      <td className="px-5 py-3 text-slate-500">{index + 1}</td>
                      <td className="px-5 py-3">
                        <div className="flex items-center gap-2">
                          <div className="flex h-8 w-8 items-center justify-center rounded-full bg-indigo-100 text-indigo-700">
                            <Icon name="mdi:shield-account" className="h-4 w-4" />
                          </div>
                          <span className="font-medium text-slate-900">{role.name}</span>
                        </div>
                      </td>
                      <td className="px-5 py-3 text-slate-500">{role.description}</td>
                      <td className="px-5 py-3 text-center">
                        <div className="flex justify-center gap-2">
                          <button
                            onClick={() => openEditDrawer(role)}
                            className="rounded-lg p-1.5 text-slate-400 transition-colors hover:bg-blue-50 hover:text-blue-600"
                            title="Edit role"
                          >
                            <Icon name="mdi:pencil-outline" className="h-4 w-4" />
                          </button>
                          <button
                            onClick={() => setDeleteTarget(role)}
                            className="rounded-lg p-1.5 text-slate-400 transition-colors hover:bg-red-50 hover:text-red-600"
                            title="Delete role"
                          >
                            <Icon name="mdi:trash-can-outline" className="h-4 w-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
 
      {/* ========== CREATE/EDIT DRAWER ========== */}
      {drawerOpen && (
        <>
          <div
            className="fixed inset-0 z-50 bg-black/50 backdrop-blur-sm"
            onClick={() => setDrawerOpen(false)}
          />
          <div className="fixed right-0 top-0 z-50 h-full w-full max-w-md bg-white shadow-xl">
            <div className="flex items-center justify-between border-b border-slate-200 px-6 py-4">
              <h2 className="text-xl font-semibold text-slate-900">
                {editingRole ? "Edit Role" : "Create New Role"}
              </h2>
              <button
                onClick={() => setDrawerOpen(false)}
                className="rounded-lg p-1.5 text-slate-400 hover:bg-slate-100"
              >
                <Icon name="mdi:close" className="h-5 w-5" />
              </button>
            </div>
           
            <div className="p-6">
              <div className="space-y-4">
                <div>
                  <label className="mb-1 block text-sm font-medium text-slate-700">
                    Role Name <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="text"
                    value={roleName}
                    onChange={(e) => setRoleName(e.target.value)}
                    placeholder="e.g., Sales Rep, Manager, Admin"
                    className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  />
                </div>
               
                <div>
                  <label className="mb-1 block text-sm font-medium text-slate-700">
                    Description
                  </label>
                  <textarea
                    value={roleDescription}
                    onChange={(e) => setRoleDescription(e.target.value)}
                    rows={3}
                    placeholder="Brief description of this role's responsibilities"
                    className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  />
                </div>
              </div>
            </div>
 
            <div className="flex justify-end gap-3 border-t border-slate-200 px-6 py-4">
              <button
                onClick={() => setDrawerOpen(false)}
                className="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-medium text-slate-700 hover:bg-slate-50"
              >
                Cancel
              </button>
              <button
                onClick={saveRole}
                className="rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700"
              >
                {editingRole ? "Update" : "Create"} Role
              </button>
            </div>
          </div>
        </>
      )}
 
      {/* Delete Confirmation Modal */}
      {deleteTarget && (
        <>
          <div
            className="fixed inset-0 z-50 bg-black/50 backdrop-blur-sm"
            onClick={() => setDeleteTarget(null)}
          />
          <div className="fixed left-1/2 top-1/2 z-50 w-full max-w-md -translate-x-1/2 -translate-y-1/2 rounded-lg bg-white p-6 shadow-xl">
            <div className="text-center">
              <Icon name="mdi:alert-circle-outline" className="mx-auto mb-3 h-12 w-12 text-red-500" />
              <h3 className="text-lg font-semibold text-slate-900">Delete Role</h3>
              <p className="mt-2 text-sm text-slate-500">
                Are you sure you want to delete the role <span className="font-semibold">{deleteTarget?.name}</span>?
                This action cannot be undone.
              </p>
            </div>
            <div className="mt-5 flex justify-end gap-3">
              <button
                onClick={() => setDeleteTarget(null)}
                className="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-medium text-slate-700 hover:bg-slate-50"
              >
                Cancel
              </button>
              <button
                onClick={deleteRole}
                className="rounded-lg bg-red-600 px-4 py-2 text-sm font-medium text-white hover:bg-red-700"
              >
                Delete Role
              </button>
            </div>
          </div>
        </>
      )}
 
      {/* Toast Notification */}
      {toast && (
        <div className={`fixed bottom-6 right-6 z-50 flex items-center gap-2 rounded-lg px-4 py-3 text-sm font-medium text-white shadow-lg ${
          toast.type === "success" ? "bg-emerald-500" : "bg-red-500"
        }`}>
          <Icon name={toast.type === "success" ? "mdi:check-circle" : "mdi:alert-circle"} className="h-4 w-4" />
          {toast.message}
        </div>
      )}
    </section>
  );
}
 
