package com.dollyanddot.kingmaker.domain.member.controller;

import com.dollyanddot.kingmaker.domain.member.dto.request.NotificationFirstSettingReqDto;
import com.dollyanddot.kingmaker.domain.member.dto.request.SignUpReqDto;
import com.dollyanddot.kingmaker.domain.member.dto.response.LoginResDto;
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
    public ResponseEntity<LoginResDto> signup(Authentication authentication, @RequestBody SignUpReqDto signUpReqDto) {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        long credentialId = Long.parseLong(userDetails.getUsername());

        LoginResDto loginResDto = memberService.signUp(credentialId, signUpReqDto);

        return ResponseEntity.ok().body(loginResDto);
    }

    @DeleteMapping("/leave/{memberId}")
    public ResponseEntity<Void> withdraw(@PathVariable long memberId) {
        memberService.withDraw(memberId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("notification/setting")
    public EnvelopeResponse<Void> notificationFirstSetting(@RequestBody NotificationFirstSettingReqDto req){
        memberService.notificationFirstSetting(req.getMemberId(),req.getSetting());
        return EnvelopeResponse.<Void>builder()
                .build();
    }
}
