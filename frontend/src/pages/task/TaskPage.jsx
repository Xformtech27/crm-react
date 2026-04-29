import ModuleWorkspace from '../../components/module/ModuleWorkspace'
import { useTask } from '../../hooks/useTask'
import { taskConfig } from '../moduleConfigs'

export default function TaskPage() {
  return <ModuleWorkspace config={taskConfig(useTask())} />
}
