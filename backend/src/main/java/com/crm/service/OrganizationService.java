package com.crm.service;

import com.crm.dto.request.OrganizationRequest;
import com.crm.entity.Organization;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.OrganizationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrganizationService {

    private final OrganizationRepository organizationRepository;

    public List<Organization> getAllOrganizations(Long userId, String role) {
        return organizationRepository.findAll();
    }

    public Organization getById(Long id) {
        return organizationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", "id", id));
    }

    public Organization create(OrganizationRequest req, Long userId) {
        return organizationRepository.save(mapToEntity(req, new Organization()));
    }

    public Organization update(Long id, OrganizationRequest req) {
        Organization org = getById(id);
        return organizationRepository.save(mapToEntity(req, org));
    }

    public void delete(Long id) {
        organizationRepository.delete(getById(id));
    }

    private Organization mapToEntity(OrganizationRequest req, Organization org) {
        org.setOrganizationName(req.getOrganizationName());
        org.setOrganizationMoblieNo(req.getOrganizationMoblieNo());
        org.setOrganizationEmail(req.getOrganizationEmail());
        org.setOrganizationAddress(req.getOrganizationAddress());
        org.setOrganizationCity(req.getOrganizationCity());
        org.setOrganizationState(req.getOrganizationState());
        org.setOrganizationCountry(req.getOrganizationCountry());
        org.setOrganizationBackground(req.getOrganizationBackground());
        org.setOrganizationOccasion(req.getOrganizationOccasion());
        org.setOrganizationPostcode(req.getOrganizationPostcode());
        org.setOrganizationOccasionDate(req.getOrganizationOccasionDate());
        return org;
    }
}
