package com.crm.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "xformsales_lead")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Lead {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lead_id")
    private Long leadId;

    @Column(name = "lead_first_name")
    private String leadFirstName;

    @Column(name = "lead_last_name")
    private String leadLastName;

    @Column(name = "lead_title")
    private String leadTitle;

    @Column(name = "lead_address")
    private String leadAddress;

    @Column(name = "lead_city")
    private String leadCity;

    @Column(name = "lead_state")
    private String leadState;

    @Column(name = "lead_country")
    private String leadCountry;

    @Column(name = "lead_mobile_no")
    private String leadMobileNo;

    @Column(name = "lead_phone_no")
    private String leadPhoneNo;

    @Column(name = "lead_email")
    private String leadEmail;

    @Column(name = "lead_organisation_name")
    private String leadOrganisationName;

    @Column(name = "lead_website")
    private String leadWebsite;

    @Column(name = "lead_industry")
    private String leadIndustry;

    @Column(name = "lead_created_date")
    private LocalDateTime leadCreatedDate;

    @Column(name = "no_of_employee")
    private Integer noOfEmployee;

    @Column(name = "lead_status")
    private String leadStatus;

    @Column(name = "lead_source")
    private String leadSource;

    @Column(name = "user_id_fk")
    private Long userIdFk;

    @Column(name = "upload_document", columnDefinition = "TEXT")
    private String uploadDocument;

    @Column(name = "upload_document1", columnDefinition = "TEXT")
    private String uploadDocument1;

    @Column(name = "upload_document2", columnDefinition = "TEXT")
    private String uploadDocument2;

    @Column(name = "upload_document3", columnDefinition = "TEXT")
    private String uploadDocument3;

    @Column(name = "lead_type")
    private String leadType;

    @Column(name = "lead_reason")
    private String leadReason;

    @Column(name = "designation")
    private String designation;

    @Column(name = "inquiry_date")
    private LocalDate inquiryDate;

    @Column(name = "unique_query_id")
    private String uniqueQueryId;
}
