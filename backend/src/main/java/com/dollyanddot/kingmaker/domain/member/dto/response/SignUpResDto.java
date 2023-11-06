package com.dollyanddot.kingmaker.domain.member.dto.response;

import com.dollyanddot.kingmaker.domain.auth.domain.Provider;
import com.dollyanddot.kingmaker.domain.member.domain.Gender;
import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class SignUpResDto {
    private long memberId;
    private String nickname;
    private Gender gender;
    private String email;
    private Provider provider;
    private RewardResDto rewardResDto;
}
