package com.dollyanddot.kingmaker.domain.calendar.repository;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;
import java.util.List;

import static com.dollyanddot.kingmaker.domain.calendar.domain.QCalendar.calendar;
import static com.dollyanddot.kingmaker.domain.routine.domain.QMemberRoutine.memberRoutine;
import static com.dollyanddot.kingmaker.domain.todo.domain.QTodo.todo;

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

    @Override
    public List<CountPlanDto> getTodayPlan() {
        return queryFactory
                .select(Projections.fields(CountPlanDto.class,
                        calendar.member.memberId,
                        calendar.calendarId.count().as("cnt")))
                .from(calendar)
                .where(calendar.calendarDate.eq(LocalDate.now()))
                .groupBy(calendar.member.memberId)
                .fetch();
    }

    @Override
    public List<CountPlanDto> getUndonePlan(){
        return queryFactory
                .select(Projections.fields(CountPlanDto.class,
                        calendar.member.memberId,
                        calendar.calendarId.count().as("cnt")
                        ))
                .from(calendar)
                .leftJoin(calendar.todo, todo)
                .leftJoin(calendar.memberRoutine, memberRoutine)
                .where(calendar.calendarDate.eq(LocalDate.now())
                        .and(
                                (calendar.todo.isNotNull().and(calendar.todo.achievedYn.isFalse()))
                                .or
                                        (calendar.memberRoutine.isNotNull().and(calendar.memberRoutine.achievedYn.isFalse()))))
                .groupBy(calendar.member.memberId)
                .fetch();
    }
}
