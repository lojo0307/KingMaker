package com.dollyanddot.kingmaker.domain.calendar.service;

import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarService {

    private final CalendarRepository calendarRepository;

    @Transactional(readOnly = true)
    public Long getDailyMonsterCnt(Long memberId) {
        return calendarRepository.getDailyMonsterCnt(memberId);
    }

    @Transactional(readOnly = true)
    public int getDailyPercent(Long memberId) {
        Long dailyCnt = calendarRepository.getDailyCnt(memberId);
        Long achievedCnt = calendarRepository.getDailyAchievedCnt(memberId);

        return makePercent(dailyCnt, achievedCnt);
    }

    @Transactional(readOnly = true)
    public int getMonthlyPercent(Long memberId) {
        Long monthlyCnt = calendarRepository.getMonthlyCnt(memberId);
        Long achievedCnt = calendarRepository.getMonthlyAchievedCnt(memberId);

        return makePercent(monthlyCnt, achievedCnt);
    }

    @Transactional(readOnly = true)
    public int getYearlyPercent(Long memberId) {
        Long yearlyCnt = calendarRepository.getYearlyCnt(memberId);
        Long achievedCnt = calendarRepository.getYearlyAchievedCnt(memberId);

        return makePercent(yearlyCnt, achievedCnt);
    }

    private Long nullTo0(Long num) {
        return num==null?0:num;
    }

    private int makePercent(Long cnt, Long achievedCnt) {
        cnt = nullTo0(cnt);
        achievedCnt = nullTo0(achievedCnt);

        log.info("전체: {}", cnt);
        log.info("달성: {}", achievedCnt);

        //전체 일정이 아무것도 없으면 -1 전달
        int percent = -1;

        //아무것도 안 했으면 0 전달
        if(cnt != 0) {
            percent = (int) (((double) achievedCnt / cnt)*100);
        }

        log.info("percent: {}", percent);
        return percent;
    }
}
