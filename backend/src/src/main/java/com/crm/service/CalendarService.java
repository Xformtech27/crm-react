package com.crm.service;

import com.crm.entity.LeadReminder;
import com.crm.entity.Task;
import com.crm.repository.LeadReminderRepository;
import com.crm.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CalendarService {

    private final TaskRepository taskRepository;
    private final LeadReminderRepository leadReminderRepository;

    public Map<String, Object> getCalendarEvents(String date) {
        LocalDate localDate;
        try {
            localDate = LocalDate.parse(date);
        } catch (Exception e) {
            localDate = LocalDate.now();
        }
        List<Task> tasks = taskRepository.findByTaskDueDate(localDate);
        List<LeadReminder> reminders = leadReminderRepository.findByReminderDateOn(localDate);

        List<Map<String, Object>> events = new ArrayList<>();

        tasks.forEach(t -> {
            Map<String, Object> event = new HashMap<>();
            event.put("type", "task");
            event.put("id", t.getTaskId());
            event.put("title", t.getTaskName());
            event.put("date", t.getTaskDueDate() != null ? t.getTaskDueDate().toString() : null);
            event.put("priority", t.getTaskPriority());
            event.put("status", t.getTaskPercentageCompleted());
            events.add(event);
        });

        reminders.forEach(r -> {
            Map<String, Object> event = new HashMap<>();
            event.put("type", "reminder");
            event.put("id", r.getLeadReminderId());
            event.put("title", r.getReminderText());
            event.put("date", r.getReminderDate() != null ? r.getReminderDate().toString() : null);
            event.put("leadId", r.getLeadIdFk());
            events.add(event);
        });

        Map<String, Object> result = new HashMap<>();
        result.put("events", events);
        result.put("tasks", tasks);
        result.put("reminders", reminders);
        return result;
    }
}
