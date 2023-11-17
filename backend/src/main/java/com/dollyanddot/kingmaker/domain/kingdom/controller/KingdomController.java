package com.dollyanddot.kingmaker.domain.kingdom.controller;

import com.dollyanddot.kingmaker.domain.kingdom.dto.response.KingdomResDto;
import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.member.dto.request.NicknameReqDto;
import com.dollyanddot.kingmaker.domain.member.service.MemberService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/mypage")
public class KingdomController {

    private final KingdomService kingdomService;
    private final MemberService memberService;

    @GetMapping("/kingdom/{memberId}")
    EnvelopeResponse<?> getKingdomDetail(@PathVariable Long memberId) {
        KingdomResDto kingdomDto = kingdomService.getKingdomDetail(memberId);
        return EnvelopeResponse.builder()
            .data(kingdomDto)
            .build();
    }

    //TODO: memberController로 옮기기
    @PatchMapping("/nickname")
    EnvelopeResponse<?> updateNickname(@RequestBody NicknameReqDto nicknameDto) {
        memberService.updateNickname(nicknameDto);
        return EnvelopeResponse.builder().build();
    }

}
