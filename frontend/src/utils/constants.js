export const LEAD_STATUS_COLORS = {
  'New Lead':      'blue',
  'NotContacted':  'gray',
  'Contacted':     'indigo',
  'Working':       'cyan',
  'Qualified Lead':'purple',
  'QuotationSent': 'orange',
  'Negotiation':   'yellow',
  'Converted':     'green',
  'Won':           'green',
  'Lost':          'red',
  'Open':          'blue',
  'On Hold':       'gray',
}

export const OPP_STATUS_COLORS = {
  'New': 'blue',
  'Qualified': 'indigo',
  'Proposal': 'purple',
  'Negotiation': 'orange',
  'Won': 'green',
  'Lost': 'red',
  'On Hold': 'gray',
}

export const PROJECT_STATUS_COLORS = {
  'Not Started': 'gray',
  'In Progress': 'blue',
  'On Hold': 'yellow',
  'Completed': 'green',
  'Cancelled': 'red',
}

export const TASK_PRIORITY_COLORS = {
  'Low': 'green',
  'Medium': 'yellow',
  'High': 'orange',
  'Critical': 'red',
}

export const TASK_STATUS_COLORS = {
  'To Do': 'gray',
  'In Progress': 'blue',
  'Review': 'purple',
  'Done': 'green',
  'Blocked': 'red',
}

export const LEAD_STATUSES = [
  'New Lead', 'NotContacted', 'Contacted', 'Working',
  'Qualified Lead', 'QuotationSent', 'Negotiation',
  'Converted', 'Won', 'Lost', 'Open',
]

export const OPP_STATUSES = [
  'New', 'Qualified', 'Proposal', 'Negotiation', 'Won', 'Lost', 'On Hold',
]

export const PROJECT_STATUSES = [
  'Not Started', 'In Progress', 'On Hold', 'Completed', 'Cancelled',
]

export const TASK_STATUSES = [
  'To Do', 'In Progress', 'Review', 'Done', 'Blocked',
]

export const TASK_PRIORITIES = ['Low', 'Medium', 'High', 'Critical']

export const LEAD_SOURCES = [
  'Website', 'Indiamart', 'Referral', 'Cold Call', 'Email',
  'Social Media', 'Trade Show', 'Advertisement', 'Other',
]

export const INDUSTRIES = [
  'Agriculture', 'Automotive', 'Banking', 'Chemicals', 'Construction',
  'Consumer Goods', 'Education', 'Electronics', 'Energy', 'Finance',
  'Food & Beverage', 'Government', 'Healthcare', 'Hospitality',
  'Information Technology', 'Insurance', 'Legal', 'Logistics',
  'Manufacturing', 'Media', 'Mining', 'Pharmaceuticals',
  'Real Estate', 'Retail', 'Telecommunications', 'Textiles',
  'Transportation', 'Utilities', 'Other',
]

export const COUNTRIES = [
  'India', 'United States', 'United Kingdom', 'Canada', 'Australia',
  'Germany', 'France', 'Japan', 'China', 'Singapore', 'UAE',
  'Saudi Arabia', 'South Africa', 'Brazil', 'Mexico', 'Other',
]

export const CONTACT_STATUSES = ['Active', 'Inactive']
export const ORG_STATUSES = ['Active', 'Inactive']

export const PERMISSIONS = {
  Leads: ['leads.view', 'leads.create', 'leads.edit', 'leads.delete', 'leads.import'],
  Opportunities: ['opportunities.view', 'opportunities.create', 'opportunities.edit', 'opportunities.delete'],
  Projects: ['projects.view', 'projects.create', 'projects.edit', 'projects.delete'],
  Tasks: ['tasks.view', 'tasks.create', 'tasks.edit', 'tasks.delete'],
  Contacts: ['contacts.view', 'contacts.create', 'contacts.edit', 'contacts.delete'],
  Organizations: ['organizations.view', 'organizations.create', 'organizations.edit', 'organizations.delete'],
  Teams: ['teams.view', 'teams.create', 'teams.edit', 'teams.delete'],
  Users: ['users.view', 'users.create', 'users.edit', 'users.delete'],
  Reports: ['reports.view'],
  Calendar: ['calendar.view', 'calendar.create', 'calendar.edit', 'calendar.delete'],
}
