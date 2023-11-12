package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.member.dto.request.NotificationFirstSettingReqDto;
import com.dollyanddot.kingmaker.domain.member.dto.request.SignUpReqDto;
import com.dollyanddot.kingmaker.domain.auth.dto.LoginResDto;
import com.dollyanddot.kingmaker.domain.member.dto.response.SignUpResDto;
import com.dollyanddot.kingmaker.domain.member.service.MemberService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/signup")
                public EnvelopeResponse<SignUpResDto> signup(Authentication authentication, @RequestBody SignUpReqDto signUpReqDto) {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        long credentialId = Long.parseLong(userDetails.getUsername());

        SignUpResDto signUpResDto = memberService.signUp(credentialId, signUpReqDto);

        return EnvelopeResponse.<SignUpResDto>builder().data(signUpResDto).build();
    }

    @DeleteMapping("/leave")
    public EnvelopeResponse<Void> withdraw(Authentication authentication) {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        long credentialId = Long.parseLong(userDetails.getUsername());
        memberService.withDraw(credentialId);
        return EnvelopeResponse.<Void>builder().build();
    }

    @PostMapping("notification/setting")
    public EnvelopeResponse<Void> notificationFirstSetting(@RequestBody NotificationFirstSettingReqDto req){
        memberService.notificationFirstSetting(req.getMemberId(),req.getSetting());
        return EnvelopeResponse.<Void>builder()
                .build();
    }

    @GetMapping("/check")
    public EnvelopeResponse<Void> check() {
        return EnvelopeResponse.<Void>builder().build();
    }

}
