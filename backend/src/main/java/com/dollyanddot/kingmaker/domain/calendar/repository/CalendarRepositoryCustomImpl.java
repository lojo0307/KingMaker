package com.dollyanddot.kingmaker.domain.calendar.repository;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static com.dollyanddot.kingmaker.domain.calendar.domain.QCalendar.calendar;

@RequiredArgsConstructor
public class CalendarRepositoryCustomImpl implements CalendarRepositoryCustom{
    private final JPAQueryFactory queryFactory;

    @Override
    public List<CalendarStreakResDto> getPlansByMonth(int year,int month, Long memberId){
        NumberExpression<Integer> levelCase = new CaseBuilder()
                .when(calendar.calendarId.count().eq(0L)).then(0)
                .when(calendar.calendarId.count().between(1L, 2L)).then(1)
                .when(calendar.calendarId.count().between(2L, 3L)).then(2)
                .when(calendar.calendarId.count().between(4L, 5L)).then(3)
                .when(calendar.calendarId.count().between(6L, 7L)).then(4)
                .otherwise(5); // 만약 어떤 조건도 만족하지 않는다면 기본값
        return queryFactory
                .select(Projections.fields(CalendarStreakResDto.class,
                        calendar.calendarDate.dayOfMonth().as("day"),
                        levelCase.as("level")))
                .from(calendar)
                .where(calendar.member.memberId.eq(memberId),calendar.calendarDate.month().eq(month),calendar.calendarDate.year().eq(year))
                .groupBy(calendar.calendarDate.dayOfMonth())
                .fetch();
    }
}
