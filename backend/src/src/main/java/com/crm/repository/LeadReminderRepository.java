package com.crm.repository;

import com.crm.entity.LeadReminder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LeadReminderRepository extends JpaRepository<LeadReminder, Long> {
    List<LeadReminder> findByLeadIdFkOrderByReminderDate(Long leadIdFk);
    @org.springframework.data.jpa.repository.Query("SELECT r FROM LeadReminder r WHERE CAST(r.reminderDate AS date) = :date")
    List<LeadReminder> findByReminderDateOn(@org.springframework.data.repository.query.Param("date") java.time.LocalDate date);
    void deleteByLeadIdFk(Long leadIdFk);
}
