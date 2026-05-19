import { useState, useEffect, useMemo } from "react";
import { Link, Outlet, useLocation, useNavigate } from "react-router-dom";
import Icon from "../components/Icon";
import AppModal from "../components/common/AppModal";
import { useAuthStore } from "../stores/auth";
import { useAuth } from "../hooks/useAuth";
import { useLead } from "../hooks/useLead";
import { useOpportunity } from "../hooks/useOpportunity";
import { useCalendar } from "../hooks/useCalendar";
import { getInitials } from "../utils/format";

const pageTitles = {
  "/home": "Dashboard",
  "/lead": "Leads",
  "/opportunity": "Opportunities",
  "/contact": "Contacts",
  "/organization": "Organizations",
  "/pipeline": "Pipeline",
  "/deals": "Deals",
  "/activities": "Activities",
  "/emails": "Emails",
  "/analytics": "Analytics",
  "/reports": "Reports",
  "/automation": "Automation",
  "/project": "Projects",
  "/task": "Tasks",
  "/calendar": "Calendar",
  "/attendance": "Attendance",
  "/team": "Teams",
  "/team-member": "Team Members",
  "/create-team": "Manage Teams",
  "/role": "Roles & Permissions",
  "/settings": "Settings",
};

function getDateValue(...values) {
  for (const value of values) {
    if (!value) continue;
    const date = new Date(value);
    if (!Number.isNaN(date.getTime())) return date;
  }
  return null;
}

function formatRelativeTime(date) {
  if (!date) return "Open now";
  const diffMs = date.getTime() - Date.now();
  const absMs = Math.abs(diffMs);
  const minutes = Math.round(absMs / 60000);
  const hours = Math.round(absMs / 3600000);
  const days = Math.round(absMs / 86400000);
  const suffix = diffMs >= 0 ? "from now" : "ago";

  if (minutes < 60) return `${Math.max(minutes, 1)} min ${suffix}`;
  if (hours < 24) return `${hours} hour${hours === 1 ? "" : "s"} ${suffix}`;
  return `${days} day${days === 1 ? "" : "s"} ${suffix}`;
}

function sortByNewest(items, getDate) {
  return [...items].sort((a, b) => {
    const bDate = getDate(b)?.getTime() || 0;
    const aDate = getDate(a)?.getTime() || 0;
    return bDate - aDate;
  });
}

export default function DefaultLayout() {
  const location = useLocation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const isAdmin = useAuthStore((s) => s.isAdmin());
  const hasAnyPermission = useAuthStore((s) => s.hasAnyPermission);
  const { logout } = useAuth();
  const leadApi = useLead();
  const opportunityApi = useOpportunity();
  const calendarApi = useCalendar();

  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [quickCreateOpen, setQuickCreateOpen] = useState(false);
  const [notificationsOpen, setNotificationsOpen] = useState(false);
  const [userMenuOpen, setUserMenuOpen] = useState(false);
  const [commandPaletteOpen, setCommandPaletteOpen] = useState(false);
  const [commandSearch, setCommandSearch] = useState("");
  const [headerBadge, setHeaderBadge] = useState(null);
  const [readNotificationIds, setReadNotificationIds] = useState(() => {
    try {
      return new Set(JSON.parse(localStorage.getItem("crm-read-notifications") || "[]"));
    } catch {
      return new Set();
    }
  });
  const [notificationItems, setNotificationItems] = useState([]);

  const initials = useMemo(
    () => getInitials(user?.username || user?.userEmail || ""),
    [user]
  );

  const fallbackNotifications = [
    {
      id: 1,
      title: "New lead assigned",
      description: "John Smith has been assigned to you",
      time: "5 min ago",
      read: false,
      type: "lead",
      icon: "mdi:account-arrow-right-outline",
      path: "/lead",
    },
    {
      id: 2,
      title: "Deal won",
      description: "Enterprise deal closed at $50,000",
      time: "1 hour ago",
      read: false,
      type: "deal",
      icon: "mdi:trophy-outline",
      path: "/opportunity",
    },
    {
      id: 3,
      title: "Meeting reminder",
      description: "Team sync in 30 minutes",
      time: "2 hours ago",
      read: true,
      type: "reminder",
      icon: "mdi:calendar-clock-outline",
      path: "/calendar",
    },
  ];

  useEffect(() => {
    localStorage.setItem("crm-read-notifications", JSON.stringify([...readNotificationIds]));
  }, [readNotificationIds]);

  useEffect(() => {
    let alive = true;

    async function loadNotifications() {
      const [leads, opportunities, calendarData] = await Promise.all([
        leadApi.getAll().catch(() => []),
        opportunityApi.getAll().catch(() => []),
        calendarApi.getAllEvents().catch(() => ({ events: [] })),
      ]);

      const latestLead = sortByNewest(Array.isArray(leads) ? leads : [], (lead) =>
        getDateValue(lead.leadCreatedDate, lead.inquiryDate, lead.createdAt)
      )[0];
      const wonDeal = sortByNewest(
        (Array.isArray(opportunities) ? opportunities : []).filter((opp) =>
          String(opp.oppStatus || opp.status || "").toLowerCase().includes("won")
        ),
        (opp) => getDateValue(opp.oppActualCloseDate, opp.oppForcastCloseDate, opp.createdAt)
      )[0];
      const upcomingMeeting = (calendarData.events || [])
        .map((event) => {
          const priority = String(event.priority || "").toLowerCase();
          const type = priority === "meeting" ? "Meeting" : String(event.type || "");
          return {
            ...event,
            type,
            dateValue: getDateValue(event.time, event.date, event.reminderDate),
          };
        })
        .filter((event) => event.dateValue && event.dateValue.getTime() >= Date.now() - 3600000)
        .filter((event) => event.type.toLowerCase().includes("meeting") || event.type.toLowerCase().includes("reminder"))
        .sort((a, b) => a.dateValue.getTime() - b.dateValue.getTime())[0];

      const nextItems = [
        {
          id: latestLead ? `lead-${latestLead.leadId || latestLead.id}` : "lead-empty",
          title: "New lead assigned",
          description: latestLead
            ? `${latestLead.leadName || latestLead.name || "A lead"} is ready for follow-up`
            : "Open the lead workspace to review assignments",
          time: formatRelativeTime(getDateValue(latestLead?.leadCreatedDate, latestLead?.inquiryDate, latestLead?.createdAt)),
          icon: "mdi:account-arrow-right-outline",
          path: latestLead?.leadId ? `/lead/${latestLead.leadId}` : "/lead",
        },
        {
          id: wonDeal ? `deal-${wonDeal.oppId || wonDeal.id}` : "deal-empty",
          title: "Deal won",
          description: wonDeal
            ? `${wonDeal.oppName || wonDeal.opportunityName || wonDeal.title || "Opportunity"} closed successfully`
            : "Open opportunities to review won deals",
          time: formatRelativeTime(getDateValue(wonDeal?.oppActualCloseDate, wonDeal?.oppForcastCloseDate, wonDeal?.createdAt)),
          icon: "mdi:trophy-outline",
          path: "/opportunity",
        },
        {
          id: upcomingMeeting ? `meeting-${upcomingMeeting.type}-${upcomingMeeting.id}` : "meeting-empty",
          title: "Meeting reminder",
          description: upcomingMeeting
            ? `${upcomingMeeting.title || "Calendar item"} is on your calendar`
            : "Open calendar to review meetings, reminders, and tasks",
          time: formatRelativeTime(upcomingMeeting?.dateValue),
          icon: "mdi:calendar-clock-outline",
          path: "/calendar",
        },
      ];

      if (alive) setNotificationItems(nextItems);
    }

    loadNotifications();
    return () => {
      alive = false;
    };
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  const notifications = useMemo(
    () => (notificationItems.length ? notificationItems : fallbackNotifications).map((item) => ({
      ...item,
      read: readNotificationIds.has(item.id),
    })),
    [fallbackNotifications, notificationItems, readNotificationIds]
  );

  const unreadCount = notifications.filter((n) => !n.read).length;

  const canAccess = (item) => {
    if (!item.permissions || item.permissions.length === 0) return true;
    return isAdmin || hasAnyPermission(item.permissions);
  };

  const navGroups = useMemo(() => {
    const groups = [
      {
        label: "MAIN",
        items: [
          {
            to: "/home",
            label: "Dashboard",
            icon: "mdi:view-dashboard-outline",
            permissions: ["dashboard.view"],
          },
          {
            to: "/activities",
            label: "Activities",
            icon: "mdi:timeline-text-outline",
          },
          {
            to: "/emails",
            label: "Emails",
            icon: "mdi:email-fast-outline",
            badge: "Live",
          },
          {
            to: "/calendar",
            label: "Calendar",
            icon: "mdi:calendar-month-outline",
          },
          {
            to: "/attendance",
            label: "Attendance",
            icon: "mdi:clock-check-outline",
          },
        ],
      },
      {
        label: "SALES",
        items: [
          {
            to: "/lead",
            label: "Leads",
            icon: "mdi:account-arrow-right-outline",
            permissions: ["leads.view"],
          },
          {
            to: "/contact",
            label: "Contacts",
            icon: "mdi:contacts-outline",
            permissions: ["contacts.view"],
          },
          {
            to: "/organization",
            label: "Organizations",
            icon: "mdi:office-building-outline",
            permissions: ["organizations.view"],
          },
          {
            to: "/pipeline",
            label: "Pipeline",
            icon: "mdi:view-kanban-outline",
            permissions: ["opportunities.view"],
          },
          {
            to: "/deals",
            label: "Deals",
            icon: "mdi:cash-multiple",
            permissions: ["opportunities.view"],
          },
          {
            to: "/opportunity",
            label: "Opportunities",
            icon: "mdi:chart-line",
            permissions: ["opportunities.view"],
          },
        ],
      },
      {
        label: "PROJECTS",
        items: [
          {
            to: "/project",
            label: "Projects",
            icon: "mdi:folder-outline",
            permissions: ["projects.view"],
          },
          {
            to: "/task",
            label: "Tasks",
            icon: "mdi:checkbox-marked-circle-outline",
            permissions: ["tasks.view"],
          },
          {
            to: "/team",
            label: "Teams",
            icon: "mdi:account-group-outline",
          },
          {
            to: "/team-member",
            label: "Team Members",
            icon: "mdi:account-multiple-outline",
          },
        ],
      },
      {
        label: "ANALYTICS",
        items: [
          {
            to: "/analytics",
            label: "Analytics",
            icon: "mdi:chart-donut",
          },
          {
            to: "/reports",
            label: "Reports",
            icon: "mdi:file-chart-outline",
            permissions: ["reports.view"],
          },
          {
            to: "/automation",
            label: "Automation",
            icon: "mdi:robot-outline",
          },
        ],
      },
    ];

    if (isAdmin) {
      groups.push({
        label: "ADMIN",
        items: [
          {
            to: "/create-team",
            label: "Manage Teams",
            icon: "mdi:account-supervisor-circle-outline",
          },
          {
            to: "/role",
            label: "Roles & Permissions",
            icon: "mdi:shield-account-outline",
          },
          {
            to: "/settings",
            label: "Settings",
            icon: "mdi:cog-outline",
          },
        ],
      });
    }

    return groups
      .map((group) => ({
        ...group,
        items: group.items.filter(canAccess),
      }))
      .filter((group) => group.items.length > 0);
  }, [isAdmin]);

  const filteredNavGroups = useMemo(() => {
    const query = searchQuery.trim().toLowerCase();
    if (!query) return navGroups;
    return navGroups
      .map((group) => ({
        ...group,
        items: group.items.filter(
          (item) =>
            item.label.toLowerCase().includes(query) ||
            item.to.toLowerCase().includes(query)
        ),
      }))
      .filter((group) => group.items.length > 0);
  }, [navGroups, searchQuery]);

  const commandItems = useMemo(() => {
    const allItems = navGroups.flatMap((g) => g.items);
    const query = commandSearch.trim().toLowerCase();
    if (!query) return allItems.slice(0, 10);
    return allItems.filter(
      (item) =>
        item.label.toLowerCase().includes(query) ||
        item.to.toLowerCase().includes(query)
    );
  }, [navGroups, commandSearch]);

  const quickCreateItems = [
    { to: "/lead", label: "New Lead", icon: "mdi:account-plus-outline", color: "blue" },
    { to: "/deals", label: "New Deal", icon: "mdi:cash-plus", color: "green" },
    { to: "/activities", label: "Log Activity", icon: "mdi:timeline-plus-outline", color: "purple" },
    { to: "/contact", label: "New Contact", icon: "mdi:account-plus", color: "orange" },
  ];

  const pageTitle = useMemo(() => {
    for (const [path, title] of Object.entries(pageTitles)) {
      if (location.pathname === path || location.pathname.startsWith(`${path}/`)) {
        return title;
      }
    }
    return "Dashboard";
  }, [location.pathname]);

  const isActive = (path) => {
    return location.pathname === path || location.pathname.startsWith(`${path}/`);
  };

  const navigateTo = (path) => {
    setQuickCreateOpen(false);
    setNotificationsOpen(false);
    setCommandPaletteOpen(false);
    setUserMenuOpen(false);
    setSidebarOpen(false);
    navigate(path);
  };

  const openNotification = (notification) => {
    setReadNotificationIds((prev) => new Set(prev).add(notification.id));
    setNotificationsOpen(false);
    navigate(notification.path || "/home");
  };

  // Close sidebar on route change on mobile
  useEffect(() => {
    setSidebarOpen(false);
  }, [location.pathname]);

  // Keyboard shortcut for command palette
  useEffect(() => {
    const handleKeyDown = (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key === "k") {
        e.preventDefault();
        setCommandPaletteOpen(true);
      }
      if (e.key === "Escape" && commandPaletteOpen) {
        setCommandPaletteOpen(false);
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [commandPaletteOpen]);

  // Close user menu when clicking outside
  useEffect(() => {
    const handleClickOutside = (e) => {
      if (userMenuOpen && !e.target.closest(".user-menu")) {
        setUserMenuOpen(false);
      }
    };
    document.addEventListener("click", handleClickOutside);
    return () => document.removeEventListener("click", handleClickOutside);
  }, [userMenuOpen]);

  return (
    <div className="flex h-screen overflow-hidden bg-[radial-gradient(circle_at_top_left,_rgba(59,130,246,0.16),_transparent_28%),linear-gradient(180deg,_#f8fbff_0%,_#eef4ff_46%,_#f8fafc_100%)]">
      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-40 flex flex-col w-72 border-r border-white/60 bg-white/92 shadow-[0_22px_48px_rgba(15,23,42,0.08)] backdrop-blur-xl transition-transform duration-300 ${
          sidebarOpen ? "translate-x-0" : "-translate-x-full md:translate-x-0"
        }`}
      >
        {/* Logo Area */}
        <div className="px-5 py-4 border-b border-slate-100">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-[linear-gradient(135deg,#2563eb_0%,#4f46e5_52%,#0f172a_100%)] flex items-center justify-center shadow-md shadow-blue-200/70">
              <Icon name="mdi:orbit-variant" className="text-white w-5 h-5" />
            </div>
            <div>
              <span className="font-bold text-slate-900 text-lg leading-none">
                Xform CRM
              </span>
              <p className="text-[11px] text-blue-600 font-semibold mt-0.5 tracking-wide uppercase">
                Revenue Control Center
              </p>
            </div>
          </div>

          <div className="mt-3 rounded-2xl bg-slate-950 text-white p-4 shadow-lg">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-[11px] uppercase tracking-[0.16em] text-slate-400">
                  Quarter Momentum
                </p>
                <p className="text-2xl font-bold mt-2">78%</p>
              </div>
              <div className="px-2 py-1 rounded-full bg-emerald-500/15 text-emerald-300 text-xs font-semibold">
                +12%
              </div>
            </div>
            <div className="mt-3 h-2 rounded-full bg-white/10 overflow-hidden">
              <div className="h-full w-[78%] rounded-full bg-[linear-gradient(90deg,#60a5fa,#34d399)]" />
            </div>
          </div>

          <div className="mt-3 relative">
            <Icon
              name="mdi:magnify"
              className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"
            />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Filter sidebar modules..."
              className="w-full rounded-2xl border border-slate-200 bg-white px-10 py-2.5 text-sm text-slate-700 shadow-sm outline-none transition-all focus:border-indigo-400 focus:ring-2 focus:ring-indigo-500/15"
            />
          </div>
        </div>

        {/* Navigation */}
        <nav className="flex-1 overflow-y-auto px-3 py-3">
          {filteredNavGroups.map((group) => (
            <div key={group.label} className="mb-4 last:mb-0">
              <p className="nav-section-label">{group.label}</p>
              {group.items.map((item) => (
                <Link
                  key={item.to}
                  to={item.to}
                  className={`sidebar-link ${isActive(item.to) ? "active" : ""}`}
                  onClick={() => setSidebarOpen(false)}
                >
                  <Icon name={item.icon} className="w-5 h-5" />
                  <span>{item.label}</span>
                  {item.badge && (
                    <span className="ml-auto rounded-full bg-slate-100 px-2 py-0.5 text-[10px] font-semibold text-slate-500">
                      {item.badge}
                    </span>
                  )}
                </Link>
              ))}
            </div>
          ))}
        </nav>

        {/* User info */}
        <div className="px-3 py-4 border-t border-slate-100">
          <div className="flex items-center gap-3 px-2 py-2 rounded-2xl hover:bg-slate-50 transition-colors group">
            <div className="w-10 h-10 rounded-2xl bg-gradient-to-br from-indigo-500 to-blue-500 flex items-center justify-center shadow-sm flex-shrink-0">
              <span className="text-white font-bold text-sm">{initials}</span>
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-semibold text-slate-800 truncate">
                {user?.username}
              </p>
              <p className="text-xs text-slate-500 truncate capitalize">
                {user?.role}
              </p>
            </div>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className="flex-1 flex flex-col md:ml-72 min-w-0 overflow-hidden">
        {/* Header - Fixed positioning */}
        <header className="flex-shrink-0 border-b border-white/70 bg-white/85 backdrop-blur-xl shadow-header sticky top-0 z-30">
          <div className="px-4 md:px-6 py-3">
            <div className="flex items-center justify-between gap-4">
              {/* Left section */}
              <div className="flex items-center gap-4 min-w-0 flex-1">
                <button
                  onClick={() => setSidebarOpen((v) => !v)}
                  className="md:hidden inline-flex h-10 w-10 items-center justify-center rounded-xl text-slate-500 hover:bg-slate-100 transition-colors flex-shrink-0"
                >
                  <Icon name="mdi:menu" className="w-5 h-5" />
                </button>
                
                <div className="hidden h-9 w-1 rounded-full bg-gradient-to-b from-indigo-600 to-sky-500 md:block flex-shrink-0" />
                
                <div className="min-w-0 flex-1">
                  <div className="flex items-center gap-2 flex-wrap">
                    <h1 className="text-xl font-bold leading-6 text-slate-900 truncate">
                      {pageTitle}
                    </h1>
                    {headerBadge != null && (
                      <span className="inline-flex items-center justify-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-700 whitespace-nowrap">
                        {headerBadge}
                      </span>
                    )}
                  </div>
                  <p className="hidden truncate text-xs leading-5 text-slate-500 lg:block">
                    Command center for pipeline and team operations.
                  </p>
                </div>
              </div>

              {/* Right section */}
              <div className="flex items-center gap-2 flex-shrink-0">
                {/* Search Button */}
                <button
                  type="button"
                  className="hidden lg:flex h-10 items-center gap-2 rounded-xl border border-slate-200 bg-white px-3 text-sm text-slate-500 shadow-sm transition-colors hover:border-indigo-300 hover:text-indigo-600 whitespace-nowrap"
                  onClick={() => setCommandPaletteOpen(true)}
                >
                  <Icon name="mdi:magnify" className="h-4 w-4 shrink-0" />
                  <span className="truncate">Search...</span>
                  <kbd className="rounded bg-slate-100 px-1.5 py-0.5 text-[10px] font-medium text-slate-500">
                    ⌘K
                  </kbd>
                </button>

                {/* Quick Create */}
                <button
                  type="button"
                  className="hidden md:flex h-10 items-center gap-2 rounded-xl border border-slate-200 bg-slate-950 px-3 text-sm font-semibold text-white shadow-sm whitespace-nowrap"
                  onClick={() => setQuickCreateOpen(true)}
                >
                  <Icon name="mdi:plus" className="w-4 h-4" />
                  <span>Quick Create</span>
                </button>

                {/* Calendar */}
                <div className="hidden xl:flex h-10 items-center gap-2 rounded-xl border border-slate-100 bg-white px-3 text-sm text-slate-500 shadow-sm whitespace-nowrap">
                  <Icon name="mdi:calendar-today" className="w-3.5 h-3.5 text-indigo-500" />
                  <span>{new Date().toLocaleDateString("en-IN", {
                    day: "numeric",
                    month: "short",
                    year: "numeric",
                  })}</span>
                </div>

                {/* Notifications */}
                <button
                  type="button"
                  className="relative h-10 w-10 items-center justify-center rounded-xl border border-slate-100 bg-white text-slate-500 shadow-sm hidden md:inline-flex flex-shrink-0"
                  onClick={() => setNotificationsOpen(true)}
                >
                  <Icon name="mdi:bell-outline" className="w-5 h-5" />
                  {unreadCount > 0 && (
                    <span className="absolute -top-1 -right-1 h-4 w-4 rounded-full bg-red-500 text-[10px] font-bold text-white flex items-center justify-center">
                      {unreadCount}
                    </span>
                  )}
                </button>

                {/* Logout Button */}
                <button
                  onClick={logout}
                  className="flex h-10 items-center gap-2 rounded-xl border border-red-200 bg-white px-3 text-sm font-medium text-red-600 transition-all hover:bg-red-50 hover:border-red-300 shadow-sm whitespace-nowrap"
                >
                  <Icon name="mdi:logout-variant" className="w-4 h-4" />
                  <span className="hidden lg:inline">Logout</span>
                </button>

                {/* User Avatar */}
                <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-br from-indigo-500 to-blue-500 text-xs font-bold text-white shadow-sm flex-shrink-0">
                  {initials}
                </div>
              </div>
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="flex-1 overflow-y-auto p-3 md:p-5 animate-fade-in">
          <Outlet context={{ setHeaderBadge }} />
        </main>
      </div>

      {/* Sidebar overlay for mobile */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-30 bg-black/40 backdrop-blur-sm md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Quick Create Modal */}
      <AppModal
        open={quickCreateOpen}
        onClose={() => setQuickCreateOpen(false)}
        title="Quick Create"
        size="lg"
      >
        <div className="grid gap-3 sm:grid-cols-2">
          {quickCreateItems.map((item) => (
            <button
              key={item.to}
              onClick={() => navigateTo(item.to)}
              className="group flex items-center gap-4 rounded-lg border border-gray-200 p-4 transition-all hover:border-blue-200 hover:bg-blue-50"
            >
              <div
                className={`flex h-12 w-12 items-center justify-center rounded-lg bg-${item.color}-50 text-${item.color}-600`}
              >
                <Icon name={item.icon} className="h-6 w-6" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-gray-900 group-hover:text-blue-700">
                  {item.label}
                </p>
                <p className="text-xs text-gray-500">Create a new {item.label.toLowerCase()}</p>
              </div>
            </button>
          ))}
        </div>
      </AppModal>

      {/* Notifications Modal */}
      <AppModal
        open={notificationsOpen}
        onClose={() => setNotificationsOpen(false)}
        title="Notifications"
      >
        {notifications.length === 0 ? (
          <div className="py-8 text-center">
            <Icon name="mdi:bell-off" className="mx-auto h-12 w-12 text-gray-300" />
            <p className="mt-2 text-sm text-gray-500">No notifications</p>
          </div>
        ) : (
          <div className="space-y-3">
            {notifications.map((notification) => (
              <button
                type="button"
                key={notification.id}
                onClick={() => openNotification(notification)}
                className={`w-full rounded-lg border p-4 text-left transition-colors hover:border-blue-200 hover:bg-blue-50/60 ${
                  notification.read ? "border-gray-100" : "border-blue-100 bg-blue-50/30"
                }`}
              >
                <div className="flex items-start justify-between">
                  <div className="flex min-w-0 flex-1 gap-3">
                    <span className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white text-blue-600 shadow-sm">
                      <Icon name={notification.icon || "mdi:bell-outline"} className="h-5 w-5" />
                    </span>
                    <div className="min-w-0">
                    <p className="text-sm font-semibold text-gray-900">
                      {notification.title}
                    </p>
                    <p className="mt-1 text-xs text-gray-500">{notification.description}</p>
                    <p className="mt-2 text-xs text-gray-400">{notification.time}</p>
                    </div>
                  </div>
                  {!notification.read && (
                    <div className="h-2 w-2 rounded-full bg-blue-600"></div>
                  )}
                </div>
              </button>
            ))}
          </div>
        )}
      </AppModal>

      {/* Command Palette Modal */}
      <AppModal
        open={commandPaletteOpen}
        onClose={() => setCommandPaletteOpen(false)}
        title="Command Palette"
        size="2xl"
      >
        <div className="relative mb-4">
          <Icon
            name="mdi:magnify"
            className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400"
          />
          <input
            type="text"
            value={commandSearch}
            onChange={(e) => setCommandSearch(e.target.value)}
            placeholder="Search for pages, actions, or settings..."
            className="w-full rounded-lg border border-gray-200 py-2.5 pl-9 pr-3 text-sm text-gray-900 placeholder:text-gray-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
            autoFocus
          />
        </div>
        <div className="max-h-[50vh] overflow-y-auto">
          {commandItems.length === 0 ? (
            <div className="py-8 text-center">
              <p className="text-sm text-gray-500">No results found</p>
            </div>
          ) : (
            <div className="space-y-1">
              {commandItems.map((item) => (
                <button
                  key={item.to}
                  onClick={() => navigateTo(item.to)}
                  className="flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left transition-colors hover:bg-gray-50"
                >
                  <Icon name={item.icon} className="h-5 w-5 text-gray-400" />
                  <div>
                    <p className="text-sm font-medium text-gray-900">{item.label}</p>
                    <p className="text-xs text-gray-500">{item.to}</p>
                  </div>
                </button>
              ))}
            </div>
          )}
        </div>
      </AppModal>
    </div>
  );
}
