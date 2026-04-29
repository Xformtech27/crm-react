import { useApi } from './useApi'

export function useCalendar() {
  const api = useApi()
  const getEvents = (date) => {
    const url = date ? `/calendar/${date}` : '/calendar'
    return api.get(url)
  }
  return { getEvents }
}
