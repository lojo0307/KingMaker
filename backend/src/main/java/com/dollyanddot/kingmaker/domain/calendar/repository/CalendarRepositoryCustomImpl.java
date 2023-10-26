package com.dollyanddot.kingmaker.domain.calendar.repository;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static com.dollyanddot.kingmaker.domain.calendar.domain.QCalendar.calendar;

@RequiredArgsConstructor
public class CalendarRepositoryCustomImpl implements CalendarRepositoryCustom{
    private final JPAQueryFactory queryFactory;

    @Override
    public List<CalendarStreakResDto> getMonthlyPlans(int year,int month, Long memberId){
        return queryFactory
                .select(Projections.fields(CalendarStreakResDto.class,
                        calendar.calendarDate.dayOfMonth().as("day"),
                        calendar.calendarId.count().castToNum(Integer.class).as("level")))
                .from(calendar)
                .where(calendar.member.memberId.eq(memberId),calendar.calendarDate.month().eq(month),calendar.calendarDate.year().eq(year))
                .groupBy(calendar.calendarDate.dayOfMonth())
                .fetch();
    }
}
