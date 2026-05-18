package com.crm.util;

public final class AppConstants {
    private AppConstants() {}

    // Lead statuses
    public static final String LEAD_STATUS_NOT_CONTACTED = "NotContacted";
    public static final String LEAD_STATUS_CONTACTED     = "Contacted";
    public static final String LEAD_STATUS_QUALIFIED     = "Qualified Lead";
    public static final String LEAD_STATUS_WORKING       = "Working";
    public static final String LEAD_STATUS_QUOTATION     = "QuotationSent";
    public static final String LEAD_STATUS_NEGOTIATION   = "Negotiation";
    public static final String LEAD_STATUS_CONVERTED     = "Converted";

    // Opportunity statuses
    public static final String OPP_STATUS_WON  = "Won";
    public static final String OPP_STATUS_LOST = "Lost";
    public static final String OPP_STATUS_OPEN = "Open";

    // Admin user ID
    public static final long ADMIN_USER_ID = 1L;

    // Indiamart
    public static final String INDIAMART_SOURCE = "Indiamart";
    public static final String INDIAMART_DEFAULT_TYPE = "Hot";
    public static final String INDIAMART_DEFAULT_STATUS = "Contacted";
}
