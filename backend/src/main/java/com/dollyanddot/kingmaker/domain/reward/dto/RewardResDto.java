package com.dollyanddot.kingmaker.domain.reward.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RewardResDto {

    private int isRewardAchieved; // 달성시 1
    private RewardInfoDto rewardInfoDto;

    public static RewardResDto from(int isRewardAchieved, RewardInfoDto rewardInfoDto) {
        return new RewardResDto(isRewardAchieved, rewardInfoDto);
    }

}
