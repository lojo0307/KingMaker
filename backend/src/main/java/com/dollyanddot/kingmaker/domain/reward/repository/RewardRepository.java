package com.dollyanddot.kingmaker.domain.reward.repository;

import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RewardRepository extends JpaRepository<Reward, Long> {
}
