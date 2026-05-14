package com.crm.service;

import com.crm.dto.response.DashboardResponse;
import com.crm.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final LeadRepository leadRepository;
    private final OpportunityRepository opportunityRepository;
    private final ProjectRepository projectRepository;

    public DashboardResponse getDashboardStats() {
        Map<String, Long> leadStatusMap = buildStatusMap(leadRepository.countGroupByStatus());
        Map<String, Long> oppStatusMap  = buildStatusMap(opportunityRepository.countGroupByStatus());
        Map<String, Long> projStatusMap = buildStatusMap(projectRepository.countGroupByStatus());
        Map<String, Long> leadSourceMap = buildStatusMap(leadRepository.countGroupBySource());

        List<Map<String, Object>> leadChartData = buildChartList(leadStatusMap);
        List<Map<String, Object>> oppChartData  = buildChartList(oppStatusMap);
        List<Map<String, Object>> sourceChartData = buildChartList(leadSourceMap);

        return DashboardResponse.builder()
                .leadAll(leadRepository.count())
                .leadNotContacted(leadStatusMap.getOrDefault("NotContacted", 0L))
                .leadContacted(leadStatusMap.getOrDefault("Contacted", 0L))
                .leadQualified(leadStatusMap.getOrDefault("Qualified Lead", 0L))
                .leadWorking(leadStatusMap.getOrDefault("Working", 0L))
                .leadQuotationSent(leadStatusMap.getOrDefault("QuotationSent", 0L))
                .leadNegotiation(leadStatusMap.getOrDefault("Negotiation", 0L))
                .leadConverted(leadStatusMap.getOrDefault("Converted", 0L))
                .opportunityWon(oppStatusMap.getOrDefault("Won", 0L))
                .opportunityLost(oppStatusMap.getOrDefault("Lost", 0L))
                .opportunityOpen(oppStatusMap.getOrDefault("Open", 0L))
                .leadOpen(leadStatusMap.values().stream().mapToLong(Long::longValue).sum())
                .projectCount(projectRepository.count())
                .leadSourceWiseCount(sourceChartData)
                .projectStatusWiseCount(buildChartList(projStatusMap))
                .opportunityStatusWiseCount(oppChartData)
                .statusWiseLeadByMonth(leadChartData)
                .build();
    }

    private Map<String, Long> buildStatusMap(List<Object[]> rows) {
        Map<String, Long> map = new LinkedHashMap<>();
        for (Object[] row : rows) {
            String key = row[0] != null ? row[0].toString() : "Unknown";
            Long val  = ((Number) row[1]).longValue();
            map.put(key, val);
        }
        return map;
    }

    private List<Map<String, Object>> buildChartList(Map<String, Long> map) {
        List<Map<String, Object>> list = new ArrayList<>();
        map.forEach((k, v) -> {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("label", k);
            item.put("count", v);
            list.add(item);
        });
        return list;
    }
}
