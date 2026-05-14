package com.crm.service;

import com.crm.dto.request.RoleRequest;
import com.crm.entity.Permission;
import com.crm.entity.Role;
import com.crm.exception.BadRequestException;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.PermissionRepository;
import com.crm.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoleService {

    private final RoleRepository roleRepository;
    private final PermissionRepository permissionRepository;

    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    public Role getById(Long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Role", "id", id));
    }

    public Role create(RoleRequest req) {
        if (roleRepository.existsByRoleName(req.getRoleName())) {
            throw new BadRequestException("Role already exists: " + req.getRoleName());
        }
        return roleRepository.save(Role.builder().roleName(req.getRoleName()).build());
    }

    public Role update(Long id, RoleRequest req) {
        Role role = getById(id);
        role.setRoleName(req.getRoleName());
        return roleRepository.save(role);
    }

    public void delete(Long id) {
        permissionRepository.deleteByRoleIdFk(id);
        roleRepository.delete(getById(id));
    }

    public List<Permission> getPermissions(Long roleId) {
        getById(roleId);
        return permissionRepository.findByRoleIdFk(roleId);
    }

    @Transactional
    public List<Permission> savePermissions(Long roleId, List<String> permissionNames) {
        getById(roleId);
        permissionRepository.deleteByRoleIdFk(roleId);
        List<Permission> perms = permissionNames.stream()
                .filter(p -> p != null && !p.isBlank())
                .map(p -> Permission.builder().roleIdFk(roleId).grpPerm(p).build())
                .collect(Collectors.toList());
        return permissionRepository.saveAll(perms);
    }

    public void deletePermission(Long permissionId) {
        Permission perm = permissionRepository.findById(permissionId)
                .orElseThrow(() -> new ResourceNotFoundException("Permission", "id", permissionId));
        permissionRepository.delete(perm);
    }
}
