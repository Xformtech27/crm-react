import { useEffect } from 'react'
import { Navigate, useLocation } from 'react-router-dom'
import { useAuthStore } from '../stores/auth'

const routePermissions = {
  '/home': ['dashboard.view'],
  '/lead': ['leads.view'],
  '/contact': ['contacts.view'],
  '/organization': ['organizations.view'],
  '/opportunity': ['opportunities.view'],
  '/pipeline': ['opportunities.view'],
  '/deals': ['opportunities.view'],
  '/project': ['projects.view'],
  '/task': ['tasks.view'],
  '/reports': ['reports.view'],
  '/role': ['roles.view'],
  '/settings': ['settings.view'],
}

export default function ProtectedRoute({ children }) {
  const location = useLocation()
  const { loadFromStorage, isAuthenticated, isAdmin, hasAnyPermission } = useAuthStore()

  useEffect(() => {
    loadFromStorage()
  }, [loadFromStorage])

  const authenticated = isAuthenticated()

  if (!authenticated) {
    return <Navigate to="/login" state={{ from: location }} replace />
  }

  const match = Object.keys(routePermissions)
    .sort((a, b) => b.length - a.length)
    .find((prefix) => location.pathname === prefix || location.pathname.startsWith(`${prefix}/`))

  if (match) {
    const required = routePermissions[match]
    if (!hasAnyPermission(required) && !isAdmin()) {
      return <Navigate to="/home" replace />
    }
  }

  return children
}
