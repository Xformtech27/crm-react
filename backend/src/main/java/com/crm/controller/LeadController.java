package com.crm.controller;

import com.crm.dto.request.ImportLeadRequest;
import com.crm.dto.request.LeadRequest;
import com.crm.dto.response.ApiResponse;
import com.crm.entity.Lead;
import com.crm.entity.LeadNote;
import com.crm.entity.LeadReminder;
import com.crm.entity.Opportunity;
import com.crm.entity.User;
import com.crm.service.LeadService;
import com.crm.util.AuthUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/leads")
@RequiredArgsConstructor
public class LeadController {

    private final LeadService leadService;
    private final AuthUtil authUtil;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Lead>>> getAllLeads(Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Leads fetched", leadService.getAllLeads(user.getUserid(), user.getRole())));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Lead>> getLeadById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Lead fetched", leadService.getLeadById(id)));
    }

    @GetMapping("/status/{status}")
    public ResponseEntity<ApiResponse<List<Lead>>> getLeadsByStatus(@PathVariable String status, Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Leads fetched", leadService.getLeadsByStatus(status, user.getUserid(), user.getRole())));
    }

    @PostMapping(consumes = {"multipart/form-data"})
    public ResponseEntity<ApiResponse<Lead>> createLead(
            @Valid @RequestPart("lead") LeadRequest request,
            @RequestPart(value = "uploadDocument",  required = false) MultipartFile doc,
            @RequestPart(value = "uploadDocument1", required = false) MultipartFile doc1,
            @RequestPart(value = "uploadDocument2", required = false) MultipartFile doc2,
            @RequestPart(value = "uploadDocument3", required = false) MultipartFile doc3,
            Authentication auth) throws IOException {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Lead created", leadService.createLead(request, user.getUserid(), doc, doc1, doc2, doc3)));
    }

    @PutMapping(value = "/{id}", consumes = {"multipart/form-data"})
    public ResponseEntity<ApiResponse<Lead>> updateLead(
            @PathVariable Long id,
            @Valid @RequestPart("lead") LeadRequest request,
            @RequestPart(value = "uploadDocument",  required = false) MultipartFile doc,
            @RequestPart(value = "uploadDocument1", required = false) MultipartFile doc1,
            @RequestPart(value = "uploadDocument2", required = false) MultipartFile doc2,
            @RequestPart(value = "uploadDocument3", required = false) MultipartFile doc3,
            Authentication auth) throws IOException {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Lead updated", leadService.updateLead(id, request, user.getUserid(), doc, doc1, doc2, doc3)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteLead(@PathVariable Long id) {
        leadService.deleteLead(id);
        return ResponseEntity.ok(ApiResponse.success("Lead deleted", null));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<ApiResponse<Lead>> updateStatus(@PathVariable Long id, @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(ApiResponse.success("Status updated", leadService.updateLeadStatus(id, body.get("status"))));
    }

    @GetMapping("/{id}/notes")
    public ResponseEntity<ApiResponse<List<LeadNote>>> getNotes(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Notes fetched", leadService.getNotes(id)));
    }

    @PostMapping("/{id}/notes")
    public ResponseEntity<ApiResponse<LeadNote>> addNote(@PathVariable Long id, @RequestBody Map<String, String> body, Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Note added", leadService.addNote(id, body.get("noteText"), user.getUserid())));
    }

    @GetMapping("/{id}/reminders")
    public ResponseEntity<ApiResponse<List<LeadReminder>>> getReminders(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.success("Reminders fetched", leadService.getReminders(id)));
    }

    @PostMapping("/{id}/reminders")
    public ResponseEntity<ApiResponse<LeadReminder>> addReminder(@PathVariable Long id, @RequestBody Map<String, String> body, Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Reminder added",
                leadService.addReminder(id, body.get("reminderText"), body.get("reminderDate"), user.getUserid())));
    }

    @PostMapping("/{id}/convert")
    public ResponseEntity<ApiResponse<Opportunity>> convertToOpportunity(@PathVariable Long id, Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Lead converted to opportunity", leadService.convertToOpportunity(id, user.getUserid())));
    }

    @PostMapping({"/import", "/import/indiamart"})
    public ResponseEntity<ApiResponse<List<Lead>>> importFromIndiamart(@Valid @RequestBody ImportLeadRequest request, Authentication auth) {
        User user = authUtil.getCurrentUser(auth);
        return ResponseEntity.ok(ApiResponse.success("Leads imported from Indiamart", leadService.importFromIndiamart(request, user.getUserid())));
    }
}
