package com.crm.service;

import com.crm.dto.request.ImportLeadRequest;
import com.crm.dto.request.LeadRequest;
import com.crm.entity.Lead;
import com.crm.entity.LeadNote;
import com.crm.entity.LeadReminder;
import com.crm.entity.Opportunity;
import com.crm.exception.BadRequestException;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.LeadNoteRepository;
import com.crm.repository.LeadReminderRepository;
import com.crm.repository.LeadRepository;
import com.crm.repository.LeadScoreRepository;
import com.crm.repository.OpportunityRepository;
import com.crm.util.AppConstants;
import com.crm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClient;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.time.Instant;
import java.time.ZoneId;

@Slf4j
@Service
@RequiredArgsConstructor
public class LeadService {

    private final LeadRepository leadRepository;
    private final LeadNoteRepository leadNoteRepository;
    private final LeadReminderRepository leadReminderRepository;
    private final LeadScoreRepository leadScoreRepository;
    private final OpportunityRepository opportunityRepository;
    private final FileUploadUtil fileUploadUtil;
    private final WebClient webClient;
    private final LeadScoringService leadScoringService;

    @Value("${app.indiamart.api-key}")
    private String indiamartApiKey;

    @Value("${app.indiamart.url}")
    private String indiamartUrl;

    public List<Lead> getAllLeads(Long userId, String role) {
        if ("admin".equalsIgnoreCase(role)) {
            return leadRepository.findAll();
        }
        return leadRepository.findByUserIdFk(userId);
    }

    public Lead getLeadById(Long id) {
        return leadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Lead", "id", id));
    }

    public Lead createLead(LeadRequest request, Long userId,
            MultipartFile doc, MultipartFile doc1,
            MultipartFile doc2, MultipartFile doc3) throws IOException {
        Lead lead = mapToEntity(request, new Lead());
        lead.setUserIdFk(userId);
        lead.setLeadCreatedDate(LocalDateTime.now());
        lead.setUploadDocument(fileUploadUtil.upload(doc));
        lead.setUploadDocument1(fileUploadUtil.upload(doc1));
        lead.setUploadDocument2(fileUploadUtil.upload(doc2));
        lead.setUploadDocument3(fileUploadUtil.upload(doc3));
        Lead saved = leadRepository.save(lead);
        leadScoringService.scoreAndCache(saved.getLeadId());
        return saved;
    }

    public Lead updateLead(Long id, LeadRequest request, Long userId,
            MultipartFile doc, MultipartFile doc1,
            MultipartFile doc2, MultipartFile doc3) throws IOException {
        Lead lead = getLeadById(id);
        mapToEntity(request, lead);
        if (doc != null && !doc.isEmpty())
            lead.setUploadDocument(fileUploadUtil.upload(doc));
        if (doc1 != null && !doc1.isEmpty())
            lead.setUploadDocument1(fileUploadUtil.upload(doc1));
        if (doc2 != null && !doc2.isEmpty())
            lead.setUploadDocument2(fileUploadUtil.upload(doc2));
        if (doc3 != null && !doc3.isEmpty())
            lead.setUploadDocument3(fileUploadUtil.upload(doc3));
        Lead saved = leadRepository.save(lead);
        leadScoringService.scoreAndCache(saved.getLeadId());
        return saved;
    }

    @Transactional
    public void deleteLead(Long id) {
        Lead lead = getLeadById(id);
        leadNoteRepository.deleteByLeadIdFk(id);
        leadReminderRepository.deleteByLeadIdFk(id);
        leadScoreRepository.deleteByLeadIdFk(id);
        opportunityRepository.deleteByLeadIdFk(id);
        leadRepository.delete(lead);
    }

    public Lead updateLeadStatus(Long id, String status) {
        Lead lead = getLeadById(id);
        lead.setLeadStatus(status);
        Lead saved = leadRepository.save(lead);
        leadScoringService.scoreAndCache(saved.getLeadId());
        return saved;
    }

    public List<Lead> getLeadsByStatus(String status, Long userId, String role) {
        if ("admin".equalsIgnoreCase(role)) {
            return leadRepository.findByLeadStatus(status);
        }
        return leadRepository.findByUserIdFkAndLeadStatus(userId, status);
    }

    public List<LeadNote> getNotes(Long leadId) {
        getLeadById(leadId);
        return leadNoteRepository.findByLeadIdFkOrderByNoteDateDesc(leadId);
    }

    public LeadNote addNote(Long leadId, String noteText, Long userId) {
        getLeadById(leadId);
        LeadNote note = LeadNote.builder()
                .leadIdFk(leadId)
                .noteText(noteText)
                .noteDate(LocalDateTime.now())
                .userIdFk(userId)
                .build();
        return leadNoteRepository.save(note);
    }

    public List<LeadReminder> getReminders(Long leadId) {
        getLeadById(leadId);
        return leadReminderRepository.findByLeadIdFkOrderByReminderDate(leadId);
    }

    public LeadReminder addReminder(Long leadId, String reminderText, String reminderDate, Long userId) {
        getLeadById(leadId);
        LeadReminder reminder = LeadReminder.builder()
                .leadIdFk(leadId)
                .reminderText(reminderText)
                .reminderDate(reminderDate != null ? parseReminderDate(reminderDate) : LocalDateTime.now())
                .userIdFk(userId)
                .build();
        return leadReminderRepository.save(reminder);
    }

    public Opportunity convertToOpportunity(Long leadId, Long userId) {
        Lead lead = getLeadById(leadId);
        if (AppConstants.LEAD_STATUS_CONVERTED.equals(lead.getLeadStatus())) {
            throw new BadRequestException("Lead is already converted");
        }
        lead.setLeadStatus(AppConstants.LEAD_STATUS_CONVERTED);
        leadRepository.save(lead);

        Opportunity opp = Opportunity.builder()
                .oppName(lead.getLeadFirstName() + " " + lead.getLeadLastName())
                .oppTitle(lead.getLeadTitle())
                .oppStatus(AppConstants.OPP_STATUS_OPEN)
                .leadIdFk(leadId)
                .userIdFk(userId)
                .build();
        return opportunityRepository.save(opp);
    }

    @SuppressWarnings("unchecked")
    public List<Lead> importFromIndiamart(ImportLeadRequest request, Long userId) {
        List<Lead> imported = new ArrayList<>();
        try {
            String url = indiamartUrl + "?glusr_crm_key=" + indiamartApiKey
                    + "&start_time=" + request.getFromDate()
                    + "&end_time=" + request.getToDate();

            Map<String, Object> response = webClient.get()
                    .uri(url)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            if (response == null)
                return imported;

            Object dataObj = response.get("DATA");
            if (!(dataObj instanceof List))
                return imported;
            List<Map<String, Object>> data = (List<Map<String, Object>>) dataObj;

            for (Map<String, Object> item : data) {
                String queryId = String.valueOf(item.getOrDefault("UNIQUE_QUERY_ID", ""));
                if (leadRepository.existsByUniqueQueryId(queryId))
                    continue;

                Lead lead = Lead.builder()
                        .leadFirstName(String.valueOf(item.getOrDefault("SENDER_NAME", "")))
                        .leadEmail(String.valueOf(item.getOrDefault("SENDER_EMAIL", "")))
                        .leadMobileNo(String.valueOf(item.getOrDefault("SENDER_MOBILE", "")))
                        .leadOrganisationName(String.valueOf(item.getOrDefault("SENDER_COMPANY", "")))
                        .leadAddress(String.valueOf(item.getOrDefault("SENDER_ADDRESS", "")))
                        .leadCity(String.valueOf(item.getOrDefault("SENDER_CITY", "")))
                        .leadState(String.valueOf(item.getOrDefault("SENDER_STATE", "")))
                        .uniqueQueryId(queryId)
                        .leadSource(AppConstants.INDIAMART_SOURCE)
                        .leadType(AppConstants.INDIAMART_DEFAULT_TYPE)
                        .leadStatus(AppConstants.INDIAMART_DEFAULT_STATUS)
                        .inquiryDate(LocalDate.now())
                        .leadCreatedDate(LocalDateTime.now())
                        .userIdFk(userId)
                        .build();
                Lead saved = leadRepository.save(lead);
                leadScoringService.scoreAndCache(saved.getLeadId());
                imported.add(saved);
            }
        } catch (Exception e) {
            log.error("Indiamart import error: {}", e.getMessage());
            throw new BadRequestException("Failed to import leads from Indiamart: " + e.getMessage());
        }
        return imported;
    }

    private LocalDateTime parseReminderDate(String raw) {
        if (raw == null)
            return LocalDateTime.now();
        String s = raw.trim();
        // Handle date-only (yyyy-MM-dd)
        if (s.length() == 10)
            return LocalDateTime.parse(s + "T00:00:00");
        return LocalDateTime.parse(s);
    }

    private Lead mapToEntity(LeadRequest req, Lead lead) {
        lead.setLeadFirstName(req.getLeadFirstName());
        lead.setLeadLastName(req.getLeadLastName());
        lead.setLeadTitle(req.getLeadTitle());
        lead.setLeadAddress(req.getLeadAddress());
        lead.setLeadCity(req.getLeadCity());
        lead.setLeadState(req.getLeadState());
        lead.setLeadCountry(req.getLeadCountry());
        lead.setLeadMobileNo(req.getLeadMobileNo());
        lead.setLeadPhoneNo(req.getLeadPhoneNo());
        lead.setLeadEmail(req.getLeadEmail());
        lead.setLeadOrganisationName(req.getLeadOrganisationName());
        lead.setLeadWebsite(req.getLeadWebsite());
        lead.setLeadIndustry(req.getLeadIndustry());
        lead.setNoOfEmployee(req.getNoOfEmployee());
        lead.setLeadStatus(req.getLeadStatus());
        lead.setLeadSource(req.getLeadSource());
        lead.setLeadType(req.getLeadType());
        lead.setLeadReason(req.getLeadReason());
        lead.setDesignation(req.getDesignation());
        lead.setInquiryDate(req.getInquiryDate());
        return lead;
    }
}
