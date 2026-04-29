import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export const useAuthStore = create(
  persist(
    (set, get) => ({
      token: null,
      user: null,
      hasHydrated: false,

      setHasHydrated: (state) => set({ hasHydrated: state }),

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
        set({ token, user }) // ✅ no manual localStorage
      },

      logout: () => {
        set({ token: null, user: null }) // ✅ persist will handle removal
      },
    }),
    {
      name: 'auth-storage',

      onRehydrateStorage: () => (state) => {
        state.setHasHydrated(true)
      },
    }
  )
)