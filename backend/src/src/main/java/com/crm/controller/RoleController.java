package com.crm.controller;

import com.crm.dto.request.RoleRequest;
import com.crm.dto.response.ApiResponse;
import com.crm.entity.Permission;
import com.crm.entity.Role;
import com.crm.service.RoleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/roles")
@RequiredArgsConstructor
public class RoleController {

    private final RoleService roleService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Role>>> getAll() {
        return ResponseEntity.ok(ApiResponse.success("Roles fetched", roleService.getAllRoles()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Role>> getById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Role fetched", roleService.getById(id)));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Role>> create(@Valid @RequestBody RoleRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Role created", roleService.create(request)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Role>> update(@PathVariable Long id, @Valid @RequestBody RoleRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Role updated", roleService.update(id, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        roleService.delete(id);
        return ResponseEntity.ok(ApiResponse.success("Role deleted", null));
    }

    @GetMapping("/{id}/permissions")
    public ResponseEntity<ApiResponse<List<Permission>>> getPermissions(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Permissions fetched", roleService.getPermissions(id)));
    }

    @PostMapping("/{id}/permissions")
    public ResponseEntity<ApiResponse<List<Permission>>> savePermissions(
            @PathVariable Long id, @RequestBody Map<String, List<String>> body) {
        return ResponseEntity.ok(ApiResponse.success("Permissions saved",
                roleService.savePermissions(id, body.get("permissions"))));
    }

    @DeleteMapping("/permissions/{permissionId}")
    public ResponseEntity<ApiResponse<Void>> deletePermission(@PathVariable Long permissionId) {
        roleService.deletePermission(permissionId);
        return ResponseEntity.ok(ApiResponse.success("Permission deleted", null));
    }
}
