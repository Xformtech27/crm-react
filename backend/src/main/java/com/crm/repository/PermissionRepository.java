package com.crm.repository;

import com.crm.entity.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PermissionRepository extends JpaRepository<Permission, Long> {
    boolean existsByModuleNameAndActionName(String moduleName, String actionName);

    Optional<Permission> findByModuleNameAndActionName(String moduleName, String actionName);
}

