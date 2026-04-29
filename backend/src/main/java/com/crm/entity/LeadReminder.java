package com.crm.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "xformsales_lead_reminder")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class LeadReminder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lead_reminder_id")
    private Long leadReminderId;

    @Column(name = "lead_id_fk")
    private Long leadIdFk;

    @Column(name = "reminder_text", columnDefinition = "TEXT")
    private String reminderText;

    @Column(name = "reminder_date")
    private LocalDateTime reminderDate;

    @Column(name = "user_id_fk")
    private Long userIdFk;
}
