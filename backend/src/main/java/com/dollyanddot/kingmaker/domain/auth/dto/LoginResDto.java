package com.dollyanddot.kingmaker.domain.auth.dto;

import com.dollyanddot.kingmaker.domain.member.domain.Gender;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
public class LoginResDto {
    private long memberId;
    private long kingdomId;
    private String nickname;
    private Gender gender;
    private LocalDateTime createdAt;
}
