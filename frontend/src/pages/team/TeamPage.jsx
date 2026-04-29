import ModuleWorkspace from '../../components/module/ModuleWorkspace'
import { useTeam } from '../../hooks/useTeam'
import { teamConfig } from '../moduleConfigs'

export default function TeamPage() {
  return <ModuleWorkspace config={teamConfig(useTeam())} />
}
