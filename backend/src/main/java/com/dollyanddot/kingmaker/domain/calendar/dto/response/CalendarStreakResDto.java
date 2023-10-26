package com.dollyanddot.kingmaker.domain.calendar.dto.response;

import com.querydsl.core.types.dsl.NumberExpression;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CalendarStreakResDto {
    int day;
    int level;
}
