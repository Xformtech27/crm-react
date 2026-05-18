package com.crm.service;

import com.crm.dto.request.TaskRequest;
import com.crm.entity.Task;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.TaskRepository;
import com.crm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;
    private final FileUploadUtil fileUploadUtil;

    public List<Task> getAllTasks(Long userId, String role) {
        if ("admin".equalsIgnoreCase(role)) return taskRepository.findAll();
        return taskRepository.findByUserIdFk(userId);
    }

    public Task getById(Long id) {
        return taskRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Task", "id", id));
    }

    public List<Task> getByTeam(Long teamId) {
        return taskRepository.findByTaskAssignedTeam(teamId);
    }

    public Task create(TaskRequest req, Long userId, MultipartFile doc) throws IOException {
        Task task = mapToEntity(req, new Task());
        task.setUserIdFk(userId);
        if (doc != null && !doc.isEmpty()) task.setTaskDoc(fileUploadUtil.upload(doc));
        return taskRepository.save(task);
    }

    public Task update(Long id, TaskRequest req, MultipartFile doc) throws IOException {
        Task task = getById(id);
        mapToEntity(req, task);
        if (doc != null && !doc.isEmpty()) task.setTaskDoc(fileUploadUtil.upload(doc));
        return taskRepository.save(task);
    }

    public void delete(Long id) {
        taskRepository.delete(getById(id));
    }

    private Task mapToEntity(TaskRequest req, Task task) {
        task.setTaskName(req.getTaskName());
        task.setTaskAssignedMember(req.getTaskAssignedMember());
        task.setTaskAssignedTeam(req.getTaskAssignedTeam());
        task.setTaskAssign(req.getTaskAssign());
        task.setTaskAssignedTo(req.getTaskAssignedTo());
        task.setTaskStartDate(req.getTaskStartDate());
        task.setTaskDueDate(req.getTaskDueDate());
        task.setTaskRelatedTo(req.getTaskRelatedTo());
        task.setTaskDescription(req.getTaskDescription());
        task.setTaskPriority(req.getTaskPriority());
        task.setTaskPercentageCompleted(req.getTaskPercentageCompleted());
        return task;
    }
}
