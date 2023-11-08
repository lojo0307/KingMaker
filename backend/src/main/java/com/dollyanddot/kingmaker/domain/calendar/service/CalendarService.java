package com.dollyanddot.kingmaker.domain.calendar.service;

import com.dollyanddot.kingmaker.domain.calendar.repository.CalendarRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CalendarService {

    private final CalendarRepository calendarRepository;

    @Transactional(readOnly = true)
    public Long getDailyMonsterCnt(Long memberId) {
        return calendarRepository.getDailyMonsterCnt(memberId);
    }

}
