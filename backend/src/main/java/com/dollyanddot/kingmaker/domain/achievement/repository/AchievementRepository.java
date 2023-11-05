package com.dollyanddot.kingmaker.domain.achievement.repository;

import com.dollyanddot.kingmaker.domain.achievement.domain.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AchievementRepository extends JpaRepository<Achievement, Long> {
}
