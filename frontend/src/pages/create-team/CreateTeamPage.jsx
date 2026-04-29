import ModuleWorkspace from '../../components/module/ModuleWorkspace'
import { useCreateTeam } from '../../hooks/useCreateTeam'
import { createTeamConfig } from '../moduleConfigs'

export default function CreateTeamPage() {
  return <ModuleWorkspace config={createTeamConfig(useCreateTeam())} />
}
