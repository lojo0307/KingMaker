package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoutineRepository extends JpaRepository<Routine, Long> {

}
