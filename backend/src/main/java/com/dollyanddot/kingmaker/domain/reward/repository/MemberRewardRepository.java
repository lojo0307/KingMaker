package com.dollyanddot.kingmaker.domain.reward.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRewardRepository extends JpaRepository<MemberReward,Long> {
    Optional<MemberReward> findByMemberAndReward(Member member, Reward reward);
}
