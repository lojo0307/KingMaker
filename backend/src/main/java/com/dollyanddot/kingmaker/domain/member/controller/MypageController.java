package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
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
    @GetMapping("calendar/{memberId}")
    public EnvelopeResponse<List<CalendarAchieveAndSumResDto>> getTodoCalendar(@PathVariable Long memberId, @RequestParam int year, @RequestParam int month){
        List<CalendarAchieveAndSumResDto> list=todoService.getAchieveAndSum(year,month,memberId);
        return EnvelopeResponse.<List<CalendarAchieveAndSumResDto>>builder()
                .data(list)
                .build();
    }
}
