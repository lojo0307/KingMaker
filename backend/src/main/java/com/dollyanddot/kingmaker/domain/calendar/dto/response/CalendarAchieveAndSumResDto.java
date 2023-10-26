package com.dollyanddot.kingmaker.domain.calendar.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CalendarAchieveAndSumResDto {
    int day;
    int achieve;
    int sum;
}
