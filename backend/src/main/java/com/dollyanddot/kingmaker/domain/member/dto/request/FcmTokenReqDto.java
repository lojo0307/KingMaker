package com.dollyanddot.kingmaker.domain.member.dto.request;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FcmTokenReqDto {
    private Long memberId;
    private String token;
}
