package com.crm.controller;

import com.crm.dto.response.ApiResponse;
import com.crm.service.CalendarService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/api/calendar")
@RequiredArgsConstructor
public class CalendarController {

    private final CalendarService calendarService;

    @GetMapping
    public ResponseEntity<ApiResponse<Map<String, Object>>> getEvents(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        String dateStr = date != null ? date.toString() : LocalDate.now().toString();
        return ResponseEntity.ok(ApiResponse.success("Calendar events fetched",
                calendarService.getCalendarEvents(dateStr)));
    }

    @GetMapping("/{date}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getEventsByDate(@PathVariable String date) {
        return ResponseEntity.ok(ApiResponse.success("Calendar events fetched",
                calendarService.getCalendarEvents(date)));
    }
}
