package com.dollyanddot.kingmaker.domain.routine.repository;

import java.time.LocalDateTime;

public interface RoutineRepositoryCustom {
    LocalDateTime findMostRecentAchieved();
}
