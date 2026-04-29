import { useState, useEffect, useMemo } from 'react'
import { Link, Outlet, useLocation, useNavigate } from 'react-router-dom'
import Icon from '../components/Icon'
import AppModal from '../components/common/AppModal'
import { useAuthStore } from '../stores/auth'
import { useAuth } from '../hooks/useAuth'
import { getInitials } from '../utils/format'

const pageTitles = {
  '/home': 'Dashboard', '/lead': 'Leads', '/opportunity': 'Opportunities',
  '/contact': 'Contacts', '/organization': 'Accounts', '/pipeline': 'Pipeline',
  '/deals': 'Deals', '/activities': 'Activities', '/emails': 'Emails',
  '/analytics': 'Analytics', '/reports': 'Reports', '/automation': 'Automation',
  '/project': 'Projects', '/task': 'Tasks', '/calendar': 'Calendar',
  '/team': 'Teams', '/team-member': 'Team Members', '/create-team': 'Manage Teams',
  '/role': 'Roles & Permissions', '/settings': 'Settings',
}

export default function DefaultLayout() {
  const location = useLocation()
  const navigate = useNavigate()
  const token = useAuthStore((s) => s.token)
  const user = useAuthStore((s) => s.user)
  const isAdmin = useAuthStore((s) => s.isAdmin())
  const hasAnyPermission = useAuthStore((s) => s.hasAnyPermission)
  const { logout } = useAuth()

  const [sidebarOpen, setSidebarOpen] = useState(false)
  const [navSearch, setNavSearch] = useState('')
  const [quickCreateOpen, setQuickCreateOpen] = useState(false)
  const [notificationsOpen, setNotificationsOpen] = useState(false)
  const [commandPaletteOpen, setCommandPaletteOpen] = useState(false)
  const [commandSearch, setCommandSearch] = useState('')

  const initials = useMemo(() =>
    getInitials(user?.username || user?.userEmail || ''),
    [user]
  )

  const notifications = [
    { title: '3 deals entered negotiation', description: 'Pipeline movement is above the weekly average.' },
    { title: '2 reports are ready for review', description: 'Forecast and win/loss summaries were refreshed.' },
    { title: 'Lead scoring workflow flagged 5 hot leads', description: 'Recommended for immediate follow-up.' },
  ]

  function canAccess(item) {
    if (!item.permissions || item.permissions.length === 0) return true
    return isAdmin || hasAnyPermission(item.permissions)
  }

  const navGroups = useMemo(() => {
    const base = [
      {
        label: 'Workspace',
        items: [
          { to: '/home', label: 'Dashboard', icon: 'mdi:view-dashboard-outline', permissions: ['dashboard.view'] },
          { to: '/activities', label: 'Activities', icon: 'mdi:timeline-text-outline' },
          { to: '/emails', label: 'Emails', icon: 'mdi:email-fast-outline', badge: 'Live' },
          { to: '/calendar', label: 'Calendar', icon: 'mdi:calendar-month-outline' },
        ],
      },
      {
        label: 'Revenue',
        items: [
          { to: '/lead', label: 'Leads', icon: 'mdi:account-arrow-right-outline', permissions: ['leads.view'] },
          { to: '/contact', label: 'Contacts', icon: 'mdi:contacts-outline', permissions: ['contacts.view'] },
          { to: '/organization', label: 'Accounts', icon: 'mdi:office-building-outline', permissions: ['organizations.view'] },
          { to: '/pipeline', label: 'Pipeline', icon: 'mdi:view-kanban-outline', permissions: ['opportunities.view'] },
          { to: '/deals', label: 'Deals', icon: 'mdi:cash-multiple', permissions: ['opportunities.view'] },
          { to: '/opportunity', label: 'Opportunities', icon: 'mdi:chart-line', permissions: ['opportunities.view'] },
        ],
      },
      {
        label: 'Delivery',
        items: [
          { to: '/project', label: 'Projects', icon: 'mdi:folder-outline', permissions: ['projects.view'] },
          { to: '/task', label: 'Tasks', icon: 'mdi:checkbox-marked-circle-outline', permissions: ['tasks.view'] },
          { to: '/team', label: 'Teams', icon: 'mdi:account-group-outline' },
          { to: '/team-member', label: 'Team Members', icon: 'mdi:account-multiple-outline' },
        ],
      },
      {
        label: 'Intelligence',
        items: [
          { to: '/analytics', label: 'Analytics', icon: 'mdi:chart-donut' },
          { to: '/reports', label: 'Reports', icon: 'mdi:file-chart-outline', permissions: ['reports.view'] },
          { to: '/automation', label: 'Automation', icon: 'mdi:robot-outline' },
        ],
      },
    ]

    if (isAdmin) {
      base.push({
        label: 'Admin',
        items: [
          { to: '/create-team', label: 'Manage Teams', icon: 'mdi:account-supervisor-circle-outline' },
          { to: '/role', label: 'Roles & Permissions', icon: 'mdi:shield-account-outline' },
          { to: '/settings', label: 'Settings', icon: 'mdi:cog-outline' },
        ],
      })
    }

    return base
      .map((group) => ({ ...group, items: group.items.filter(canAccess) }))
      .filter((group) => group.items.length > 0)
  }, [isAdmin, user])

  const filteredNavGroups = useMemo(() => {
    const query = navSearch.trim().toLowerCase()
    if (!query) return navGroups
    return navGroups
      .map((group) => ({
        ...group,
        items: group.items.filter((item) =>
          item.label.toLowerCase().includes(query) || item.to.toLowerCase().includes(query)
        ),
      }))
      .filter((group) => group.items.length > 0)
  }, [navGroups, navSearch])

  const commandItems = useMemo(() => {
    const allItems = navGroups.flatMap((g) => g.items)
    const query = commandSearch.trim().toLowerCase()
    if (!query) return allItems
    return allItems.filter((item) =>
      item.label.toLowerCase().includes(query) || item.to.toLowerCase().includes(query)
    )
  }, [navGroups, commandSearch])

  const quickCreateItems = [
    { to: '/lead', label: 'Lead', icon: 'mdi:account-plus-outline' },
    { to: '/deals', label: 'Deal', icon: 'mdi:cash-plus' },
    { to: '/activities', label: 'Activity', icon: 'mdi:timeline-plus-outline' },
    { to: '/reports', label: 'Report', icon: 'mdi:file-chart-outline' },
  ]

  const pageTitle = useMemo(() => {
    for (const [path, title] of Object.entries(pageTitles)) {
      if (location.pathname === path || location.pathname.startsWith(`${path}/`)) return title
    }
    return 'CRM'
  }, [location.pathname])

  function isActive(path) {
    return location.pathname === path || location.pathname.startsWith(`${path}/`)
  }

  function goToRoute(path) {
    setQuickCreateOpen(false)
    setNotificationsOpen(false)
    setCommandPaletteOpen(false)
    setSidebarOpen(false)
    navigate(path)
  }

  useEffect(() => {
    setSidebarOpen(false)
  }, [location.pathname])

  useEffect(() => {
    function onKeyDown(e) {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') {
        e.preventDefault()
        setCommandPaletteOpen(true)
      }
    }
    window.addEventListener('keydown', onKeyDown)
    return () => window.removeEventListener('keydown', onKeyDown)
  }, [])

  return (
    <div className="flex h-screen overflow-hidden bg-[radial-gradient(circle_at_top_left,_rgba(59,130,246,0.16),_transparent_28%),linear-gradient(180deg,_#f8fbff_0%,_#eef4ff_46%,_#f8fafc_100%)]">
      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-40 flex flex-col w-72 border-r border-white/60 bg-white/92 shadow-[0_22px_48px_rgba(15,23,42,0.08)] backdrop-blur-xl transition-transform duration-300 ${sidebarOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'}`}
      >
        {/* Logo */}
        <div className="px-5 py-4 border-b border-slate-100">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-[linear-gradient(135deg,#2563eb_0%,#4f46e5_52%,#0f172a_100%)] flex items-center justify-center shadow-md shadow-blue-200/70">
              <Icon name="mdi:orbit-variant" className="text-white w-5 h-5" />
            </div>
            <div>
              <span className="font-bold text-slate-900 text-lg leading-none">Xform CRM</span>
              <p className="text-[11px] text-blue-600 font-semibold mt-0.5 tracking-wide uppercase">Revenue Control Center</p>
            </div>
          </div>

          <div className="mt-3 rounded-2xl bg-slate-950 text-white p-4 shadow-lg">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-[11px] uppercase tracking-[0.16em] text-slate-400">Quarter Momentum</p>
                <p className="text-2xl font-bold mt-2">78%</p>
              </div>
              <div className="px-2 py-1 rounded-full bg-emerald-500/15 text-emerald-300 text-xs font-semibold">+12%</div>
            </div>
            <div className="mt-3 h-2 rounded-full bg-white/10 overflow-hidden">
              <div className="h-full w-[78%] rounded-full bg-[linear-gradient(90deg,#60a5fa,#34d399)]" />
            </div>
            {/* <p className="mt-3 text-xs text-slate-300">Healthy pipeline velocity with strong enterprise close potential this month.</p> */}
          </div>

          <div className="mt-3 relative">
            <Icon name="mdi:magnify" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
            <input
              type="text"
              value={navSearch}
              onChange={(e) => setNavSearch(e.target.value)}
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
                  className={`sidebar-link ${isActive(item.to) ? 'active' : ''}`}
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
              <p className="text-sm font-semibold text-slate-800 truncate">{user?.username}</p>
              <p className="text-xs text-slate-500 truncate capitalize">{user?.role}</p>
            </div>
            <button
              onClick={logout}
              className="p-1.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all opacity-0 group-hover:opacity-100"
            >
              <Icon name="mdi:logout-variant" className="w-4 h-4" />
            </button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className="flex-1 flex flex-col md:ml-72 min-w-0">
        {/* Header */}
        <header className="min-h-[72px] border-b border-white/70 bg-white/85 backdrop-blur-xl px-4 shadow-header sticky top-0 z-30 md:px-6">
          <div className="grid h-[72px] grid-cols-[auto_1fr] items-center gap-3 xl:grid-cols-[360px_minmax(320px,460px)_1fr]">
          <button
            onClick={() => setSidebarOpen((v) => !v)}
            className="md:hidden inline-flex h-10 w-10 items-center justify-center rounded-xl text-slate-500 hover:bg-slate-100 transition-colors"
          >
            <Icon name="mdi:menu" className="w-5 h-5" />
          </button>
          <div className="min-w-0">
            <div className="flex items-center gap-2">
              <div className="hidden h-9 w-1 rounded-full bg-gradient-to-b from-indigo-600 to-sky-500 md:block" />
              <div className="min-w-0">
                <h1 className="truncate text-xl font-bold leading-6 text-slate-900">{pageTitle}</h1>
                <p className="hidden truncate text-xs leading-5 text-slate-500 lg:block">
                  Command center for pipeline and team operations.
                </p>
              </div>
            </div>
          </div>
          <button
            type="button"
            className="hidden h-11 min-w-0 items-center justify-between gap-3 rounded-2xl border border-slate-200 bg-white px-4 text-sm text-slate-500 shadow-sm transition-colors hover:border-indigo-300 hover:text-indigo-600 lg:flex"
            onClick={() => setCommandPaletteOpen(true)}
          >
            <span className="flex min-w-0 items-center gap-2">
              <Icon name="mdi:magnify" className="h-4 w-4 shrink-0" />
              <span className="truncate">Search records, workflows, reports...</span>
            </span>
            <span className="shrink-0 rounded-lg bg-slate-100 px-2 py-1 text-[11px] leading-none text-slate-500">Ctrl K</span>
          </button>

          <div className="col-start-2 flex min-w-0 justify-end xl:col-start-3">
          <div className="flex shrink-0 items-center gap-2">
            <button
              type="button"
              className="hidden h-11 items-center gap-2 whitespace-nowrap rounded-2xl border border-slate-200 bg-slate-950 px-4 text-sm font-semibold text-white shadow-sm md:inline-flex"
              onClick={() => setQuickCreateOpen(true)}
            >
              <Icon name="mdi:plus" className="w-4 h-4" />
              Quick Create
            </button>
            <div className="hidden h-11 items-center gap-2 whitespace-nowrap rounded-2xl border border-slate-100 bg-white px-3 text-sm text-slate-500 shadow-sm xl:flex">
              <Icon name="mdi:calendar-today" className="w-3.5 h-3.5 text-indigo-500" />
              {new Date().toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' })}
            </div>
            <button
              type="button"
              className="hidden h-11 w-11 items-center justify-center rounded-2xl border border-slate-100 bg-white text-slate-500 shadow-sm md:inline-flex"
              onClick={() => setNotificationsOpen(true)}
            >
              <Icon name="mdi:bell-outline" className="w-5 h-5" />
            </button>
            <div className="flex h-11 items-center gap-2 whitespace-nowrap">
              <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-indigo-500 to-blue-500 text-xs font-bold text-white shadow-sm">
                {initials}
              </div>
              <span className="hidden max-w-28 truncate text-sm font-semibold text-slate-700 xl:block">{user?.username}</span>
            </div>
            <button
              onClick={logout}
              className="flex h-11 items-center gap-1.5 whitespace-nowrap rounded-2xl border border-transparent px-2.5 text-sm font-medium text-slate-500 transition-all hover:border-red-100 hover:bg-red-50 hover:text-red-600 md:px-3"
            >
              <Icon name="mdi:logout-variant" className="w-4 h-4" />
              <span className="hidden lg:block">Logout</span>
            </button>
          </div>
          </div>
          </div>
        </header>

        {/* Page content */}
        <main className="flex-1 overflow-y-auto p-3 md:p-5 animate-fade-in crm-grid-bg">
          <Outlet />
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
      <AppModal open={quickCreateOpen} onClose={() => setQuickCreateOpen(false)} title="Quick Create" size="lg">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {quickCreateItems.map((item) => (
            <button
              key={item.to}
              type="button"
              className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-4 text-left transition-all hover:border-indigo-300 hover:bg-indigo-50"
              onClick={() => goToRoute(item.to)}
            >
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-white border border-slate-200 flex items-center justify-center text-slate-600">
                  <Icon name={item.icon} className="w-5 h-5" />
                </div>
                <div>
                  <p className="text-sm font-semibold text-slate-800">{item.label}</p>
                  <p className="text-xs text-slate-500 mt-1">Jump directly to {item.label.toLowerCase()}</p>
                </div>
              </div>
            </button>
          ))}
        </div>
      </AppModal>

      {/* Notifications Modal */}
      <AppModal open={notificationsOpen} onClose={() => setNotificationsOpen(false)} title="Notifications" size="lg">
        <div className="space-y-3">
          {notifications.map((note) => (
            <div key={note.title} className="rounded-2xl border border-slate-100 bg-slate-50 p-4">
              <p className="text-sm font-semibold text-slate-800">{note.title}</p>
              <p className="text-xs text-slate-500 mt-1">{note.description}</p>
            </div>
          ))}
        </div>
      </AppModal>

      {/* Command Palette Modal */}
      <AppModal open={commandPaletteOpen} onClose={() => setCommandPaletteOpen(false)} title="Navigate Anywhere" size="2xl">
        <div className="mb-4 relative">
          <Icon name="mdi:magnify" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <input
            type="text"
            value={commandSearch}
            onChange={(e) => setCommandSearch(e.target.value)}
            className="w-full rounded-2xl border border-slate-200 bg-white px-10 py-3 text-sm text-slate-700 outline-none transition-all focus:border-indigo-400 focus:ring-2 focus:ring-indigo-500/15"
            placeholder="Type to find routes, modules and workspaces"
          />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3 max-h-[50vh] overflow-y-auto pr-1">
          {commandItems.map((item) => (
            <button
              key={item.to}
              type="button"
              className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-4 text-left transition-all hover:border-indigo-300 hover:bg-indigo-50"
              onClick={() => goToRoute(item.to)}
            >
              <div className="flex items-center gap-3">
                <Icon name={item.icon} className="w-5 h-5 text-slate-600" />
                <div>
                  <p className="text-sm font-semibold text-slate-800">{item.label}</p>
                  <p className="text-xs text-slate-500 mt-1">{item.to}</p>
                </div>
              </div>
            </button>
          ))}
        </div>
      </AppModal>
    </div>
  )
}
