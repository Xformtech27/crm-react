package com.crm.dto.request;

import lombok.*;
import java.time.LocalDate;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class LeadRequest {
    private String leadFirstName;
    private String leadLastName;
    private String leadTitle;
    private String leadMobileNo;
    private String leadPhoneNo;
    private String leadAddress;
    private String leadEmail;
    private String leadCity;
    private String leadState;
    private String leadCountry;
    private String leadOrganisationName;
    private String leadWebsite;
    private String leadIndustry;
    private Integer noOfEmployee;
    private String leadSource;
    private String leadType;
    private String leadReason;
    private String leadStatus;
    private String designation;
    private LocalDate inquiryDate;
    private Long userIdFk;
}
