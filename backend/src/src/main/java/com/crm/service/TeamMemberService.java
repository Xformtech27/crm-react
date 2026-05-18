package com.crm.service;

import com.crm.dto.request.TeamMemberRequest;
import com.crm.entity.TeamMember;
import com.crm.entity.User;
import com.crm.exception.BadRequestException;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.TeamMemberRepository;
import com.crm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TeamMemberService {

    private final TeamMemberRepository teamMemberRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public List<TeamMember> getAllTeamMembers(Long userId, String role) {
        if ("admin".equalsIgnoreCase(role)) return teamMemberRepository.findAll();
        return teamMemberRepository.findByUserIdFk(userId);
    }

    public TeamMember getById(Long id) {
        return teamMemberRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("TeamMember", "id", id));
    }

    @Transactional
    public TeamMember create(TeamMemberRequest req, Long managerId) {
        if (userRepository.existsByUserEmail(req.getTeamMemberEmail())) {
            throw new BadRequestException("Email is already registered: " + req.getTeamMemberEmail());
        }

        // Also create a User account so the team member can login
        User user = User.builder()
                .username(req.getTeamMemberEmail())
                .userEmail(req.getTeamMemberEmail())
                .password(passwordEncoder.encode(req.getPassword()))
                .role(req.getTeamMemberRole() != null ? req.getTeamMemberRole().toString() : "member")
                .createdDate(LocalDate.now())
                .build();
        userRepository.save(user);

        TeamMember member = TeamMember.builder()
                .teamMemberName(req.getTeamMemberName())
                .teamMemberRole(req.getTeamMemberRole())
                .teamMemberMobile(req.getTeamMemberMobile())
                .teamMemberEmail(req.getTeamMemberEmail())
                .userIdFk(managerId)
                .build();
        return teamMemberRepository.save(member);
    }

    public TeamMember update(Long id, TeamMemberRequest req) {
        TeamMember member = getById(id);
        member.setTeamMemberName(req.getTeamMemberName());
        member.setTeamMemberRole(req.getTeamMemberRole());
        member.setTeamMemberMobile(req.getTeamMemberMobile());
        member.setTeamMemberEmail(req.getTeamMemberEmail());
        return teamMemberRepository.save(member);
    }

    public void delete(Long id) {
        teamMemberRepository.delete(getById(id));
    }
}
