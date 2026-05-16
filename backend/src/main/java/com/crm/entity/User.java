package com.crm.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "crm_xformsales_user")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userid;

    // Backward-compat: other services expect getId()
    public Long getId() {
        return userid;
    }

    public void setId(Long id) {
        this.userid = id;
    }

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(name = "user_email", nullable = false, unique = true)
    private String userEmail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    private Role role;

    @Column(name = "role", nullable = false)
    private String legacyRoleName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id")
    private Company company;

    @Builder.Default
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private User createdByUser;

    @Column(name = "created_date")
    private LocalDateTime createdDate;

    @PrePersist
    @PreUpdate
    protected void syncState() {
        if (role != null) {
            legacyRoleName = role.getRoleType() != null ? role.getRoleType().name() : role.getRoleName();
        }
        if (createdDate == null) {
            createdDate = LocalDateTime.now();
        }
    }
}
