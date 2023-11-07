package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
import com.dollyanddot.kingmaker.domain.member.dto.response.RewardListResDto;
import com.dollyanddot.kingmaker.domain.reward.service.RewardService;
import com.dollyanddot.kingmaker.domain.todo.service.TodoService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/mypage")
public class MypageController {
    private final TodoService todoService;
    private final RewardService rewardService;

    @GetMapping("calendar/{memberId}")
    public EnvelopeResponse<List<CalendarAchieveAndSumResDto>> getTodoCalendar(@PathVariable Long memberId, @RequestParam int year, @RequestParam int month){
        List<CalendarAchieveAndSumResDto> list=todoService.getAchieveAndSum(year,month,memberId);
        return EnvelopeResponse.<List<CalendarAchieveAndSumResDto>>builder()
                .data(list)
                .build();
    }

    @GetMapping("/reward/{memberId}")
    public ResponseEntity<List<RewardListResDto>> getRewardList(@PathVariable long memberId) {
        return ResponseEntity.ok().body(rewardService.getRewardList(memberId));
    }
}
