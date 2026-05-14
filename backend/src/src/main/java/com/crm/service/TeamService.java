package com.crm.service;

import com.crm.dto.request.TeamRequest;
import com.crm.entity.Team;
import com.crm.exception.BadRequestException;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.TeamRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TeamService {

    private final TeamRepository teamRepository;

    public List<Team> getAllTeams() {
        return teamRepository.findAll();
    }

    public Team getById(Long id) {
        return teamRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Team", "id", id));
    }

    public Team create(TeamRequest req) {
        if (teamRepository.existsByTeamName(req.getTeamName())) {
            throw new BadRequestException("Team with name '" + req.getTeamName() + "' already exists");
        }
        return teamRepository.save(Team.builder().teamName(req.getTeamName()).build());
    }

    public Team update(Long id, TeamRequest req) {
        Team team = getById(id);
        team.setTeamName(req.getTeamName());
        return teamRepository.save(team);
    }

    public void delete(Long id) {
        teamRepository.delete(getById(id));
    }
}
