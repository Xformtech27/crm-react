package com.crm.dto.request;

import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ImportLeadRequest {
    private LocalDate fromDate;
    private LocalDate toDate;
}
