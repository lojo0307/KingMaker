package com.dollyanddot.kingmaker.domain.reward.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RewardInfoDto {

    private int rewardId;
    private String rewardNm;
    private String rewardCond;
    private String rewardMsg;

    public static RewardInfoDto from(int rewardId, String rewardNm, String rewardCond, String rewardMsg) {
        return new RewardInfoDto(rewardId, rewardNm, rewardCond, rewardMsg);
    }

}
