export function objectToFormData(key, obj, files) {
  const fd = new FormData()
  const payload = {}
  for (const [field, value] of Object.entries(obj)) {
    if (value !== undefined && value !== null && value !== '') {
      payload[field] = value
    }
  }
  fd.append(key, new Blob([JSON.stringify(payload)], { type: 'application/json' }))
  if (files) {
    for (const [field, file] of Object.entries(files)) {
      if (file) fd.append(field, file)
    }
  }
  return fd
}

export function formatCurrency(value) {
  if (value == null) return '—'
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0,
  }).format(value)
}

export function formatDate(value) {
  if (!value) return '—'
  return new Date(value).toLocaleDateString('en-IN', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  })
}

export function formatDateTime(value) {
  if (!value) return '—'
  return new Date(value).toLocaleString('en-IN', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}

export function todayString() {
  return new Date().toISOString().slice(0, 10)
}

export function truncate(text, maxLength = 60) {
  if (!text) return '—'
  return text.length > maxLength ? text.slice(0, maxLength) + '…' : text
}

export function getInitials(name) {
  if (!name) return '?'
  const parts = name.trim().split(/\s+/)
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase()
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase()
}
