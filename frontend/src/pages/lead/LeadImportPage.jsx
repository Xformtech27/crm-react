import { useState } from 'react'
import { Link } from 'react-router-dom'
import { useLead } from '../../hooks/useLead'
import AppAlert from '../../components/common/AppAlert'
import AppCard from '../../components/common/AppCard'
import AppInput from '../../components/common/AppInput'
import Icon from '../../components/Icon'

export default function LeadImportPage() {
  const { importFromIndiamart } = useLead()
  const [fromDate, setFromDate] = useState('')
  const [toDate, setToDate] = useState('')
  const [loading, setLoading] = useState(false)
  const [alert, setAlert] = useState(null)

  async function handleImport(e) {
    e.preventDefault()
    if (!fromDate || !toDate) {
      setAlert({ type: 'error', message: 'Both From Date and To Date are required.' })
      return
    }
    setLoading(true)
    setAlert(null)
    try {
      const leads = await importFromIndiamart(fromDate, toDate)
      setAlert({ type: 'success', message: `Successfully imported ${leads.length} lead(s) from Indiamart.` })
    } catch (e) {
      setAlert({ type: 'error', message: e?.response?.data?.message || 'Import failed. Please try again.' })
    } finally {
      setLoading(false)
    }
  }

  return (
    <div>
      <div className="flex items-center gap-3 mb-6">
        <Link to="/lead" className="text-gray-400 hover:text-gray-600">
          <Icon name="mdi:arrow-left" className="text-xl" />
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">Import Leads from Indiamart</h1>
      </div>

      <div className="max-w-lg">
        {alert && <AppAlert type={alert.type} message={alert.message} className="mb-4" />}

        <AppCard title="Import Settings">
          <form onSubmit={handleImport} className="space-y-4">
            <AppInput
              label="From Date"
              type="date"
              value={fromDate}
              onChange={(e) => setFromDate(e.target.value)}
              required
            />
            <AppInput
              label="To Date"
              type="date"
              value={toDate}
              onChange={(e) => setToDate(e.target.value)}
              required
            />
            <button
              type="submit"
              disabled={loading}
              className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-60"
            >
              {loading ? <Icon name="mdi:loading" className="animate-spin" /> : <Icon name="mdi:cloud-download" />}
              {loading ? 'Importing…' : 'Import Leads'}
            </button>
          </form>
        </AppCard>

        <p className="text-xs text-gray-400 mt-4">
          Leads will be fetched from Indiamart's API for the selected date range and added to your CRM.
        </p>
      </div>
    </div>
  )
}
