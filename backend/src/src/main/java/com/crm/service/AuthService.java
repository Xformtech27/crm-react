package com.crm.service;

import com.crm.dto.request.ChangePasswordRequest;
import com.crm.dto.request.LoginRequest;
import com.crm.dto.response.ApiResponse;
import com.crm.dto.response.AuthResponse;
import com.crm.entity.Permission;
import com.crm.entity.Role;
import com.crm.entity.User;
import com.crm.exception.BadRequestException;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.PermissionRepository;
import com.crm.repository.RoleRepository;
import com.crm.repository.UserRepository;
import com.crm.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PermissionRepository permissionRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider tokenProvider;
    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender mailSender;

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getUserEmail(), request.getPassword())
        );

        User user = userRepository.findByUserEmail(request.getUserEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", request.getUserEmail()));

        String token = tokenProvider.generateToken(user.getUserEmail(), user.getUserid(), user.getRole());

        List<String> permissions = getPermissionsForUser(user);

        return AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .userId(user.getUserid())
                .username(user.getUsername())
                .userEmail(user.getUserEmail())
                .role(user.getRole())
                .permissions(permissions)
                .build();
    }

    public void changePassword(Long userId, ChangePasswordRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        if (!passwordEncoder.matches(request.getOldPassword(), user.getPassword())) {
            throw new BadRequestException("Current password is incorrect");
        }
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new BadRequestException("New password and confirm password do not match");
        }
        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    public void forgotPassword(String email) {
        User user = userRepository.findByUserEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", email));

        String resetPassword = UUID.randomUUID().toString().substring(0, 8);
        user.setPassword(passwordEncoder.encode(resetPassword));
        userRepository.save(user);

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("CRM - Password Reset");
            message.setText("Your new password is: " + resetPassword + "\nPlease change it after login.");
            mailSender.send(message);
        } catch (Exception ignored) {
            // mail failure should not block the operation; user can contact admin
        }
    }

    private List<String> getPermissionsForUser(User user) {
        return roleRepository.findByRoleName(user.getRole())
                .map(role -> permissionRepository.findByRoleIdFk(role.getRoleId())
                        .stream().map(Permission::getGrpPerm).collect(Collectors.toList()))
                .orElse(List.of());
    }
}
