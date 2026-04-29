import ModuleWorkspace from '../components/module/ModuleWorkspace'
import { useAdvancedCrmData } from '../hooks/useAdvancedCrmData'
import { staticWorkspaceConfig } from './moduleConfigs'

const moduleMap = {
  pipeline: {
    title: 'Pipeline',
    singular: 'Pipeline Stage',
    subtitle: 'Stage-by-stage deal flow with forecast value and active opportunity counts.',
    icon: 'mdi:chart-timeline-variant',
    source: 'pipelineStages',
    mapRows: (rows) => rows.map((row, index) => ({
      id: index + 1,
      name: row.name,
      status: row.deals.length ? 'Active' : 'Open',
      count: row.deals.length,
      value: row.deals.reduce((total, deal) => total + Number(deal.value || 0), 0),
      linked: `${row.deals.length} opportunities`,
    })),
    primaryKey: 'name',
    secondaryKey: 'linked',
    statusKey: 'status',
    statusOptions: ['Active', 'Open'],
    columns: [
      { label: 'Stage', key: 'name', strong: true, width: 'w-[28%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[16%]' },
      { label: 'Deals', key: 'count', align: 'right', width: 'w-[12%]' },
      { label: 'Forecast Value', key: 'value', type: 'currency', align: 'right', width: 'w-[20%]' },
      { label: 'Linked', key: 'linked', width: 'w-[24%]' },
    ],
  },
  deals: {
    title: 'Deals',
    singular: 'Deal',
    subtitle: 'Revenue workspace derived from opportunities, with owner, stage, probability, and close date.',
    icon: 'mdi:briefcase-variant-outline',
    source: 'dealsList',
    mapRows: (rows) => rows,
    primaryKey: 'title',
    secondaryKey: 'company',
    statusKey: 'stage',
    columns: [
      { label: 'Deal', key: 'title', strong: true, width: 'w-[23%]' },
      { label: 'Company', key: 'company', width: 'w-[19%]' },
      { label: 'Stage', key: 'stage', status: true, width: 'w-[15%]' },
      { label: 'Owner', key: 'owner', width: 'w-[15%]' },
      { label: 'Value', key: 'value', type: 'currency', align: 'right', width: 'w-[15%]' },
      { label: 'Probability', key: (item) => `${item.probability}%`, align: 'right', width: 'w-[13%]' },
    ],
  },
  activities: {
    title: 'Activities',
    singular: 'Activity',
    subtitle: 'Unified activity feed from backend tasks and lead follow-up records.',
    icon: 'mdi:timeline-clock-outline',
    source: 'activityFeed',
    mapRows: (rows) => rows,
    primaryKey: 'title',
    secondaryKey: 'subject',
    statusKey: 'type',
    statusOptions: ['Call', 'Email', 'Meeting', 'Note'],
    columns: [
      { label: 'Activity', key: 'title', strong: true, width: 'w-[24%]' },
      { label: 'Type', key: 'type', status: true, width: 'w-[12%]' },
      { label: 'Subject', key: 'subject', width: 'w-[22%]' },
      { label: 'Owner', key: 'owner', width: 'w-[14%]' },
      { label: 'Time', key: 'time', width: 'w-[12%]' },
      { label: 'Note', key: 'note', width: 'w-[16%]' },
    ],
  },
  emails: {
    title: 'Emails',
    singular: 'Email Thread',
    subtitle: 'Threaded inbox with lead, account, and deal context side by side.',
    icon: 'mdi:email-multiple-outline',
    source: 'inboxThreads',
    mapRows: (rows) => rows.map((row) => ({ ...row, status: row.unread ? 'Unread' : 'Read' })),
    primaryKey: 'subject',
    secondaryKey: 'from',
    statusKey: 'status',
    statusOptions: ['Unread', 'Read'],
    columns: [
      { label: 'Subject', key: 'subject', strong: true, width: 'w-[28%]' },
      { label: 'From', key: 'from', width: 'w-[18%]' },
      { label: 'Company', key: 'company', width: 'w-[18%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[12%]' },
      { label: 'Linked', key: 'linked', width: 'w-[14%]' },
      { label: 'Time', key: 'time', width: 'w-[10%]' },
    ],
  },
  inbox: {
    title: 'Inbox',
    singular: 'Inbox Item',
    subtitle: 'Prioritized inbound lead conversations and CRM context.',
    icon: 'mdi:inbox-arrow-down-outline',
    source: 'inboxThreads',
    mapRows: (rows) => rows.map((row) => ({ ...row, status: row.unread ? 'Unread' : 'Read' })),
    primaryKey: 'from',
    secondaryKey: 'subject',
    statusKey: 'status',
    statusOptions: ['Unread', 'Read'],
    columns: [
      { label: 'From', key: 'from', strong: true, width: 'w-[18%]' },
      { label: 'Subject', key: 'subject', width: 'w-[24%]' },
      { label: 'Company', key: 'company', width: 'w-[16%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[12%]' },
      { label: 'Preview', key: 'preview', width: 'w-[20%]' },
      { label: 'Time', key: 'time', width: 'w-[10%]' },
    ],
  },
  analytics: {
    title: 'Analytics',
    singular: 'Analytics Row',
    subtitle: 'Sales and lead performance signals calculated from live CRM data.',
    icon: 'mdi:chart-box-outline',
    source: 'repRanking',
    mapRows: (rows) => rows.map((row, index) => ({ ...row, id: index + 1, status: row.quota >= 80 ? 'Strong' : 'Open' })),
    primaryKey: 'name',
    secondaryKey: (item) => `${item.winRate}% win rate`,
    statusKey: 'status',
    statusOptions: ['Strong', 'Open'],
    columns: [
      { label: 'Rep', key: 'name', strong: true, width: 'w-[30%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[18%]' },
      { label: 'Pipeline', key: 'pipeline', type: 'currency', align: 'right', width: 'w-[20%]' },
      { label: 'Win Rate', key: (item) => `${item.winRate}%`, align: 'right', width: 'w-[16%]' },
      { label: 'Quota', key: (item) => `${item.quota}%`, align: 'right', width: 'w-[16%]' },
    ],
  },
  reports: {
    title: 'Reports',
    singular: 'Report',
    subtitle: 'Ready-to-open operational reports based on live CRM modules.',
    icon: 'mdi:file-chart-outline',
    source: 'reportLibrary',
    mapRows: (rows) => rows.map((row, index) => ({ ...row, id: index + 1, status: 'Ready' })),
    primaryKey: 'title',
    secondaryKey: 'category',
    statusKey: 'status',
    statusOptions: ['Ready'],
    columns: [
      { label: 'Report', key: 'title', strong: true, width: 'w-[28%]' },
      { label: 'Category', key: 'category', width: 'w-[16%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[12%]' },
      { label: 'Uses', key: 'uses', align: 'right', width: 'w-[12%]' },
      { label: 'Description', key: 'description', width: 'w-[32%]' },
    ],
  },
  automation: {
    title: 'Automation',
    singular: 'Workflow',
    subtitle: 'Workflow monitors powered by lead, opportunity, and task health.',
    icon: 'mdi:robot-outline',
    source: 'workflows',
    mapRows: (rows) => rows.map((row) => ({ ...row, status: row.enabled ? 'Enabled' : 'Paused' })),
    primaryKey: 'name',
    secondaryKey: 'description',
    statusKey: 'status',
    statusOptions: ['Enabled', 'Paused'],
    columns: [
      { label: 'Workflow', key: 'name', strong: true, width: 'w-[34%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[16%]' },
      { label: 'Description', key: 'description', width: 'w-[50%]' },
    ],
  },
  settings: {
    title: 'Settings',
    singular: 'Settings Section',
    subtitle: 'Configuration overview for CRM objects, org structure, and automation inputs.',
    icon: 'mdi:cog-outline',
    source: 'settingsSections',
    mapRows: (rows) => rows.map((row, index) => ({ ...row, id: index + 1, status: 'Active', summary: row.items.join(', ') })),
    primaryKey: 'title',
    secondaryKey: 'summary',
    statusKey: 'status',
    statusOptions: ['Active'],
    columns: [
      { label: 'Section', key: 'title', strong: true, width: 'w-[30%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[16%]' },
      { label: 'Items', key: 'summary', width: 'w-[54%]' },
    ],
  },
  calendar: {
    title: 'Calendar',
    singular: 'Calendar Signal',
    subtitle: 'Calendar readiness, activity load, and upcoming work derived from backend data.',
    icon: 'mdi:calendar-month-outline',
    source: 'reportLibrary',
    mapRows: (rows) => rows.filter((row) => row.category === 'Calendar').map((row, index) => ({ ...row, id: index + 1, status: 'Ready' })),
    primaryKey: 'title',
    secondaryKey: 'description',
    statusKey: 'status',
    statusOptions: ['Ready'],
    columns: [
      { label: 'Signal', key: 'title', strong: true, width: 'w-[30%]' },
      { label: 'Status', key: 'status', status: true, width: 'w-[15%]' },
      { label: 'Events', key: 'uses', align: 'right', width: 'w-[13%]' },
      { label: 'Description', key: 'description', width: 'w-[42%]' },
    ],
  },
}

export default function AdvancedModulePage({ type }) {
  const { load } = useAdvancedCrmData()
  const definition = moduleMap[type]

  const config = staticWorkspaceConfig({
    ...definition,
    rows: [],
  })

  return (
    <ModuleWorkspace
      config={{
        ...config,
        load: async () => {
          const state = await load(true)
          return definition.mapRows(state[definition.source] || [])
        },
      }}
    />
  )
}
