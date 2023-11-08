package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarStreakResDto;
import com.dollyanddot.kingmaker.domain.calendar.service.CalendarService;
import com.dollyanddot.kingmaker.domain.member.dto.response.RewardListResDto;
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
import com.dollyanddot.kingmaker.domain.todo.service.TodoService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/mypage")
public class MypageController {
    private final TodoService todoService;
    private final RewardService rewardService;
    private final CalendarService calendarService;

    @GetMapping("calendar/{memberId}")
    public EnvelopeResponse<List<CalendarStreakResDto>> getTodoCalendar(@PathVariable Long memberId, @RequestParam int year, @RequestParam int month){
        List<CalendarStreakResDto> list=todoService.getAchieveLevel(year,month,memberId);
        return EnvelopeResponse.<List<CalendarStreakResDto>>builder()
                .data(list)
                .build();
    }

    @GetMapping("/reward/{memberId}")
    public EnvelopeResponse<List<RewardListResDto>> getRewardList(@PathVariable long memberId) {
        return EnvelopeResponse.<List<RewardListResDto>>builder().data(rewardService.getRewardList(memberId)).build();
    }

    @GetMapping("/plan/{memberId}")
    public EnvelopeResponse<Long> getDailyMonsterCnt(@PathVariable Long memberId) {
        return EnvelopeResponse.<Long>builder().data(calendarService.getDailyMonsterCnt(memberId)).build();
    }

    @GetMapping("/daily/{memberId}")
    public EnvelopeResponse<Integer> getDailyPercent(@PathVariable Long memberId) {
        return EnvelopeResponse.<Integer>builder().data(calendarService.getDailyPercent(memberId)).build();
    }

    @GetMapping("/monthly/{memberId}")
    public EnvelopeResponse<Integer> getMonthlyPercent(@PathVariable Long memberId) {
        return EnvelopeResponse.<Integer>builder().data(calendarService.getMonthlyPercent(memberId)).build();
    }

    @GetMapping("/yearly/{memberId}")
    public EnvelopeResponse<Integer> getYearlyPercent(@PathVariable Long memberId) {
        return EnvelopeResponse.<Integer>builder().data(calendarService.getYearlyPercent(memberId)).build();
    }
}
