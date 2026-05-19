import { useState, useEffect, useMemo, useCallback } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Bar, Doughnut } from 'react-chartjs-2'
import {
  Chart as ChartJS, CategoryScale, LinearScale, BarElement,
  ArcElement, Tooltip, Legend,
} from 'chart.js'
import { useLead } from '../hooks/useLead'
import { useOpportunity } from '../hooks/useOpportunity'
import { useProject } from '../hooks/useProject'
import { useTask } from '../hooks/useTask'
import { useCalendar } from '../hooks/useCalendar'
import { useAdvancedCrmData } from '../hooks/useAdvancedCrmData'
import Icon from '../components/Icon'

ChartJS.register(CategoryScale, LinearScale, BarElement, ArcElement, Tooltip, Legend)

const GRADE_COLORS = {
  A: 'bg-emerald-100 text-emerald-700 border-emerald-200',
  B: 'bg-blue-100 text-blue-700 border-blue-200',
  C: 'bg-amber-100 text-amber-700 border-amber-200',
  D: 'bg-red-100 text-red-700 border-red-200',
}
const PRIORITY_COLORS = { high: 'bg-red-500', medium: 'bg-amber-400', low: 'bg-teal-400' }
const DATE_LABELS = { today: 'Today', week: 'This Week', month: 'This Month', quarter: 'This Quarter', all: 'All Data' }
const DATE_RANGES = ['today', 'week', 'month', 'quarter', 'all']
const STATUS_PALETTE = ['#10b981', '#3b82f6', '#f59e0b', '#94a3b8', '#8b5cf6', '#06b6d4', '#f97316']
const OPP_PALETTE = ['#10b981', '#3b82f6', '#ef4444', '#f59e0b', '#8b5cf6']
const SOURCE_PALETTE = ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6', '#ef4444', '#06b6d4', '#f97316']

function getRangeBounds(range) {
  if (range === 'all') return { all: true }

  const now = new Date()
  const start = new Date(now)
  start.setHours(0, 0, 0, 0)

  if (range === 'week') {
    const day = (start.getDay() + 6) % 7
    start.setDate(start.getDate() - day)
  } else if (range === 'month') {
    start.setDate(1)
  } else if (range === 'quarter') {
    start.setMonth(Math.floor(start.getMonth() / 3) * 3, 1)
  }

  const end = new Date(now)
  end.setHours(23, 59, 59, 999)
  return { start, end }
}

function parseDate(value) {
  if (!value) return null
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? null : date
}

function isInRange(value, bounds) {
  if (bounds?.all) return true
  const date = parseDate(value)
  return !!date && date >= bounds.start && date <= bounds.end
}

function normalizeReminder(reminder) {
  const id = reminder.leadReminderId ?? reminder.id ?? `${reminder.reminderText || reminder.title}-${reminder.reminderDate || reminder.date || reminder.time}`
  const leadId = reminder.leadIdFk ?? reminder.leadId

  return {
    id,
    title: reminder.reminderText || reminder.title || 'Reminder',
    date: reminder.reminderDate || reminder.date || reminder.time,
    owner: reminder.owner || (leadId ? `Lead #${leadId}` : 'Lead reminder'),
    note: reminder.note || reminder.description || '',
  }
}

function mapCalendarReminders(calendarData) {
  const reminders = Array.isArray(calendarData?.reminders) ? calendarData.reminders : []
  const reminderEvents = Array.isArray(calendarData?.events)
    ? calendarData.events.filter((event) => String(event.type || '').toLowerCase() !== 'task')
    : []
  const seen = new Set()

  return [...reminders, ...reminderEvents]
    .map(normalizeReminder)
    .filter((reminder) => {
      const key = String(reminder.id)
      if (seen.has(key)) return false
      seen.add(key)
      return true
    })
}

function groupByCount(items, getKey) {
  const map = new Map()
  items.forEach((item) => {
    const key = String(getKey(item) || 'Unknown')
    map.set(key, (map.get(key) || 0) + 1)
  })
  return Array.from(map.entries()).map(([label, count]) => ({ label, count }))
}

function countByStatus(items, matcher) {
  return items.filter((item) => matcher(String(item || '').toLowerCase())).length
}

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
  const { getAll: getAllLeads, getAllScores } = useLead()
  const { getAll: getAllOpportunities } = useOpportunity()
  const { getAll: getAllProjects } = useProject()
  const { getAll: getAllTasks } = useTask()
  const { getAllEvents } = useCalendar()
  const { state: advancedCrmState, load: loadAdvancedCrm } = useAdvancedCrmData()

  const [dateRange, setDateRange] = useState('today')
  const [activeChart, setActiveChart] = useState('status')
  const [selectedFunnelKey, setSelectedFunnelKey] = useState('total')
  const [completedTaskIds, setCompletedTaskIds] = useState(new Set())
  const [completedReminderIds, setCompletedReminderIds] = useState(new Set())
  const [leadsData, setLeadsData] = useState([])
  const [opportunitiesData, setOpportunitiesData] = useState([])
  const [projectsData, setProjectsData] = useState([])
  const [hotLeadsData, setHotLeadsData] = useState([])
  const [tasksData, setTasksData] = useState([])
  const [remindersData, setRemindersData] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const fetchAll = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const [hl, tasks, calendarData] = await Promise.all([
        getAllScores().catch(() => []),
        getAllTasks().catch(() => []),
        getAllEvents().catch(() => ({ events: [], reminders: [] })),
      ])
      const [leads, opportunities, projects] = await Promise.all([
        getAllLeads().catch(() => []),
        getAllOpportunities().catch(() => []),
        getAllProjects().catch(() => []),
      ])
      setLeadsData(leads ?? [])
      setOpportunitiesData(opportunities ?? [])
      setProjectsData(projects ?? [])
      setHotLeadsData(hl ?? [])
      setTasksData(tasks ?? [])
      setRemindersData(mapCalendarReminders(calendarData))
      await loadAdvancedCrm()
    } catch (e) {
      setError(e)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => { fetchAll() }, [fetchAll])

  const rangeBounds = useMemo(() => getRangeBounds(dateRange), [dateRange])

  const filteredLeads = useMemo(() =>
    (leadsData ?? []).filter((lead) =>
      isInRange(lead.inquiryDate || lead.leadCreatedDate, rangeBounds)
    ),
    [leadsData, rangeBounds]
  )

  const filteredOpportunities = useMemo(() =>
    (opportunitiesData ?? []).filter((opp) =>
      isInRange(opp.oppActualCloseDate || opp.oppForcastCloseDate, rangeBounds)
    ),
    [opportunitiesData, rangeBounds]
  )

  const filteredProjects = useMemo(() =>
    (projectsData ?? []).filter((project) =>
      isInRange(project.projectStartDate || project.projectCompletedDate || project.forecastCompletedDate, rangeBounds)
    ),
    [projectsData, rangeBounds]
  )

  const filteredTasks = useMemo(() =>
    (tasksData ?? []).filter((task) =>
      isInRange(task.taskDueDate || task.taskStartDate || task.taskCompletedDate, rangeBounds)
    ),
    [tasksData, rangeBounds]
  )

  const filteredReminders = useMemo(() =>
    (remindersData ?? []).filter((reminder) => isInRange(reminder.date, rangeBounds)),
    [remindersData, rangeBounds]
  )

  const rangeStats = useMemo(() => {
    const leadStatuses = filteredLeads.map((lead) => lead.leadStatus)
    const oppStatuses = filteredOpportunities.map((opp) => opp.oppStatus)
    return {
      leadAll: filteredLeads.length,
      leadNotContacted: countByStatus(leadStatuses, (s) => s.includes('notcontacted') || s.includes('not contacted')),
      leadContacted: countByStatus(leadStatuses, (s) => s === 'contacted' || (s.includes('contacted') && !s.includes('not'))),
      leadQualified: countByStatus(leadStatuses, (s) => s.includes('qualified')),
      leadWorking: countByStatus(leadStatuses, (s) => s.includes('working')),
      leadQuotationSent: countByStatus(leadStatuses, (s) => s.includes('quotation')),
      leadNegotiation: countByStatus(leadStatuses, (s) => s.includes('negotiation')),
      leadConverted: countByStatus(leadStatuses, (s) => s.includes('converted')),
      opportunityWon: countByStatus(oppStatuses, (s) => s.includes('won')),
      opportunityLost: countByStatus(oppStatuses, (s) => s.includes('lost')),
      opportunityOpen: countByStatus(oppStatuses, (s) => s.includes('open')),
      projectCount: filteredProjects.length,
      leadSourceWiseCount: groupByCount(filteredLeads, (lead) => lead.leadSource),
      opportunityStatusWiseCount: groupByCount(filteredOpportunities, (opp) => opp.oppStatus),
    }
  }, [filteredLeads, filteredOpportunities, filteredProjects])

  const winRate = useMemo(() => {
    const won = Number(rangeStats.opportunityWon ?? 0)
    const lost = Number(rangeStats.opportunityLost ?? 0)
    const total = won + lost
    return total ? Math.round((won / total) * 100) : 0
  }, [rangeStats])

  const conversionRate = useMemo(() => {
    const all = Number(rangeStats.leadAll ?? 0)
    const converted = Number(rangeStats.leadConverted ?? 0)
    return all ? Math.round((converted / all) * 100) : 0
  }, [rangeStats])

  const pipelineValue = useMemo(() => {
    const total = filteredOpportunities.reduce((sum, opp) => sum + Number(opp.oppAmount || 0), 0)
    if (total >= 10000000) return `₹${(total / 10000000).toFixed(1)}Cr`
    if (total >= 100000) return `₹${(total / 100000).toFixed(1)}L`
    return `₹${total.toLocaleString('en-IN')}`
  }, [filteredOpportunities])

  const topHotLeads = useMemo(() => {
    const leadIds = new Set(filteredLeads.map((lead) => Number(lead.leadId)))
    return (hotLeadsData ?? [])
      .filter((score) => leadIds.has(Number(score.leadId)))
      .slice(0, 5)
  }, [hotLeadsData, filteredLeads])

  const todaysTasks = useMemo(() =>
    filteredTasks.slice(0, 6).map((t) => ({
      id: t.taskId,
      title: t.taskName,
      owner: t.taskAssign || (t.taskAssignedTo ? `User ${t.taskAssignedTo}` : 'Unassigned'),
      priority: (t.taskPriority?.toLowerCase() ?? 'medium'),
      completed: completedTaskIds.has(t.taskId),
      dueDate: t.taskDueDate || t.taskStartDate,
      pct: t.taskPercentageCompleted ?? 0,
    })),
    [filteredTasks, completedTaskIds]
  )

  const completedVisibleTasks = useMemo(
    () => todaysTasks.filter((task) => task.completed).length,
    [todaysTasks]
  )

  const visibleReminders = useMemo(() =>
    filteredReminders.slice(0, 6).map((reminder) => ({
      ...reminder,
      completed: completedReminderIds.has(reminder.id),
    })),
    [filteredReminders, completedReminderIds]
  )

  const completedVisibleReminders = useMemo(
    () => visibleReminders.filter((reminder) => reminder.completed).length,
    [visibleReminders]
  )

  const filteredActivityFeed = useMemo(() =>
    (advancedCrmState.activityFeed ?? []).filter((item) => isInRange(item.time, rangeBounds)),
    [advancedCrmState.activityFeed, rangeBounds]
  )

  function toggleTask(id) {
    setCompletedTaskIds((prev) => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  function toggleReminder(id) {
    setCompletedReminderIds((prev) => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  const leadStatusItems = useMemo(() => {
    return [
      { label: 'Qualified', value: rangeStats.leadQualified ?? 0 },
      { label: 'Working', value: rangeStats.leadWorking ?? 0 },
      { label: 'Contacted', value: rangeStats.leadContacted ?? 0 },
      { label: 'Not Contacted', value: rangeStats.leadNotContacted ?? 0 },
      { label: 'Converted', value: rangeStats.leadConverted ?? 0 },
      { label: 'Quotation Sent', value: rangeStats.leadQuotationSent ?? 0 },
      { label: 'Negotiation', value: rangeStats.leadNegotiation ?? 0 },
    ].filter((i) => i.value > 0)
  }, [rangeStats])

  const leadBarData = useMemo(() => ({
    labels: leadStatusItems.map((i) => i.label),
    datasets: [{
      data: leadStatusItems.map((i) => i.value),
      backgroundColor: leadStatusItems.map((_, idx) => STATUS_PALETTE[idx % STATUS_PALETTE.length]),
      borderRadius: 6, borderSkipped: false,
    }],
  }), [leadStatusItems])

  const oppStatusItems = useMemo(() =>
    (rangeStats.opportunityStatusWiseCount ?? []).map((m) => ({
      label: String(m.label ?? m.status ?? m.oppStatus ?? m.name ?? 'Unknown'),
      value: Number(m.count ?? m.total ?? 0),
    })).filter((i) => i.value > 0),
    [rangeStats]
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
    (rangeStats.leadSourceWiseCount ?? []).map((m) => ({
      label: String(m.label ?? m.source ?? m.leadSource ?? m.name ?? 'Unknown'),
      value: Number(m.count ?? m.total ?? 0),
    })).filter((i) => i.value > 0),
    [rangeStats]
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
    const rawSteps = [
      { key: 'total', label: 'Total Leads', count: rangeStats.leadAll ?? 0, color: '#2563eb', icon: 'mdi:account-multiple-outline', route: '/lead' },
      { key: 'contacted', label: 'Contacted', count: rangeStats.leadContacted ?? 0, color: '#0891b2', icon: 'mdi:phone-check-outline', route: '/lead' },
      { key: 'qualified', label: 'Qualified', count: rangeStats.leadQualified ?? 0, color: '#059669', icon: 'mdi:account-check-outline', route: '/lead' },
      { key: 'proposal', label: 'Proposal', count: rangeStats.leadQuotationSent ?? 0, color: '#d97706', icon: 'mdi:file-document-edit-outline', route: '/lead' },
      { key: 'negotiation', label: 'Negotiation', count: rangeStats.leadNegotiation ?? 0, color: '#7c3aed', icon: 'mdi:handshake-outline', route: '/lead' },
      { key: 'won', label: 'Won', count: rangeStats.opportunityWon ?? 0, color: '#16a34a', icon: 'mdi:trophy-outline', route: '/opportunity' },
    ]
    const total = Math.max(Number(rawSteps[0].count) || 0, 1)
    const maxCount = Math.max(...rawSteps.map((step) => Number(step.count) || 0), 1)

    return rawSteps.map((step, idx) => {
      const previousCount = idx === 0 ? total : Math.max(Number(rawSteps[idx - 1].count) || 0, 1)
      const count = Number(step.count) || 0
      return {
        ...step,
        count,
        pct: Math.round((count / total) * 100),
        previousPct: idx === 0 ? 100 : Math.round((count / previousCount) * 100),
        dropOff: idx === 0 ? 0 : Math.max((Number(rawSteps[idx - 1].count) || 0) - count, 0),
        widthPct: Math.max((count / maxCount) * 100, count > 0 ? 20 : 10),
      }
    })
  }, [rangeStats])

  const selectedFunnelStep = useMemo(
    () => funnelSteps.find((step) => step.key === selectedFunnelKey) || funnelSteps[0],
    [funnelSteps, selectedFunnelKey]
  )

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
            {DATE_RANGES.map((range) => (
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
          <div className="grid grid-cols-2 sm:grid-cols-5 gap-4">
            {[...Array(10)].map((_, i) => <div key={i} className="skeleton h-24 rounded-xl" />)}
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
          <div className="grid grid-cols-2 sm:grid-cols-5 gap-4">
            <Link to="/lead" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-blue-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Total Leads</span>
                <div className="w-8 h-8 rounded-lg bg-blue-50 group-hover:bg-blue-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:account-multiple-outline" className="w-4 h-4 text-blue-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{rangeStats.leadAll ?? 0}</p>
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
              <p className="text-2xl font-bold text-gray-900">{rangeStats.opportunityOpen ?? 0}</p>
              <p className="text-xs text-violet-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:chart-timeline-variant" className="w-3 h-3" /> Pipeline: {pipelineValue}
              </p>
            </Link>

            <Link to="/task" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-amber-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Tasks {DATE_LABELS[dateRange]}</span>
                <div className="w-8 h-8 rounded-lg bg-amber-50 group-hover:bg-amber-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:clipboard-check-outline" className="w-4 h-4 text-amber-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{todaysTasks.length}</p>
              <p className="text-xs text-amber-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:check-circle-outline" className="w-3 h-3" /> {completedVisibleTasks} completed
              </p>
            </Link>

            <Link to="/calendar" className="block bg-white rounded-xl border border-gray-100 shadow-sm p-5 border-l-4 border-l-rose-500 hover:shadow-md transition-shadow group">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold uppercase tracking-wide text-gray-400">Reminders {DATE_LABELS[dateRange]}</span>
                <div className="w-8 h-8 rounded-lg bg-rose-50 group-hover:bg-rose-100 flex items-center justify-center transition-colors">
                  <Icon name="mdi:bell-outline" className="w-4 h-4 text-rose-500" />
                </div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{visibleReminders.length}</p>
              <p className="text-xs text-rose-500 mt-1.5 flex items-center gap-1 font-medium">
                <Icon name="mdi:calendar-clock-outline" className="w-3 h-3" /> {completedVisibleReminders} completed
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
              { to: '/opportunity', icon: 'mdi:trophy', bg: 'bg-emerald-50 group-hover:bg-emerald-100', iconColor: 'text-emerald-600', value: rangeStats.opportunityWon ?? 0, label: 'Opp. Won' },
              { to: '/lead', icon: 'mdi:swap-horizontal', bg: 'bg-purple-50 group-hover:bg-purple-100', iconColor: 'text-purple-600', value: rangeStats.leadConverted ?? 0, label: 'Converted' },
              { to: '/project', icon: 'mdi:folder-open-outline', bg: 'bg-blue-50 group-hover:bg-blue-100', iconColor: 'text-blue-600', value: rangeStats.projectCount ?? 0, label: 'Projects' },
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
                    <p className="text-xs text-gray-400 mt-0.5">Click a stage to inspect conversion and drop-off</p>
                  </div>
                  <Link to={selectedFunnelStep?.route || '/lead'} className="text-xs text-blue-600 hover:text-blue-700 font-semibold">
                    Open stage →
                  </Link>
                </div>
                <div className="grid gap-5 p-5 lg:grid-cols-[minmax(0,1fr)_220px]">
                  <div className="min-w-0">
                    <svg
                      viewBox="0 0 640 420"
                      role="img"
                      aria-label="Sales funnel conversion chart"
                      className="h-[420px] w-full"
                    >
                      {funnelSteps.map((step, idx) => {
                        const sectionHeight = 58
                        const topY = 10 + idx * sectionHeight
                        const bottomY = topY + sectionHeight

                        // Funnel sizing
                        const maxWidth = 520
                        const minWidth = 90

                        const totalSteps = funnelSteps.length

                        // current width
                        const topWidth =
                          maxWidth -
                          ((maxWidth - minWidth) / totalSteps) * idx

                        // next width
                        const bottomWidth =
                          maxWidth -
                          ((maxWidth - minWidth) / totalSteps) * (idx + 1)

                        const centerX = 320

                        const topLeft = centerX - topWidth / 2
                        const topRight = centerX + topWidth / 2

                        const bottomLeft = centerX - bottomWidth / 2
                        const bottomRight = centerX + bottomWidth / 2

                        const isSelected = selectedFunnelStep?.key === step.key

                        return (
                          <g
                            key={step.key}
                            className="cursor-pointer"
                            onClick={() => setSelectedFunnelKey(step.key)}
                          >
                            <polygon
                              points={`
                                ${topLeft},${topY}
                                ${topRight},${topY}
                                ${bottomRight},${bottomY}
                                ${bottomLeft},${bottomY}
                              `}
                              fill={step.color}
                              opacity={isSelected ? 1 : 0.88}
                              stroke={isSelected ? '#111827' : '#ffffff'}
                              strokeWidth={isSelected ? 3 : 2}
                              className="transition-all duration-200 hover:opacity-100"
                            />

                            {/* Label */}
                            <text
                              x={centerX}
                              y={topY + 24}
                              textAnchor="middle"
                              className="fill-white text-[15px] font-bold"
                            >
                              {step.label}
                            </text>

                            {/* Count */}
                            <text
                              x={centerX}
                              y={topY + 42}
                              textAnchor="middle"
                              className="fill-white text-[12px] font-semibold opacity-90"
                            >
                              {step.count.toLocaleString('en-IN')} | {step.pct}%
                            </text>
                          </g>
                        )
                      })}
                    </svg>
                    <div className="grid grid-cols-2 gap-2 sm:grid-cols-3">
                      {funnelSteps.map((step) => (
                        <button
                          key={step.key}
                          onClick={() => setSelectedFunnelKey(step.key)}
                          className={`flex items-center gap-2 rounded-lg border px-3 py-2 text-left transition-colors ${
                            selectedFunnelStep?.key === step.key
                              ? 'border-gray-900 bg-gray-900 text-white'
                              : 'border-gray-100 bg-gray-50 text-gray-600 hover:bg-gray-100'
                          }`}
                        >
                          <Icon name={step.icon} className="h-4 w-4 shrink-0" />
                          <span className="min-w-0">
                            <span className="block truncate text-xs font-semibold">{step.label}</span>
                            <span className={`block text-[11px] ${selectedFunnelStep?.key === step.key ? 'text-gray-300' : 'text-gray-400'}`}>
                              {step.count.toLocaleString('en-IN')} records
                            </span>
                          </span>
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="rounded-xl border border-gray-100 bg-gray-50 p-4">
                    <div className="flex items-center gap-2">
                      <span className="flex h-9 w-9 items-center justify-center rounded-lg text-white" style={{ backgroundColor: selectedFunnelStep?.color }}>
                        <Icon name={selectedFunnelStep?.icon || 'mdi:chart-funnel'} className="h-5 w-5" />
                      </span>
                      <div className="min-w-0">
                        <p className="truncate text-sm font-semibold text-gray-800">{selectedFunnelStep?.label}</p>
                        <p className="text-xs text-gray-400">{DATE_LABELS[dateRange]}</p>
                      </div>
                    </div>
                    <p className="mt-4 text-3xl font-bold text-gray-900">{(selectedFunnelStep?.count ?? 0).toLocaleString('en-IN')}</p>
                    <p className="text-xs font-medium text-gray-500">records in this stage</p>
                    <div className="mt-4 space-y-3">
                      <div>
                        <div className="mb-1 flex justify-between text-xs font-semibold text-gray-500">
                          <span>Of total leads</span>
                          <span>{selectedFunnelStep?.pct ?? 0}%</span>
                        </div>
                        <div className="h-2 rounded-full bg-white">
                          <div className="h-full rounded-full" style={{ width: `${Math.min(selectedFunnelStep?.pct ?? 0, 100)}%`, backgroundColor: selectedFunnelStep?.color }} />
                        </div>
                      </div>
                      <div>
                        <div className="mb-1 flex justify-between text-xs font-semibold text-gray-500">
                          <span>From previous</span>
                          <span>{selectedFunnelStep?.previousPct ?? 0}%</span>
                        </div>
                        <div className="h-2 rounded-full bg-white">
                          <div className="h-full rounded-full" style={{ width: `${Math.min(selectedFunnelStep?.previousPct ?? 0, 100)}%`, backgroundColor: selectedFunnelStep?.color }} />
                        </div>
                      </div>
                    </div>
                    <div className="mt-4 rounded-lg bg-white p-3 text-xs text-gray-500">
                      <span className="font-semibold text-gray-700">Drop-off:</span>{' '}
                      {selectedFunnelStep?.dropOff ? `${selectedFunnelStep.dropOff.toLocaleString('en-IN')} fewer than previous stage` : 'Top of funnel stage'}
                    </div>
                    <button
                      onClick={() => navigate(selectedFunnelStep?.route || '/lead')}
                      className="mt-4 flex w-full items-center justify-center gap-2 rounded-lg bg-blue-600 px-3 py-2 text-xs font-semibold text-white transition-colors hover:bg-blue-700"
                    >
                      <Icon name="mdi:open-in-new" className="h-4 w-4" />
                      View records
                    </button>
                  </div>
                </div>
              </div>

              {/* Activity Feed */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Recent Activity</p>
                    <p className="text-xs text-gray-400 mt-0.5">{DATE_LABELS[dateRange]} CRM actions across your team</p>
                  </div>
                  <Link to="/activities" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="divide-y divide-gray-50 max-h-80 overflow-y-auto">
                  {filteredActivityFeed.slice(0, 10).map((item) => (
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
                  {!filteredActivityFeed.length && (
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
                    <p className="text-sm font-semibold text-gray-800">Tasks - {DATE_LABELS[dateRange]}</p>
                    <p className="text-xs text-gray-400">{completedVisibleTasks} / {todaysTasks.length} done</p>
                  </div>
                  <Link to="/task" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="h-1 bg-gray-100 mx-5 mt-3 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-emerald-500 rounded-full transition-all duration-500"
                    style={{ width: todaysTasks.length ? `${Math.round((completedVisibleTasks / todaysTasks.length) * 100)}%` : '0%' }}
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

              {/* Reminders */}
              <div className="bg-white rounded-xl border border-gray-100 shadow-sm">
                <div className="flex items-center justify-between px-5 pt-4 pb-3 border-b border-gray-50">
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Reminders - {DATE_LABELS[dateRange]}</p>
                    <p className="text-xs text-gray-400">{completedVisibleReminders} / {visibleReminders.length} done</p>
                  </div>
                  <Link to="/calendar" className="text-xs text-blue-600 hover:text-blue-700 font-semibold">View all →</Link>
                </div>
                <div className="h-1 bg-gray-100 mx-5 mt-3 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-rose-500 rounded-full transition-all duration-500"
                    style={{ width: visibleReminders.length ? `${Math.round((completedVisibleReminders / visibleReminders.length) * 100)}%` : '0%' }}
                  />
                </div>
                <div className="divide-y divide-gray-50 mt-1">
                  {visibleReminders.map((reminder) => (
                    <div
                      key={reminder.id}
                      className="flex items-center gap-3 px-4 py-2.5 hover:bg-gray-50/80 transition-colors cursor-pointer"
                      onClick={() => toggleReminder(reminder.id)}
                    >
                      <div className={`w-[18px] h-[18px] rounded-full border-2 flex items-center justify-center shrink-0 transition-all ${
                        reminder.completed ? 'bg-rose-500 border-rose-500' : 'border-gray-300 hover:border-rose-400'
                      }`}>
                        {reminder.completed && <Icon name="mdi:check" className="w-3 h-3 text-white" />}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className={`text-sm text-gray-700 truncate transition-all ${reminder.completed ? 'line-through text-gray-400' : ''}`}>{reminder.title}</p>
                        <p className="text-xs text-gray-400 mt-0.5 truncate">{reminder.date || reminder.owner}</p>
                      </div>
                      <Icon name="mdi:bell-outline" className="w-4 h-4 text-rose-400 shrink-0" />
                    </div>
                  ))}
                  {!visibleReminders.length && (
                    <div className="px-5 py-5 text-center text-sm text-gray-400">No reminders found.</div>
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