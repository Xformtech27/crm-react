import ModuleWorkspace from '../../components/module/ModuleWorkspace'
import { useTeamMember } from '../../hooks/useTeamMember'
import { teamMemberConfig } from '../moduleConfigs'

export default function TeamMemberPage() {
  return <ModuleWorkspace config={teamMemberConfig(useTeamMember())} />
}
