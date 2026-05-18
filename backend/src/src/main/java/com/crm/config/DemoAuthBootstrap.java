package com.crm.config;

import com.crm.entity.Permission;
import com.crm.entity.Role;
import com.crm.entity.User;
import com.crm.repository.PermissionRepository;
import com.crm.repository.RoleRepository;
import com.crm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class DemoAuthBootstrap implements CommandLineRunner {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PermissionRepository permissionRepository;
    private final PasswordEncoder passwordEncoder;

    private static final String DEMO_PASSWORD = "Admin@123";

    @Override
    @Transactional
    public void run(String... args) {
        ensureRoles();
        ensurePermissions();
        ensureDemoUsers();
    }

    private void ensureRoles() {
        List<String> roles = List.of(
                "ADMIN",
                "Sales Manager",
                "Sales Executive",
                "Lead Qualifier",
                "Account Manager",
                "Support Executive"
        );

        for (String roleName : roles) {
            if (!roleRepository.existsByRoleName(roleName)) {
                roleRepository.save(Role.builder().roleName(roleName).build());
            }
        }
    }

    private void ensurePermissions() {
        Map<String, List<String>> permsByRole = Map.of(
                "ADMIN", List.of(
                        "dashboard.view", "leads.view", "leads.create", "leads.edit", "leads.delete",
                        "opportunities.view", "projects.view", "tasks.view", "reports.view", "roles.view", "settings.view"
                ),
                "Sales Manager", List.of(
                        "dashboard.view", "leads.view", "leads.create", "leads.edit",
                        "opportunities.view", "opportunities.create", "projects.view", "tasks.view"
                ),
                "Sales Executive", List.of(
                        "dashboard.view", "leads.view", "leads.create", "opportunities.view", "tasks.view"
                )
        );

        for (Map.Entry<String, List<String>> entry : permsByRole.entrySet()) {
            Optional<Role> roleOpt = roleRepository.findByRoleName(entry.getKey());
            if (roleOpt.isEmpty()) continue;

            Long roleId = roleOpt.get().getRoleId();
            for (String permission : entry.getValue()) {
                if (!permissionRepository.existsByRoleIdFkAndGrpPerm(roleId, permission)) {
                    permissionRepository.save(Permission.builder()
                            .roleIdFk(roleId)
                            .grpPerm(permission)
                            .build());
                }
            }
        }
    }

    private void ensureDemoUsers() {
        ensureUser("admin@crm.local", "admin", "ADMIN");
        ensureUser("manager.demo@crm.local", "manager.demo", "Sales Manager");
        ensureUser("executive.demo@crm.local", "executive.demo", "Sales Executive");
    }

    private void ensureUser(String email, String username, String role) {
        User user = userRepository.findByUserEmail(email)
                .orElseGet(() -> User.builder()
                        .userEmail(email)
                        .username(username)
                        .role(role)
                        .createdDate(LocalDate.now())
                        .build());

        user.setUsername(username);
        user.setRole(role);
        if (user.getCreatedDate() == null) {
            user.setCreatedDate(LocalDate.now());
        }

        if (user.getPassword() == null || !passwordEncoder.matches(DEMO_PASSWORD, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(DEMO_PASSWORD));
        }

        userRepository.save(user);
    }
}