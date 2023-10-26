package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface MemberRoutineRepository extends JpaRepository<MemberRoutine, Long> {

  @Query(value = "SELECT mr "
      + "FROM member_routine mr "
      + "WHERE mr.member = :member "
      + "AND date_format(mr.createdAt, '%Y-%M-%d') = date_format(:date, '%Y-%M-%d') ")
  List<MemberRoutine> findAllByMemberAndDate(Member member, LocalDateTime date);
}
