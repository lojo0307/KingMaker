package com.dollyanddot.kingmaker.domain.reward.repository;

import javax.transaction.Transactional;

public interface MemberRewardRepositoryCustom {
    @Transactional
    void achieveMemberReward(Long memberId,int rewardId);
}
