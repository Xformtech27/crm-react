import { create } from 'zustand'

const TOKEN_KEY = 'crm_token'
const USER_KEY = 'crm_user'

export const useAuthStore = create((set, get) => ({
  token: null,
  user: null,

  isAuthenticated: () => !!get().token,
  currentUser: () => get().user,
  isAdmin: () => get().user?.role?.toLowerCase() === 'admin',
  hasPermission: (permission) => {
    const perms = get().user?.permissions ?? []
    return perms.includes(permission)
  },
  hasAnyPermission: (permissions) => {
    const perms = get().user?.permissions ?? []
    return permissions.some((p) => perms.includes(p))
  },

  setAuth: (data) => {
    const { token, ...user } = data
    localStorage.setItem(TOKEN_KEY, token)
    localStorage.setItem(USER_KEY, JSON.stringify(user))
    set({ token, user })
  },

  logout: () => {
    localStorage.removeItem(TOKEN_KEY)
    localStorage.removeItem(USER_KEY)
    set({ token: null, user: null })
  },

  loadFromStorage: () => {
    const token = localStorage.getItem(TOKEN_KEY)
    const userStr = localStorage.getItem(USER_KEY)
    if (token && userStr) {
      try {
        const user = JSON.parse(userStr)
        set({ token, user })
      } catch {
        localStorage.removeItem(TOKEN_KEY)
        localStorage.removeItem(USER_KEY)
        set({ token: null, user: null })
      }
    }
  },
}))
