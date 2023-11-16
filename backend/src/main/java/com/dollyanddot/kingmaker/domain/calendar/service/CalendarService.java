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
        log.info("메인페이지 - 미달성 몬스터 수 -------------------------------");
        Long monster = calendarRepository.getDailyMonsterCnt(memberId);
        log.info("일간: {}", monster);
        return monster;
    }

    @Transactional(readOnly = true)
    public int getDailyPercent(Long memberId) {
        log.info("마이페이지 - 몬스터 리포트1 -------------------------------");
        Long dailyCnt = calendarRepository.getDailyCnt(memberId);
        Long achievedCnt = calendarRepository.getDailyAchievedCnt(memberId);

        int percent = makePercent(dailyCnt, achievedCnt);
        log.info("일간: {}", percent);
        return percent;
    }

    @Transactional(readOnly = true)
    public int getMonthlyPercent(Long memberId) {
        log.info("마이페이지 - 몬스터 리포트1 -------------------------------");
        Long monthlyCnt = calendarRepository.getMonthlyCnt(memberId);
        Long achievedCnt = calendarRepository.getMonthlyAchievedCnt(memberId);

        int percent = makePercent(monthlyCnt, achievedCnt);
        log.info("월간: {}", percent);
        return percent;
    }

    @Transactional(readOnly = true)
    public int getYearlyPercent(Long memberId) {
        log.info("마이페이지 - 몬스터 리포트1 -------------------------------");
        Long yearlyCnt = calendarRepository.getYearlyCnt(memberId);
        Long achievedCnt = calendarRepository.getYearlyAchievedCnt(memberId);

        int percent = makePercent(yearlyCnt, achievedCnt);
        log.info("연간: {}", percent);
        return percent;
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
