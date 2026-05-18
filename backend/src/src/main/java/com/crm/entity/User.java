package com.crm.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Entity
@Table(name = "crm_xformsales_user")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userid;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(name = "user_email", nullable = false, unique = true)
    private String userEmail;

    @Column(nullable = false)
    private String role;

    @Column(name = "created_date")
    private LocalDate createdDate;
}
