import { Routes, Route, Navigate } from 'react-router-dom'
import AuthLayout from '../layouts/AuthLayout'
import DefaultLayout from '../layouts/DefaultLayout'
import ProtectedRoute from '../middleware/ProtectedRoute'

import LoginPage from '../pages/LoginPage'
import HomePage from '../pages/HomePage'
import LeadListPage from '../pages/lead/LeadListPage'
import LeadDetailPage from '../pages/lead/LeadDetailPage'
import LeadImportPage from '../pages/lead/LeadImportPage'
import ContactPage from '../pages/contact/ContactPage'
import ContactDetailPage from '../pages/contact/ContactDetailPage'
import OpportunityPage from '../pages/opportunity/OpportunityPage'
import OrganizationPage from '../pages/organization/OrganizationPage'
import OrganizationDetailPage from '../pages/organization/OrganizationDetailPage'
import ProjectPage from '../pages/project/ProjectPage'
import ProjectDetailPage from '../pages/project/ProjectDetailPage'
import TaskPage from '../pages/task/TaskPage'
import TeamPage from '../pages/team/TeamPage'
import TeamDetailPage from '../pages/team/TeamDetailPage'
import TeamMemberPage from '../pages/team-member/TeamMemberPage'
import RolePage from '../pages/role/RolePage'
import SettingsPage from '../pages/settings/SettingsPage'
import PipelinePage from '../pages/pipeline/PipelinePage'
import DealsPage from '../pages/deals/DealsPage'
import ActivitiesPage from '../pages/activities/ActivitiesPage'
import EmailsPage from '../pages/emails/EmailsPage'
import InboxPage from '../pages/inbox/InboxPage'
import CalendarPage from '../pages/calendar/CalendarPage'
import AnalyticsPage from '../pages/analytics/AnalyticsPage'
import ReportsPage from '../pages/reports/ReportsPage'
import AutomationPage from '../pages/automation/AutomationPage'
import CreateTeamPage from '../pages/create-team/CreateTeamPage'

export default function AppRouter() {
  return (
    <Routes>
      {/* Public */}
      <Route element={<AuthLayout />}>
        <Route path="/login" element={<LoginPage />} />
      </Route>

      {/* Protected */}
      <Route
        element={
          <ProtectedRoute>
            <DefaultLayout />
          </ProtectedRoute>
        }
      >
        <Route index element={<Navigate to="/home" replace />} />
        <Route path="/home" element={<HomePage />} />
        <Route path="/lead" element={<LeadListPage />} />
        <Route path="/lead/import" element={<LeadImportPage />} />
        <Route path="/lead/:id" element={<LeadDetailPage />} />
        <Route path="/contact" element={<ContactPage />} />
        <Route path="/contact/:id" element={<ContactDetailPage />} />
        <Route path="/opportunity" element={<OpportunityPage />} />
        <Route path="/organization" element={<OrganizationPage />} />
        <Route path="/organization/:id" element={<OrganizationDetailPage />} />
        <Route path="/project" element={<ProjectPage />} />
        <Route path="/project/:id" element={<ProjectDetailPage />} />
        <Route path="/task" element={<TaskPage />} />
        <Route path="/team" element={<TeamPage />} />
        <Route path="/team/:id" element={<TeamDetailPage />} />
        <Route path="/team-member" element={<TeamMemberPage />} />
        <Route path="/role" element={<RolePage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="/pipeline" element={<PipelinePage />} />
        <Route path="/deals" element={<DealsPage />} />
        <Route path="/activities" element={<ActivitiesPage />} />
        <Route path="/emails" element={<EmailsPage />} />
        <Route path="/inbox" element={<InboxPage />} />
        <Route path="/calendar" element={<CalendarPage />} />
        <Route path="/analytics" element={<AnalyticsPage />} />
        <Route path="/reports" element={<ReportsPage />} />
        <Route path="/automation" element={<AutomationPage />} />
        <Route path="/create-team" element={<CreateTeamPage />} />
      </Route>

      <Route path="*" element={<Navigate to="/home" replace />} />
    </Routes>
  )
}
