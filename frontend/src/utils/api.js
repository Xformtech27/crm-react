import axios from 'axios'

let instance = null

export function getApiClient(baseURL) {
  if (!instance) {
    instance = axios.create({ baseURL })

    instance.interceptors.request.use((config) => {
      const token = localStorage.getItem('crm_token')
      if (token) {
        config.headers.Authorization = `Bearer ${token}`
      }
      return config
    })

    instance.interceptors.response.use(
      (response) => response,
      (error) => {
        if (error.response?.status === 401) {
          localStorage.removeItem('crm_token')
          localStorage.removeItem('crm_user')
          window.location.href = '/login'
        }
        return Promise.reject(error)
      }
    )
  }
  return instance
}

export function resetApiClient() {
  instance = null
}
