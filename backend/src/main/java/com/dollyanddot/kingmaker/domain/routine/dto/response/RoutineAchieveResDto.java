package com.dollyanddot.kingmaker.domain.routine.dto.response;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;

public class RoutineAchieveResDto extends PatchRoutineResDto{
    public RoutineAchieveResDto(byte isAchieved, RewardResDto rewardResDto) {
        super(isAchieved, rewardResDto);
    }


}
