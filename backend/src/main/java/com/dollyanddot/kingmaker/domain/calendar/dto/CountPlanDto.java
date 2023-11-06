package com.dollyanddot.kingmaker.domain.calendar.dto;

import com.dollyanddot.kingmaker.domain.reward.dto.RewardResDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CountPlanDto {
    Long memberId;
    Long cnt;
}
