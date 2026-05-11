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
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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

    private static final DateTimeFormatter INDIAMART_DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd-MMM-yyyy", Locale.ENGLISH);

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
        if (doc  != null && !doc.isEmpty())  lead.setUploadDocument(fileUploadUtil.upload(doc));
        if (doc1 != null && !doc1.isEmpty()) lead.setUploadDocument1(fileUploadUtil.upload(doc1));
        if (doc2 != null && !doc2.isEmpty()) lead.setUploadDocument2(fileUploadUtil.upload(doc2));
        if (doc3 != null && !doc3.isEmpty()) lead.setUploadDocument3(fileUploadUtil.upload(doc3));
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
                .reminderDate(reminderDate != null ? java.time.LocalDateTime.parse(reminderDate.length() == 10 ? reminderDate + "T00:00:00" : reminderDate) : LocalDateTime.now())
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

    @Transactional
    @SuppressWarnings("unchecked")
    public List<Lead> importFromIndiamart(ImportLeadRequest request, Long userId) {
        validateImportRequest(request);

        try {
            String url = UriComponentsBuilder.fromHttpUrl(indiamartUrl)
                    .queryParam("glusr_crm_key", indiamartApiKey)
                    .queryParam("start_time", formatIndiamartDate(request.getFromDate()))
                    .queryParam("end_time", formatIndiamartDate(request.getToDate()))
                    .build()
                    .toUriString();

            Map<String, Object> response = webClient.get()
                    .uri(url)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            List<Map<String, Object>> data = extractIndiamartLeads(response);
            List<Lead> imported = new ArrayList<>();

            for (Map<String, Object> item : data) {
                String queryId = text(item, "UNIQUE_QUERY_ID");
                if (queryId.isBlank() || leadRepository.existsByUniqueQueryId(queryId)) {
                    continue;
                }

                Lead lead = Lead.builder()
                        .leadFirstName(text(item, "SENDER_NAME"))
                        .leadEmail(text(item, "SENDER_EMAIL"))
                        .leadMobileNo(text(item, "SENDER_MOBILE"))
                        .leadPhoneNo(text(item, "SENDER_PHONE"))
                        .leadOrganisationName(text(item, "SENDER_COMPANY"))
                        .leadAddress(text(item, "SENDER_ADDRESS"))
                        .leadCity(text(item, "SENDER_CITY"))
                        .leadState(text(item, "SENDER_STATE"))
                        .leadCountry(text(item, "SENDER_COUNTRY_ISO"))
                        .leadTitle(firstPresent(item, "SUBJECT", "QUERY_PRODUCT_NAME"))
                        .leadReason(text(item, "QUERY_MESSAGE"))
                        .uniqueQueryId(queryId)
                        .leadSource(AppConstants.INDIAMART_SOURCE)
                        .leadType(AppConstants.INDIAMART_DEFAULT_TYPE)
                        .leadStatus(AppConstants.INDIAMART_DEFAULT_STATUS)
                        .inquiryDate(parseInquiryDate(item))
                        .leadCreatedDate(LocalDateTime.now())
                        .userIdFk(userId)
                        .build();
                Lead saved = leadRepository.save(lead);
                refreshLeadScore(saved);
                imported.add(saved);
            }

            log.info("Imported {} new Indiamart lead(s) between {} and {}",
                    imported.size(), request.getFromDate(), request.getToDate());
            return imported;
        } catch (Exception e) {
            log.error("Indiamart import error", e);
            throw new BadRequestException("Failed to import leads from Indiamart: " + e.getMessage());
        }
    }

    private void validateImportRequest(ImportLeadRequest request) {
        if (request.getFromDate() == null || request.getToDate() == null) {
            throw new BadRequestException("Both From Date and To Date are required.");
        }
        if (request.getFromDate().isAfter(request.getToDate())) {
            throw new BadRequestException("From Date cannot be later than To Date.");
        }
        if (indiamartApiKey == null || indiamartApiKey.isBlank()) {
            throw new BadRequestException("Indiamart API key is not configured.");
        }
        if (indiamartUrl == null || indiamartUrl.isBlank()) {
            throw new BadRequestException("Indiamart API URL is not configured.");
        }
    }

    private String formatIndiamartDate(LocalDate date) {
        return INDIAMART_DATE_FORMAT.format(date).toUpperCase(Locale.ENGLISH);
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> extractIndiamartLeads(Map<String, Object> response) {
        if (response == null || response.isEmpty()) {
            return List.of();
        }

        Object code = response.get("CODE");
        if (code != null && !isSuccessfulCode(code)) {
            String message = firstPresent(response, "MESSAGE", "STATUS", "ERROR_MESSAGE");
            throw new BadRequestException(message.isBlank() ? "Indiamart returned error code " + code : message);
        }

        Object leads = response.get("RESPONSE");
        if (!(leads instanceof List)) {
            leads = response.get("DATA");
        }
        if (!(leads instanceof List<?> list)) {
            return List.of();
        }

        List<Map<String, Object>> parsed = new ArrayList<>();
        for (Object item : list) {
            if (item instanceof Map<?, ?> map) {
                parsed.add((Map<String, Object>) map);
            }
        }
        return parsed;
    }

    private String firstPresent(Map<String, Object> item, String... keys) {
        for (String key : keys) {
            String value = text(item, key);
            if (!value.isBlank()) {
                return value;
            }
        }
        return "";
    }

    private String text(Map<String, Object> item, String key) {
        Object value = item.get(key);
        return value == null ? "" : String.valueOf(value).trim();
    }

    private boolean isSuccessfulCode(Object code) {
        if (code instanceof Number number) {
            return number.intValue() == 200;
        }
        return "200".equals(String.valueOf(code).trim());
    }

    private LocalDate parseInquiryDate(Map<String, Object> item) {
        String value = firstPresent(item, "QUERY_TIME", "QUERY_DATE", "DATE_RE");
        if (value.isBlank()) {
            return LocalDate.now();
        }

        List<DateTimeFormatter> formats = List.of(
                caseInsensitiveFormatter("dd-MMM-yyyy"),
                caseInsensitiveFormatter("dd-MMM-yyyy HH:mm:ss"),
                DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss", Locale.ENGLISH),
                DateTimeFormatter.ISO_LOCAL_DATE
        );

        for (DateTimeFormatter formatter : formats) {
            try {
                if (formatter == DateTimeFormatter.ISO_LOCAL_DATE) {
                    return LocalDate.parse(value, formatter);
                }
                if (value.length() > 11) {
                    return LocalDateTime.parse(value, formatter).toLocalDate();
                }
                return LocalDate.parse(value, formatter);
            } catch (DateTimeParseException ignored) {
                // Try the next known IndiaMART date shape.
            }
        }
        return LocalDate.now();
    }

    private DateTimeFormatter caseInsensitiveFormatter(String pattern) {
        return new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern(pattern)
                .toFormatter(Locale.ENGLISH);
    }

    private void refreshLeadScore(Lead lead) {
        try {
            leadScoringService.scoreAndCache(lead.getLeadId());
        } catch (Exception e) {
            log.warn("Lead {} imported but score refresh failed: {}", lead.getLeadId(), e.getMessage());
        }
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
