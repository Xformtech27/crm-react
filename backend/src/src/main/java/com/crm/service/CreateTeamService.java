package com.crm.service;

import com.crm.dto.request.CreateTeamRequest;
import com.crm.entity.CreateTeam;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.CreateTeamRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CreateTeamService {

    private final CreateTeamRepository createTeamRepository;

    public List<CreateTeam> getAll() {
        return createTeamRepository.findAll();
    }

    public List<CreateTeam> getByTeamId(Long teamId) {
        return createTeamRepository.findByTeamIdFk(teamId);
    }

    public CreateTeam getById(Long id) {
        return createTeamRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("CreateTeam", "id", id));
    }

    public CreateTeam create(CreateTeamRequest req) {
        CreateTeam ct = CreateTeam.builder()
                .teamIdFk(req.getTeamIdFk())
                .teamMemberIdFk(req.getTeamMemberIdFk())
                .roleIdFk(req.getRoleIdFk())
                .build();
        return createTeamRepository.save(ct);
    }

    public CreateTeam update(Long id, CreateTeamRequest req) {
        CreateTeam ct = getById(id);
        ct.setTeamIdFk(req.getTeamIdFk());
        ct.setTeamMemberIdFk(req.getTeamMemberIdFk());
        ct.setRoleIdFk(req.getRoleIdFk());
        return createTeamRepository.save(ct);
    }

    public void delete(Long id) {
        createTeamRepository.delete(getById(id));
    }
}
