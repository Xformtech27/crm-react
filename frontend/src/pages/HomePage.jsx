import { useState, useEffect, useMemo, useCallback } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Bar, Doughnut } from 'react-chartjs-2'
import {
  Chart as ChartJS, CategoryScale, LinearScale, BarElement,
  ArcElement, Tooltip, Legend,
} from 'chart.js'
import { useDashboard } from '../hooks/useDashboard'
import { useLead } from '../hooks/useLead'
import { useTask } from '../hooks/useTask'
import { useAdvancedCrmData } from '../hooks/useAdvancedCrmData'
import { useAuthStore } from '../stores/auth'
import Icon from '../components/Icon'

ChartJS.register(CategoryScale, LinearScale, BarElement, ArcElement, Tooltip, Legend)

const GRADE_COLORS = {
  A: 'bg-emerald-100 text-emerald-700 border-emerald-200',
  B: 'bg-blue-100 text-blue-700 border-blue-200',
  C: 'bg-amber-100 text-amber-700 border-amber-200',
  D: 'bg-red-100 text-red-700 border-red-200',
}
const PRIORITY_COLORS = { high: 'bg-red-500', medium: 'bg-amber-400', low: 'bg-teal-400' }
const DATE_LABELS = { today: 'Today', week: 'This Week', month: 'This Month', quarter: 'This Quarter' }
const STATUS_PALETTE = ['#10b981', '#3b82f6', '#f59e0b', '#94a3b8', '#8b5cf6', '#06b6d4', '#f97316']
const OPP_PALETTE = ['#10b981', '#3b82f6', '#ef4444', '#f59e0b', '#8b5cf6']
const SOURCE_PALETTE = ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6', '#ef4444', '#06b6d4', '#f97316']

const doughnutOptions = {
  responsive: true, maintainAspectRatio: false, cutout: '68%',
  plugins: {
    legend: { position: 'bottom', labels: { boxWidth: 10, padding: 12, font: { size: 11 } } },
    tooltip: { callbacks: { label: (ctx) => ` ${ctx.label}: ${ctx.raw}` } },
  },
}

const leadBarOptions = {
  indexAxis: 'y', responsive: true, maintainAspectRatio: false,
  plugins: {
    legend: { display: false },
    tooltip: { callbacks: { label: (ctx) => ` ${ctx.raw} leads` } },
  },
  scales: {
    x: { grid: { color: '#f1f5f9' }, border: { display: false }, ticks: { font: { size: 11 } } },
    y: { grid: { display: false }, border: { display: false }, ticks: { font: { size: 11 } } },
  },
}

export default function HomePage() {
  const navigate = useNavigate()
  const { getStats } = useDashboard()
  const { getAllScores } = useLead()
  const { getAll: getAllTasks } = useTask()
  const { state: advancedCrmState, load: loadAdvancedCrm } = useAdvancedCrmData()
  const user = useAuthStore((s) => s.user)

  const [dateRange, setDateRange] = useState('month')
  const [activeChart, setActiveChart] = useState('status')
  const [completedTaskIds, setCompletedTaskIds] = useState(new Set())
  const [stats, setStats] = useState(null)
  const [hotLeadsData, setHotLeadsData] = useState([])
  const [tasksData, setTasksData] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const fetchAll = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const [s, hl, tasks] = await Promise.all([
        getStats(),
        getAllScores().catch(() => []),
        getAllTasks().catch(() => []),
      ])
      setStats(s)
      setHotLeadsData(hl ?? [])
      setTasksData(tasks ?? [])
      await loadAdvancedCrm()
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, []) // eslint-disable-line

  useEffect(() => { fetchAll() }, [fetchAll])

  const winRate = useMemo(() => {
    const won = Number(stats?.opportunityWon ?? 0)
    const lost = Number(stats?.opportunityLost ?? 0)
    const total = won + lost
    return total ? Math.round((won / total) * 100) : 0
  }, [stats])

  const conversionRate = useMemo(() => {
    const all = Number(stats?.leadAll ?? 0)
    const converted = Number(stats?.leadConverted ?? 0)
    return all ? Math.round((converted / all) * 100) : 0
  }, [stats])

  const pipelineValue = useMemo(() => {
    const total = (advancedCrmState.dealsList ?? []).reduce((sum, d) => sum + d.value, 0)
    if (total >= 10000000) return `₹${(total / 10000000).toFixed(1)}Cr`
    if (total >= 100000) return `₹${(total / 100000).toFixed(1)}L`
    return `₹${total.toLocaleString('en-IN')}`
  }, [advancedCrmState.dealsList])

  const topHotLeads = useMemo(() => (hotLeadsData ?? []).slice(0, 5), [hotLeadsData])

  const todaysTasks = useMemo(() =>
    (tasksData ?? []).slice(0, 6).map((t) => ({
      id: t.taskId,
      title: t.taskName,
      owner: t.taskAssign || (t.taskAssignedTo ? `User ${t.taskAssignedTo}` : 'Unassigned'),
      priority: (t.taskPriority?.toLowerCase() ?? 'medium'),
      completed: completedTaskIds.has(t.taskId),
      dueDate: t.taskDueDate || t.taskStartDate,
      pct: t.taskPercentageCompleted ?? 0,
    })),
    [tasksData, completedTaskIds]
  )

  function toggleTask(id) {
    setCompletedTaskIds((prev) => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  const leadStatusItems = useMemo(() => {
    if (!stats) return []
    return [
      { label: 'Qualified', value: stats.leadQualified ?? 0 },
      { label: 'Working', value: stats.leadWorking ?? 0 },
      { label: 'Contacted', value: stats.leadContacted ?? 0 },
      { label: 'Not Contacted', value: stats.leadNotContacted ?? 0 },
      { label: 'Converted', value: stats.leadConverted ?? 0 },
      { label: 'Quotation Sent', value: stats.leadQuotationSent ?? 0 },
      { label: 'Negotiation', value: stats.leadNegotiation ?? 0 },
    ].filter((i) => i.value > 0)
  }, [stats])

  const leadBarData = useMemo(() => ({
    labels: leadStatusItems.map((i) => i.label),
    datasets: [{
      data: leadStatusItems.map((i) => i.value),
      backgroundColor: leadStatusItems.map((_, idx) => STATUS_PALETTE[idx % STATUS_PALETTE.length]),
      borderRadius: 6, borderSkipped: false,
    }],
  }), [leadStatusItems])

  const oppStatusItems = useMemo(() =>
    (stats?.opportunityStatusWiseCount ?? []).map((m) => ({
      label: String(m.label ?? m.status ?? m.oppStatus ?? m.name ?? 'Unknown'),
      value: Number(m.count ?? m.total ?? 0),
    })).filter((i) => i.value > 0),
    [stats]
  )

  const oppDoughnutData = useMemo(() => ({
    labels: oppStatusItems.map((i) => i.label),
    datasets: [{
      data: oppStatusItems.map((i) => i.value),
      backgroundColor: oppStatusItems.map((_, idx) => OPP_PALETTE[idx % OPP_PALETTE.length]),
      borderWidth: 2, borderColor: '#ffffff', hoverOffset: 6,
    }],
  }), [oppStatusItems])

  const leadSourceItems = useMemo(() =>
    (stats?.leadSourceWiseCount ?? []).map((m) => ({
      label: String(m.label ?? m.source ?? m.leadSource ?? m.name ?? 'Unknown'),
      value: Number(m.count ?? m.total ?? 0),
    })).filter((i) => i.value > 0),
    [stats]
  )

  const leadSourceDoughnutData = useMemo(() => ({
    labels: leadSourceItems.map((i) => i.label),
    datasets: [{
      data: leadSourceItems.map((i) => i.value),
      backgroundColor: leadSourceItems.map((_, idx) => SOURCE_PALETTE[idx % SOURCE_PALETTE.length]),
      borderWidth: 2, borderColor: '#ffffff', hoverOffset: 6,
    }],
  }), [leadSourceItems])

  const funnelSteps = useMemo(() => {
    if (!stats) return []
    const total = stats.leadAll || 1
    return [
      { label: 'Total Leads', count: stats.leadAll ?? 0, pct: 100, color: '#3b82f6' },
      { label: 'Contacted', count: stats.leadContacted ?? 0, pct: Math.round(((stats.leadContacted ?? 0) / total) * 100), color: '#06b6d4' },
      { label: 'Qualified', count: stats.leadQualified ?? 0, pct: Math.round(((stats.leadQualified ?? 0) / total) * 100), color: '#10b981' },
      { label: 'Negotiation', count: stats.leadNegotiation ?? 0, pct: Math.round(((stats.leadNegotiation ?? 0) / total) * 100), color: '#f59e0b' },
      { label: 'Converted', count: stats.leadConverted ?? 0, pct: Math.round(((stats.leadConverted ?? 0) / total) * 100), color: '#8b5cf6' },
    ]
  }, [stats])

  const chartTabs = [
    { key: 'status', label: 'Lead Status' },
    { key: 'opp', label: 'Opp. Status' },
    { key: 'source', label: 'Lead Source' },
  ]

  return (
    <div className="animate-fade-in space-y-5">

      {/* Page Header */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-2">
          <div className="flex items-center gap-0.5 bg-white border border-gray-200 rounded-xl p-1 shadow-sm">
            {(['today', 'week', 'month', 'quarter']).map((range) => (
              <button
                key={range}
                onClick={() => setDateRange(range)}
                className={`px-3 py-1.5 rounded-lg text-xs font-semibold transition-all duration-150 ${
                  dateRange === range ? 'bg-blue-600 text-white shadow-sm' : 'text-gray-500 hover:bg-gray-100'
                }`}
              >{DATE_LABELS[range]}</button>
            ))}
          </div>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={fetchAll}
            className="w-9 h-9 flex items-center justify-center rounded-xl bg-white border border-gray-200 shadow-sm hover:bg-gray-50 transition-colors"
            title="Refresh dashboard"
          >
            <Icon name="mdi:refresh" className="w-4 h-4 text-gray-500" />
          </button>
        </div>
      </div>

      {/* Loading Skeleton */}
      {loading && (
        <div className="space-y-4">
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
            {[...Array(8)].map((_, i) => <div key={i} className="skeleton h-24 rounded-xl" />)}
          </div>
          <div className="grid grid-cols-1 xl:grid-cols-[3fr_2fr] gap-5">
            <div className="space-y-4">
              <div className="skeleton h-64 rounded-xl" />
              <div className="skeleton h-48 rounded-xl" />
              <div className="skeleton h-56 rounded-xl" />
            </div>
            <div className="space-y-4">
              <div className="skeleton h-56 rounded-xl" />
              <div className="skeleton h-44 rounded-xl" />
              <div className="skeleton h-40 rounded-xl" />
            </div>
          </div>
        </div>
      )}

      {/* Error State */}
      {!loading && error && (
        <div className="bg-white rounded-xl border border-red-100 shadow-sm p-12 text-center">
          <Icon name="mdi:alert-circle-outline" className="w-12 h-12 text-red-400 mx-auto mb-3" />
          <p className="text-red-600 font-semibold">Failed to load dashboard data.</p>
          <p className="text-gray-400 text-sm mt-1 mb-4">Check your backend connection and try again.</p>
          <button onClick={fetchAll} className="btn-primary btn-sm">Retry</button>
        </div>
      )}

      {!loading && !error && (
        <>
          {/* KPI Row 1 */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
            <Link to="/lead" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-blue-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Total Leads</span>
                <div className="w-8 h-8 rounded-lg bg-blue-50 group-hover:bg-blue-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:account-multiple-outline" className="w-4 h-4 text-blue-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{stats?.leadAll ?? 0}</p>
              <p className="text-xs text-blue-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:arrow-right" className="w-3 h-3" /> View all leads
              </p>
            </Link>

            <Link to="/opportunity" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-violet-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Open Opps</span>
                <div className="w-8 h-8 rounded-lg bg-violet-50 group-hover:bg-violet-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:handshake-outline" className="w-4 h-4 text-violet-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{stats?.opportunityOpen ?? 0}</p>
              <p className="text-xs text-violet-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:chart-timeline-variant" className="w-3 h-3" /> Pipeline: {pipelineValue}
              </p>
            </Link>

            <Link to="/task" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-amber-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Tasks Today</span>
                <div className="w-8 h-8 rounded-lg bg-amber-50 group-hover:bg-amber-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:clipboard-check-outline" className="w-4 h-4 text-amber-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{todaysTasks.length}</p>
              <p className="text-xs text-amber-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:check-circle-outline" className="w-3 h-3" /> {completedTaskIds.size} completed
              </p>
            </Link>

            <Link to="/opportunity" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-emerald-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Win Rate</span>
                <div className="w-8 h-8 rounded-lg bg-emerald-50 group-hover:bg-emerald-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:trophy-outline" className="w-4 h-4 text-emerald-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{winRate}%</p>
              <p className="text-xs text-emerald-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:trending-up" className="w-3 h-3" /> Won vs Lost
              </p>
            </Link>
          </div>

          {/* KPI Row 2 */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
            {[
              { to: '/opportunity', icon: 'mdi:trophy', bg: 'bg-emerald-50 group-hover:bg-emerald-100', iconColor: 'text-emerald-600', value: stats?.opportunityWon ?? 0, label: 'Opp. Won' },
              { to: '/lead', icon: 'mdi:swap-horizontal', bg: 'bg-purple-50 group-hover:bg-purple-100', iconColor: 'text-purple-600', value: stats?.leadConverted ?? 0, label: 'Converted' },
              { to: '/project', icon: 'mdi:folder-open-outline', bg: 'bg-blue-50 group-hover:bg-blue-100', iconColor: 'text-blue-600', value: stats?.projectCount ?? 0, label: 'Projects' },
              { to: '/lead', icon: 'mdi:rotate-right', bg: 'bg-cyan-50 group-hover:bg-cyan-100', iconColor: 'text-cyan-600', value: `${conversionRate}%`, label: 'Conversion' },
            ].map((kpi) => (
              <Link key={kpi.label} to={kpi.to} className="block bg-white rounded-xl border border-gray-100 shadow-sm p-4 hover:shadow-md transition-shadow group">
                <div className="flex items-center gap-3">
                  <div className={`w-10 h-10 rounded-xl ${kpi.bg} flex items-center justify-center shrink-0 transition-colors`}>
                    <Icon name={kpi.icon} className={`w-5 h-5 ${kpi.iconColor}`} />
                  </div>
                  <div>
                    <p className="text-xl font-bold text-gray-900">{kpi.value}</p>
                    <p className="text-xs text-gray-400 font-medium">{kpi.label}</p>
                  </div>
                </div>
              </Link>
            ))}
          </div>

          {/* Main 2-col Grid */}
          <div className="grid grid-cols-1 xl:grid-cols-[3fr_2fr] gap-5">

            {/* LEFT COLUMN */}
            <div className="space-y-5">

              {/* Chart Section */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-0">
                  <div className="flex items-center gap-1">
                    {chartTabs.map((tab) => (
                      <button
                        key={tab.key}
                        onClick={() => setActiveChart(tab.key)}
                        className={`px-3 py-2 text-xs font-semibold rounded-t-lg transition-all ${
                          activeChart === tab.key
                            ? 'bg-blue-600 text-white'
                            : 'text-gray-500 hover:bg-gray-100 hover:text-gray-700'
                        }`}
                      >{tab.label}</button>
                    ))}
                  </div>
                  <Link
                    to={activeChart === 'opp' ? '/opportunity' : '/lead'}
                    className="text-xs text-blue-600 hover:text-blue-700 font-semibold pb-1"
                  >View all →</Link>
                </div>
                <div className="px-5 pb-5 pt-4" style={{ height: 260 }}>
                  {activeChart === 'status' && leadStatusItems.length > 0 && <Bar data={leadBarData} options={leadBarOptions} />}
                  {activeChart === 'status' && !leadStatusItems.length && <p className="text-sm text-gray-400 text-center pt-16">No lead data available.</p>}
                  {activeChart === 'opp' && oppStatusItems.length > 0 && <Doughnut data={oppDoughnutData} options={doughnutOptions} />}
                  {activeChart === 'opp' && !oppStatusItems.length && <p className="text-sm text-gray-400 text-center pt-16">No opportunity data available.</p>}
                  {activeChart === 'source' && leadSourceItems.length > 0 && <Doughnut data={leadSourceDoughnutData} options={doughnutOptions} />}
                  {activeChart === 'source' && !leadSourceItems.length && <p className="text-sm text-gray-400 text-center pt-16">No lead source data available.</p>}
                </div>
              </div>

              {/* Sales Funnel */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Sales Funnel</p>
                    <p className="text-xs text-gray-400 mt-0.5">Lead-to-close conversion stages</p>
                  </div>
                  <Link to="/lead" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View leads →</Link>
                </div>
                <div className="p-5 space-y-2.5">
                  {funnelSteps.map((step, idx) => (
                    <div key={step.label} className="flex items-center gap-3">
                      <span className="text-xs text-gray-400 font-mono w-4 shrink-0 text-center">{idx + 1}</span>
                      <span className="text-xs text-gray-600 font-medium w-28 shrink-0 truncate">{step.label}</span>
                      <div className="flex-1 h-5 bg-gray-100 rounded-lg overflow-hidden">
                        <div
                          className="h-full rounded-lg flex items-center justify-end pr-2 transition-all duration-700"
                          style={{ width: step.pct > 0 ? `${Math.max(step.pct, 4)}%` : '0%', backgroundColor: step.color }}
                        >
                          {step.pct >= 8 && <span className="text-[10px] text-white font-bold">{step.pct}%</span>}
                        </div>
                      </div>
                      <span className="text-xs font-bold text-gray-700 w-10 text-right shrink-0">{step.count}</span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Activity Feed */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Recent Activity</p>
                    <p className="text-xs text-gray-400 mt-0.5">Latest CRM actions across your team</p>
                  </div>
                  <Link to="/activities" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="divide-y divide-gray-50 max-h-80 overflow-y-auto">
                  {(advancedCrmState.activityFeed ?? []).slice(0, 10).map((item) => (
                    <div key={item.id} className="flex items-start gap-3 px-5 py-3 hover:bg-gray-50/80 transition-colors cursor-default">
                      <div className={`w-8 h-8 rounded-full flex items-center justify-center shrink-0 mt-0.5 ${
                        item.type === 'Call' ? 'bg-indigo-100' : item.type === 'Email' ? 'bg-blue-100' : item.type === 'Meeting' ? 'bg-orange-100' : 'bg-purple-100'
                      }`}>
                        <Icon name={item.icon} className={`w-4 h-4 ${
                          item.type === 'Call' ? 'text-indigo-500' : item.type === 'Email' ? 'text-blue-500' : item.type === 'Meeting' ? 'text-orange-500' : 'text-purple-500'
                        }`} />
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium text-gray-800 leading-snug truncate">{item.title}</p>
                        <p className="text-xs text-gray-400 mt-0.5">{item.subject} · {item.owner}</p>
                        {item.note && <p className="text-xs text-gray-500 mt-0.5 line-clamp-1">{item.note}</p>}
                      </div>
                      <span className="text-[11px] text-gray-400 whitespace-nowrap shrink-0 mt-0.5">{item.time}</span>
                    </div>
                  ))}
                  {!(advancedCrmState.activityFeed ?? []).length && (
                    <div className="px-5 py-8 text-center text-sm text-gray-400">No recent activity.</div>
                  )}
                </div>
              </div>
            </div>

            {/* RIGHT COLUMN */}
            <div className="space-y-4">

              {/* Hot Leads */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div className="flex items-center gap-2">
                    <span className="text-lg leading-none">🔥</span>
                    <div>
                      <p className="text-sm font-semibold text-gray-800">Hot Leads</p>
                      <p className="text-xs text-gray-400">Ranked by AI score</p>
                    </div>
                  </div>
                  <Link to="/lead" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="divide-y divide-gray-50">
                  {topHotLeads.map((ls, idx) => (
                    <div key={ls.leadId} className="flex items-center gap-3 px-4 py-3 hover:bg-gray-50/80 transition-colors">
                      <span className="text-xs font-bold text-gray-300 w-4 shrink-0 text-center leading-none">
                        {idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : idx + 1}
                      </span>
                      <div className={`w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold shrink-0 ${
                        idx === 0 ? 'bg-amber-100 text-amber-700' : 'bg-indigo-100 text-indigo-700'
                      }`}>
                        {ls.leadName?.[0]?.toUpperCase() ?? '?'}
                      </div>
                      <Link to={`/lead/${ls.leadId}`} className="flex-1 min-w-0 group">
                        <p className="text-sm font-semibold text-gray-800 truncate group-hover:text-blue-600 transition-colors">{ls.leadName}</p>
                        <div className="flex items-center gap-1.5 mt-0.5">
                          <div className="flex-1 h-1 bg-gray-100 rounded-full overflow-hidden max-w-16">
                            <div className="h-full rounded-full bg-gradient-to-r from-blue-400 to-blue-600 transition-all" style={{ width: `${ls.score}%` }} />
                          </div>
                          <span className="text-[10px] text-gray-400">{ls.score}/100</span>
                        </div>
                      </Link>
                      <span className={`inline-flex items-center justify-center w-6 h-6 rounded-lg text-xs font-bold border shrink-0 ${GRADE_COLORS[ls.grade]}`}>
                        {ls.grade}
                      </span>
                      <div className="flex items-center gap-1 shrink-0">
                        <button
                          onClick={() => navigate(`/lead/${ls.leadId}`)}
                          className="w-7 h-7 rounded-lg bg-gray-100 hover:bg-indigo-100 hover:text-indigo-600 flex items-center justify-center transition-colors text-gray-500"
                          title="View lead & call"
                        >
                          <Icon name="mdi:phone" className="w-3.5 h-3.5" />
                        </button>
                        <button
                          onClick={() => navigate(`/lead/${ls.leadId}`)}
                          className="w-7 h-7 rounded-lg bg-gray-100 hover:bg-blue-100 hover:text-blue-600 flex items-center justify-center transition-colors text-gray-500"
                          title="View lead & email"
                        >
                          <Icon name="mdi:email-outline" className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </div>
                  ))}
                  {!topHotLeads.length && (
                    <div className="px-5 py-6 text-center text-sm text-gray-400">
                      <Icon name="mdi:star-off-outline" className="w-8 h-8 mx-auto mb-2 text-gray-300" />
                      No scored leads yet. Leads will appear once the AI scores them.
                    </div>
                  )}
                </div>
              </div>

              {/* Tasks */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Tasks</p>
                    <p className="text-xs text-gray-400">{completedTaskIds.size} / {todaysTasks.length} done</p>
                  </div>
                  <Link to="/task" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="h-1 bg-gray-100 mx-5 mt-3 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-emerald-500 rounded-full transition-all duration-500"
                    style={{ width: todaysTasks.length ? `${Math.round((completedTaskIds.size / todaysTasks.length) * 100)}%` : '0%' }}
                  />
                </div>
                <div className="divide-y divide-gray-50 mt-1">
                  {todaysTasks.map((task) => (
                    <div
                      key={task.id}
                      className="flex items-center gap-3 px-4 py-2.5 hover:bg-gray-50/80 transition-colors cursor-pointer"
                      onClick={() => toggleTask(task.id)}
                    >
                      <div className={`w-[18px] h-[18px] rounded border-2 flex items-center justify-center shrink-0 transition-all ${
                        task.completed ? 'bg-emerald-500 border-emerald-500' : 'border-gray-300 hover:border-blue-400'
                      }`}>
                        {task.completed && <Icon name="mdi:check" className="w-3 h-3 text-white" />}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className={`text-sm text-gray-700 truncate transition-all ${task.completed ? 'line-through text-gray-400' : ''}`}>{task.title}</p>
                        <p className="text-xs text-gray-400 mt-0.5">{task.owner}</p>
                      </div>
                      <span className={`w-2 h-2 rounded-full shrink-0 ${PRIORITY_COLORS[task.priority] ?? 'bg-amber-400'}`} />
                    </div>
                  ))}
                  {!todaysTasks.length && (
                    <div className="px-5 py-5 text-center text-sm text-gray-400">No tasks found.</div>
                  )}
                </div>
              </div>

              {/* Team Leaderboard */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <p className="text-sm font-semibold text-gray-800">Team Leaderboard</p>
                  <Link to="/team-member" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="divide-y divide-gray-50">
                  {(advancedCrmState.repRanking ?? []).slice(0, 5).map((rep, idx) => (
                    <div key={rep.name} className="flex items-center gap-3 px-4 py-3">
                      <span className="text-base w-5 shrink-0 text-center select-none">
                        {['🥇', '🥈', '🥉', '4', '5'][idx]}
                      </span>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center justify-between mb-1">
                          <p className="text-sm font-semibold text-gray-800 truncate">{rep.name}</p>
                          <span className={`text-xs font-bold ml-2 shrink-0 ${rep.quota >= 100 ? 'text-emerald-600' : rep.quota >= 80 ? 'text-blue-600' : 'text-amber-600'}`}>
                            {rep.quota}%
                          </span>
                        </div>
                        <div className="h-1.5 bg-gray-100 rounded-full overflow-hidden">
                          <div
                            className="h-full rounded-full transition-all duration-700"
                            style={{
                              width: `${Math.min(rep.quota, 100)}%`,
                              backgroundColor: rep.quota >= 100 ? '#10b981' : rep.quota >= 80 ? '#3b82f6' : '#f59e0b',
                            }}
                          />
                        </div>
                        <p className="text-xs text-gray-400 mt-0.5">Win rate {rep.winRate}%</p>
                      </div>
                    </div>
                  ))}
                  {!(advancedCrmState.repRanking ?? []).length && (
                    <div className="px-5 py-6 text-center text-sm text-gray-400">No team data available.</div>
                  )}
                </div>
              </div>

              {/* Quick Actions */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="px-5 pt-4 pb-3 border-b border-gray-50">
                  <p className="text-sm font-semibold text-gray-800">Quick Actions</p>
                </div>
                <div className="p-4 grid grid-cols-2 gap-2">
                  {[
                    { to: '/lead', icon: 'mdi:account-plus-outline', label: 'New Lead', cls: 'bg-blue-50 hover:bg-blue-100 text-blue-700' },
                    { to: '/task', icon: 'mdi:clipboard-plus-outline', label: 'New Task', cls: 'bg-violet-50 hover:bg-violet-100 text-violet-700' },
                    { to: '/opportunity', icon: 'mdi:briefcase-plus-outline', label: 'New Opp.', cls: 'bg-emerald-50 hover:bg-emerald-100 text-emerald-700' },
                    { to: '/contact', icon: 'mdi:card-account-details-outline', label: 'New Contact', cls: 'bg-amber-50 hover:bg-amber-100 text-amber-700' },
                    { to: '/activities', icon: 'mdi:lightning-bolt-outline', label: 'Log Activity', cls: 'bg-rose-50 hover:bg-rose-100 text-rose-700' },
                    { to: '/calendar', icon: 'mdi:calendar-plus', label: 'Add Event', cls: 'bg-cyan-50 hover:bg-cyan-100 text-cyan-700' },
                  ].map((a) => (
                    <Link
                      key={a.label}
                      to={a.to}
                      className={`flex flex-col items-center gap-1.5 px-3 py-3 rounded-xl text-xs font-semibold transition-colors text-center ${a.cls}`}
                    >
                      <Icon name={a.icon} className="w-5 h-5" />
                      {a.label}
                    </Link>
                  ))}
                </div>
              </div>

            </div>
          </div>
        </>
      )}
    </div>
  )
}
