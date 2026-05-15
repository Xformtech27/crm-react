import { useEffect, useMemo, useState } from 'react'
import AppModal from '../../components/common/AppModal'
import Icon from '../../components/Icon'
import { useCreateTeam } from '../../hooks/useCreateTeam'
import { useTask } from '../../hooks/useTask'
import { useTeam } from '../../hooks/useTeam'
import { useTeamMember } from '../../hooks/useTeamMember'
import { formatDate } from '../../utils/format'
import {
  getMemberId,
  getMemberLabel,
  getTeamId,
  getTeamLabel,
  membersForTeam,
} from '../../utils/teamRelations'

const priorities = ['Low', 'Medium', 'High', 'Critical']
const statuses = ['To Do', 'In Progress', 'Blocked', 'Done']

const emptyTask = {
  taskName: '',
  taskAssignedTeam: '',
  taskAssignedMember: '',
  taskPriority: 'Medium',
  taskAssign: 'To Do',
  taskStartDate: '',
  taskDueDate: '',
  taskPercentageCompleted: 0,
  taskRelatedTo: '',
  taskDescription: '',
}

const statusClass = {
  'To Do': 'bg-gray-100 text-gray-700',
  'In Progress': 'bg-blue-50 text-blue-700',
  Blocked: 'bg-red-50 text-red-700',
  Done: 'bg-emerald-50 text-emerald-700',
}

const priorityClass = {
  Low: 'bg-gray-100 text-gray-700',
  Medium: 'bg-blue-50 text-blue-700',
  High: 'bg-orange-50 text-orange-700',
  Critical: 'bg-red-50 text-red-700',
}

export default function TaskPage() {
  const taskHook = useTask()
  const teamHook = useTeam()
  const teamMemberHook = useTeamMember()
  const createTeamHook = useCreateTeam()
  const [tasks, setTasks] = useState([])
  const [teams, setTeams] = useState([])
  const [members, setMembers] = useState([])
  const [assignments, setAssignments] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [query, setQuery] = useState('')
  const [modalOpen, setModalOpen] = useState(false)
  const [editingTask, setEditingTask] = useState(null)
  const [form, setForm] = useState(emptyTask)

  async function loadData() {
    setLoading(true)
    try {
      const [taskData, teamData, memberData, assignmentData] = await Promise.all([
        taskHook.getAll(),
        teamHook.getAll(),
        teamMemberHook.getAll(),
        createTeamHook.getAll(),
      ])
      setTasks(Array.isArray(taskData) ? taskData : [])
      setTeams(Array.isArray(teamData) ? teamData : [])
      setMembers(Array.isArray(memberData) ? memberData : [])
      setAssignments(Array.isArray(assignmentData) ? assignmentData : [])
    } catch (error) {
      console.error('Failed to load tasks:', error)
      setTasks([])
      setTeams([])
      setMembers([])
      setAssignments([])
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    loadData()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const teamById = useMemo(
    () => new Map(teams.map((team) => [Number(getTeamId(team)), team])),
    [teams],
  )

  const memberById = useMemo(
    () => new Map(members.map((member) => [Number(getMemberId(member)), member])),
    [members],
  )

  const availableMembers = useMemo(() => {
    if (!form.taskAssignedTeam) return []
    return membersForTeam(Number(form.taskAssignedTeam), members, assignments)
  }, [assignments, form.taskAssignedTeam, members])

  const filteredTasks = useMemo(() => {
    const text = query.trim().toLowerCase()
    if (!text) return tasks
    return tasks.filter((task) => {
      const team = teamById.get(Number(task.taskAssignedTeam))
      const member = memberById.get(Number(task.taskAssignedMember || task.taskAssignedTo))
      return [
        task.taskName,
        task.taskPriority,
        task.taskAssign,
        task.taskRelatedTo,
        getTeamLabel(team),
        getMemberLabel(member),
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(text)
    })
  }, [memberById, query, taskHook, tasks, teamById])

  function openCreate() {
    setEditingTask(null)
    setForm(emptyTask)
    setModalOpen(true)
  }

  function openEdit(task) {
    const assignedMember = task.taskAssignedMember || task.taskAssignedTo || ''
    setEditingTask(task)
    setForm({
      taskName: task.taskName || '',
      taskAssignedTeam: task.taskAssignedTeam || '',
      taskAssignedMember: assignedMember,
      taskPriority: task.taskPriority || 'Medium',
      taskAssign: task.taskAssign || 'To Do',
      taskStartDate: task.taskStartDate || '',
      taskDueDate: task.taskDueDate || '',
      taskPercentageCompleted: task.taskPercentageCompleted || 0,
      taskRelatedTo: task.taskRelatedTo || '',
      taskDescription: task.taskDescription || '',
    })
    setModalOpen(true)
  }

  function updateField(name, value) {
    setForm((current) => {
      const next = { ...current, [name]: value }
      if (name === 'taskAssignedTeam') next.taskAssignedMember = ''
      return next
    })
  }

  function toPayload() {
    const memberId = form.taskAssignedMember ? Number(form.taskAssignedMember) : null
    return {
      taskName: form.taskName.trim(),
      taskAssignedTeam: form.taskAssignedTeam ? Number(form.taskAssignedTeam) : null,
      taskAssignedMember: memberId,
      taskAssignedTo: memberId,
      taskPriority: form.taskPriority,
      taskAssign: form.taskAssign,
      taskStartDate: form.taskStartDate || null,
      taskDueDate: form.taskDueDate || null,
      taskRelatedTo: form.taskRelatedTo,
      taskDescription: form.taskDescription,
      taskPercentageCompleted: Number(form.taskPercentageCompleted || 0),
    }
  }

  async function saveTask(e) {
    e.preventDefault()
    if (!form.taskName.trim()) return
    setSaving(true)
    try {
      const payload = toPayload()
      if (editingTask) {
        await taskHook.update(editingTask.taskId, payload)
      } else {
        await taskHook.create(payload)
      }
      setModalOpen(false)
      await loadData()
    } catch (error) {
      console.error('Failed to save task:', error)
      alert('Unable to save task. Please check the details and try again.')
    } finally {
      setSaving(false)
    }
  }

  async function deleteTask(task) {
    if (!confirm(`Delete task "${task.taskName}"?`)) return
    setSaving(true)
    try {
      await taskHook.remove(task.taskId)
      await loadData()
    } catch (error) {
      console.error('Failed to delete task:', error)
      alert('Unable to delete task.')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="animate-fade-in space-y-4 pb-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="relative w-full sm:w-80">
          <Icon name="mdi:magnify" className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-full rounded-lg border border-gray-200 bg-white py-2 pl-9 pr-3 text-sm focus:border-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
            placeholder="Search tasks, teams, or members"
            type="search"
          />
        </div>
        <button onClick={openCreate} className="btn-primary">
          <Icon name="mdi:plus" className="h-4 w-4" />
          New Task
        </button>
      </div>

      <section className="grid grid-cols-1 gap-3 md:grid-cols-4">
        <Stat label="Tasks" value={tasks.length} />
        <Stat label="Teams" value={teams.length} />
        <Stat label="In Progress" value={tasks.filter((task) => task.taskAssign === 'In Progress').length} />
        <Stat label="Done" value={tasks.filter((task) => task.taskAssign === 'Done').length} />
      </section>

      <section className="overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm">
        {loading ? (
          <div className="p-6 text-center text-sm text-gray-500">Loading tasks...</div>
        ) : filteredTasks.length === 0 ? (
          <div className="p-10 text-center text-sm text-gray-500">No tasks found.</div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full min-w-[980px] text-left text-sm">
              <thead className="bg-gray-50 text-xs uppercase text-gray-500">
                <tr>
                  <th className="px-4 py-3">Task</th>
                  <th className="px-4 py-3">Team</th>
                  <th className="px-4 py-3">Member</th>
                  <th className="px-4 py-3">Priority</th>
                  <th className="px-4 py-3">Status</th>
                  <th className="px-4 py-3">Due</th>
                  <th className="px-4 py-3 text-right">Actions</th>
                </tr>
              </thead>
              <tbody>
                {filteredTasks.map((task) => {
                  const team = teamById.get(Number(task.taskAssignedTeam))
                  const member = memberById.get(Number(task.taskAssignedMember || task.taskAssignedTo))
                  return (
                    <tr key={task.taskId} className="border-t border-gray-100">
                      <td className="px-4 py-3">
                        <p className="font-semibold text-gray-900">{task.taskName}</p>
                        <p className="text-xs text-gray-400">{task.taskRelatedTo || 'No related record'}</p>
                      </td>
                      <td className="px-4 py-3">{getTeamLabel(team)}</td>
                      <td className="px-4 py-3">{getMemberLabel(member)}</td>
                      <td className="px-4 py-3">
                        <span className={`rounded-full px-2.5 py-1 text-xs font-semibold ${priorityClass[task.taskPriority] || priorityClass.Medium}`}>
                          {task.taskPriority || 'Medium'}
                        </span>
                      </td>
                      <td className="px-4 py-3">
                        <span className={`rounded-full px-2.5 py-1 text-xs font-semibold ${statusClass[task.taskAssign] || statusClass['To Do']}`}>
                          {task.taskAssign || 'To Do'}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-gray-600">{formatDate(task.taskDueDate)}</td>
                      <td className="px-4 py-3">
                        <div className="flex justify-end gap-1">
                          <button className="rounded-lg p-2 text-gray-500 hover:bg-blue-50 hover:text-blue-600" onClick={() => openEdit(task)} title="Edit task">
                            <Icon name="mdi:pencil-outline" className="h-4 w-4" />
                          </button>
                          <button className="rounded-lg p-2 text-gray-500 hover:bg-red-50 hover:text-red-600" onClick={() => deleteTask(task)} title="Delete task">
                            <Icon name="mdi:trash-can-outline" className="h-4 w-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        )}
      </section>

      <AppModal open={modalOpen} onClose={() => setModalOpen(false)} title={editingTask ? 'Edit Task' : 'Create New Task'} size="2xl">
        <form onSubmit={saveTask} className="space-y-5">
          <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
            <Field label="Task Title *" span>
              <input className="input-field" value={form.taskName} onChange={(e) => updateField('taskName', e.target.value)} required autoFocus />
            </Field>
            <Field label="Team *">
              <select className="input-field" value={form.taskAssignedTeam} onChange={(e) => updateField('taskAssignedTeam', e.target.value)} required>
                <option value="">Select team</option>
                {teams.map((team) => (
                  <option key={getTeamId(team)} value={getTeamId(team)}>{getTeamLabel(team)}</option>
                ))}
              </select>
            </Field>
            <Field label="Team Member *">
              <select className="input-field" value={form.taskAssignedMember} onChange={(e) => updateField('taskAssignedMember', e.target.value)} disabled={!form.taskAssignedTeam} required>
                <option value="">{form.taskAssignedTeam ? 'Select team member' : 'Select team first'}</option>
                {availableMembers.map((member) => (
                  <option key={getMemberId(member)} value={getMemberId(member)}>{getMemberLabel(member)}</option>
                ))}
              </select>
              {form.taskAssignedTeam && availableMembers.length === 0 && (
                <p className="mt-1 text-xs text-red-500">This team has no members. Add members on Teams page first.</p>
              )}
            </Field>
            <Field label="Priority">
              <select className="input-field" value={form.taskPriority} onChange={(e) => updateField('taskPriority', e.target.value)}>
                {priorities.map((priority) => <option key={priority} value={priority}>{priority}</option>)}
              </select>
            </Field>
            <Field label="Status">
              <select className="input-field" value={form.taskAssign} onChange={(e) => updateField('taskAssign', e.target.value)}>
                {statuses.map((status) => <option key={status} value={status}>{status}</option>)}
              </select>
            </Field>
            <Field label="Start Date">
              <input className="input-field" type="date" value={form.taskStartDate} onChange={(e) => updateField('taskStartDate', e.target.value)} />
            </Field>
            <Field label="Due Date">
              <input className="input-field" type="date" value={form.taskDueDate} onChange={(e) => updateField('taskDueDate', e.target.value)} />
            </Field>
            <Field label="Completion %">
              <input className="input-field" type="number" min="0" max="100" value={form.taskPercentageCompleted} onChange={(e) => updateField('taskPercentageCompleted', e.target.value)} />
            </Field>
            <Field label="Related To">
              <input className="input-field" value={form.taskRelatedTo} onChange={(e) => updateField('taskRelatedTo', e.target.value)} />
            </Field>
            <Field label="Description" span>
              <textarea className="input-field" rows="4" value={form.taskDescription} onChange={(e) => updateField('taskDescription', e.target.value)} />
            </Field>
          </div>

          <div className="flex justify-end gap-2 border-t border-gray-100 pt-4">
            <button type="button" className="btn-secondary" onClick={() => setModalOpen(false)}>Cancel</button>
            <button type="submit" className="btn-primary" disabled={saving || (form.taskAssignedTeam && availableMembers.length === 0)}>
              {saving ? 'Saving...' : 'Save Task'}
            </button>
          </div>
        </form>
      </AppModal>
    </div>
  )
}

function Stat({ label, value }) {
  return (
    <div className="rounded-lg border border-gray-100 bg-white p-4 shadow-sm">
      <p className="text-xs font-semibold uppercase text-gray-400">{label}</p>
      <p className="mt-1 text-2xl font-bold text-gray-900">{value}</p>
    </div>
  )
}

function Field({ label, children, span }) {
  return (
    <label className={span ? 'md:col-span-2' : ''}>
      <span className="mb-1 block text-sm font-medium text-gray-700">{label}</span>
      {children}
    </label>
  )
}
