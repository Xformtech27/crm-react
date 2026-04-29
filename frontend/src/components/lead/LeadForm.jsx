import { useState, useEffect } from 'react'
import Icon from '../Icon'
import { LEAD_STATUSES, LEAD_SOURCES, INDUSTRIES, COUNTRIES } from '../../utils/constants'

const EMPTY = {
  leadFirstName: '', leadLastName: '', leadTitle: '', leadEmail: '',
  leadMobileNo: '', leadPhoneNo: '', leadOrganisationName: '', designation: '',
  leadWebsite: '', leadIndustry: '', leadStatus: 'New Lead', leadSource: '',
  leadCountry: '', leadCity: '', leadState: '', leadAddress: '',
  leadType: '', leadReason: '', noOfEmployee: '',
}

function populate(data) {
  if (!data) return { ...EMPTY }
  return {
    leadFirstName: data.leadFirstName ?? '',
    leadLastName: data.leadLastName ?? '',
    leadTitle: data.leadTitle ?? '',
    leadEmail: data.leadEmail ?? '',
    leadMobileNo: data.leadMobileNo ?? '',
    leadPhoneNo: data.leadPhoneNo ?? '',
    leadOrganisationName: data.leadOrganisationName ?? '',
    designation: data.designation ?? '',
    leadWebsite: data.leadWebsite ?? '',
    leadIndustry: data.leadIndustry ?? '',
    leadStatus: data.leadStatus ?? 'New Lead',
    leadSource: data.leadSource ?? '',
    leadCountry: data.leadCountry ?? '',
    leadCity: data.leadCity ?? '',
    leadState: data.leadState ?? '',
    leadAddress: data.leadAddress ?? '',
    leadType: data.leadType ?? '',
    leadReason: data.leadReason ?? '',
    noOfEmployee: data.noOfEmployee ?? '',
  }
}

export default function LeadForm({ initial, loading, onSubmit }) {
  const [form, setForm] = useState(() => populate(initial))

  useEffect(() => {
    setForm(populate(initial))
  }, [initial])

  function set(field, value) {
    setForm((f) => ({ ...f, [field]: value }))
  }

  function handleSubmit(e) {
    e?.preventDefault()
    onSubmit?.({ ...form, noOfEmployee: form.noOfEmployee ? Number(form.noOfEmployee) : undefined })
  }

  const inputCls = 'w-full px-3 py-2 text-sm border border-gray-200 rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400 placeholder-gray-300 transition-colors'
  const selectCls = 'w-full px-3 py-2 text-sm border border-gray-200 rounded-lg bg-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-400 text-gray-700 transition-colors appearance-none'
  const labelCls = 'block text-xs font-semibold text-gray-600 mb-1.5'

  return (
    <form id="lead-form" onSubmit={handleSubmit} className="space-y-6">
      {/* Personal Info */}
      <div>
        <div className="flex items-center gap-2 mb-4">
          <div className="w-6 h-6 rounded-md bg-blue-100 flex items-center justify-center">
            <Icon name="mdi:account-outline" className="w-3.5 h-3.5 text-blue-600" />
          </div>
          <p className="text-sm font-semibold text-gray-700">Personal Information</p>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className={labelCls}>First Name <span className="text-red-500">*</span></label>
            <input type="text" value={form.leadFirstName} onChange={(e) => set('leadFirstName', e.target.value)} placeholder="Enter first name" className={inputCls} required />
          </div>
          <div>
            <label className={labelCls}>Last Name</label>
            <input type="text" value={form.leadLastName} onChange={(e) => set('leadLastName', e.target.value)} placeholder="Enter last name" className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>Email</label>
            <div className="relative">
              <Icon name="mdi:email-outline" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none" />
              <input type="email" value={form.leadEmail} onChange={(e) => set('leadEmail', e.target.value)} placeholder="email@example.com" className={`${inputCls} pl-9`} />
            </div>
          </div>
          <div>
            <label className={labelCls}>Mobile</label>
            <div className="relative">
              <Icon name="mdi:phone-outline" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none" />
              <input type="tel" value={form.leadMobileNo} onChange={(e) => set('leadMobileNo', e.target.value)} placeholder="+91 98765 43210" className={`${inputCls} pl-9`} />
            </div>
          </div>
          <div>
            <label className={labelCls}>Phone</label>
            <input type="tel" value={form.leadPhoneNo} onChange={(e) => set('leadPhoneNo', e.target.value)} placeholder="Alternate phone" className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>Designation</label>
            <input type="text" value={form.designation} onChange={(e) => set('designation', e.target.value)} placeholder="e.g. Manager, Director" className={inputCls} />
          </div>
        </div>
      </div>

      <div className="border-t border-gray-100" />

      {/* Company Info */}
      <div>
        <div className="flex items-center gap-2 mb-4">
          <div className="w-6 h-6 rounded-md bg-violet-100 flex items-center justify-center">
            <Icon name="mdi:office-building-outline" className="w-3.5 h-3.5 text-violet-600" />
          </div>
          <p className="text-sm font-semibold text-gray-700">Company Information</p>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div className="sm:col-span-2">
            <label className={labelCls}>Company Name</label>
            <div className="relative">
              <Icon name="mdi:domain" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none" />
              <input type="text" value={form.leadOrganisationName} onChange={(e) => set('leadOrganisationName', e.target.value)} placeholder="Company / Organization name" className={`${inputCls} pl-9`} />
            </div>
          </div>
          <div>
            <label className={labelCls}>Industry</label>
            <select value={form.leadIndustry} onChange={(e) => set('leadIndustry', e.target.value)} className={selectCls}>
              <option value="">Select industry...</option>
              {INDUSTRIES.map((opt) => <option key={opt} value={opt}>{opt}</option>)}
            </select>
          </div>
          <div>
            <label className={labelCls}>No. of Employees</label>
            <input type="number" min="1" value={form.noOfEmployee} onChange={(e) => set('noOfEmployee', e.target.value)} placeholder="e.g. 50" className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>Website</label>
            <div className="relative">
              <Icon name="mdi:web" className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none" />
              <input type="url" value={form.leadWebsite} onChange={(e) => set('leadWebsite', e.target.value)} placeholder="https://example.com" className={`${inputCls} pl-9`} />
            </div>
          </div>
          <div>
            <label className={labelCls}>Title / Position</label>
            <input type="text" value={form.leadTitle} onChange={(e) => set('leadTitle', e.target.value)} placeholder="e.g. Senior Manager" className={inputCls} />
          </div>
        </div>
      </div>

      <div className="border-t border-gray-100" />

      {/* Lead Details */}
      <div>
        <div className="flex items-center gap-2 mb-4">
          <div className="w-6 h-6 rounded-md bg-emerald-100 flex items-center justify-center">
            <Icon name="mdi:tag-outline" className="w-3.5 h-3.5 text-emerald-600" />
          </div>
          <p className="text-sm font-semibold text-gray-700">Lead Details</p>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className={labelCls}>Status <span className="text-red-500">*</span></label>
            <select value={form.leadStatus} onChange={(e) => set('leadStatus', e.target.value)} className={selectCls}>
              <option value="">Select status...</option>
              {LEAD_STATUSES.map((opt) => <option key={opt} value={opt}>{opt}</option>)}
            </select>
          </div>
          <div>
            <label className={labelCls}>Source</label>
            <select value={form.leadSource} onChange={(e) => set('leadSource', e.target.value)} className={selectCls}>
              <option value="">Select source...</option>
              {LEAD_SOURCES.map((opt) => <option key={opt} value={opt}>{opt}</option>)}
            </select>
          </div>
          <div>
            <label className={labelCls}>Lead Type</label>
            <input type="text" value={form.leadType} onChange={(e) => set('leadType', e.target.value)} placeholder="e.g. Hot, Warm, Cold" className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>Country</label>
            <select value={form.leadCountry} onChange={(e) => set('leadCountry', e.target.value)} className={selectCls}>
              <option value="">Select country...</option>
              {COUNTRIES.map((opt) => <option key={opt} value={opt}>{opt}</option>)}
            </select>
          </div>
          <div>
            <label className={labelCls}>City</label>
            <input type="text" value={form.leadCity} onChange={(e) => set('leadCity', e.target.value)} placeholder="City" className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>State</label>
            <input type="text" value={form.leadState} onChange={(e) => set('leadState', e.target.value)} placeholder="State / Province" className={inputCls} />
          </div>
          <div className="sm:col-span-2">
            <label className={labelCls}>Address</label>
            <textarea value={form.leadAddress} onChange={(e) => set('leadAddress', e.target.value)} rows={2} placeholder="Full address..." className={`${inputCls} resize-none`} />
          </div>
          <div className="sm:col-span-2">
            <label className={labelCls}>Notes / Reason</label>
            <textarea value={form.leadReason} onChange={(e) => set('leadReason', e.target.value)} rows={3} placeholder="Add any notes, requirements, or context about this lead..." className={`${inputCls} resize-none`} />
          </div>
        </div>
      </div>
    </form>
  )
}
