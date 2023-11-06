package com.dollyanddot.kingmaker.domain.reward.repository;

import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRewardRepository extends JpaRepository<MemberReward,Long> {
}
