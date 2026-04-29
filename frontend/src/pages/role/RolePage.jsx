import ModuleWorkspace from '../../components/module/ModuleWorkspace'
import { useRole } from '../../hooks/useRole'
import { roleConfig } from '../moduleConfigs'

export default function RolePage() {
  return <ModuleWorkspace config={roleConfig(useRole())} />
}
