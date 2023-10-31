package com.dollyanddot.kingmaker.domain.member.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class NicknameDto {

    private Long memberId;
    private String nickname;
}
