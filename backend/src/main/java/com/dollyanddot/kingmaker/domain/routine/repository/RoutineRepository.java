package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RoutineRepository extends JpaRepository<Routine, Long> {

  @Query(value = "SELECT r "
      + "FROM routine r "
      + "WHERE r.startAt >= :today "
      + "AND (date_format(r.registerAt, '%Y-%M-%d') = date_format(:today, '%Y-%M-%d') "
      + "OR r.registerDay = :day)")
  List<Routine> findAllByRegisterDateOrDay(LocalDateTime today, int day);
}
