package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.calendar.dto.response.CalendarAchieveAndSumResDto;
import com.dollyanddot.kingmaker.domain.member.dto.request.NotificationFirstSettingReqDto;
import com.dollyanddot.kingmaker.domain.member.service.MemberService;
import com.dollyanddot.kingmaker.domain.notification.dto.request.NotificationSettingReqDto;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberController {

    private final MemberService memberService;

    @PostMapping("notification/setting")
    public EnvelopeResponse<Void> notificationFirstSetting(@RequestBody NotificationFirstSettingReqDto req){
        memberService.notificationFirstSetting(req.getMemberId(),req.getSetting());
        return EnvelopeResponse.<Void>builder()
                .build();
    }
}
