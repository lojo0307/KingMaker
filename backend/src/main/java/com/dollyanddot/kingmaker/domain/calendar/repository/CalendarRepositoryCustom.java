package com.dollyanddot.kingmaker.domain.calendar.repository;

import com.dollyanddot.kingmaker.domain.calendar.dto.CountPlanDto;
import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;

import java.util.List;

public interface CalendarRepositoryCustom{
    //연월을 입력하면, 해당 월의 모든 날짜에 대해 todo+memberRoutine 개수를 반환
    public List<CalendarStreakResDto> getPlansByMonth(int year,int month, Long memberId);

    List<CountPlanDto> getTodayPlan();

    List<CountPlanDto> getUndonePlan();

    List<Long> getMonthlyPlanExistCheck(int year, int month);

    List<Long> getUndonePlanByMonth(int year,int month);

    Long getUndonePlanCntFromYesterday();
}
