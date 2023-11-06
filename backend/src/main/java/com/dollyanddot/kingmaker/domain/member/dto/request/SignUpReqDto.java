package com.dollyanddot.kingmaker.domain.member.dto.request;

import com.dollyanddot.kingmaker.domain.member.domain.Gender;
import lombok.Getter;

@Getter
public class SignUpReqDto {

    private String nickname;
    private String kingdomName;
    private Gender gender;
}
