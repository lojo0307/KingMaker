package com.dollyanddot.kingmaker.domain.routine.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
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

//  @Query(value = "SELECT mr "
//      + "FROM member_routine mr "
//      + "WHERE mr.routine = :routine "
//      + "ORDER BY mr.createdAt DESC "
//      + "LIMIT 1")
  MemberRoutine findMemberRoutineTop1ByRoutineOrderByCreatedAtDesc(Routine routine);

  @Query(value = "DELETE FROM member_routine "
      + "WHERE routine = :routine "
      + "AND date_format(createdAt, '%Y-%M-%d') >= date_format(:today, '%Y-%M-%d')")
  void deleteAllByRoutineAfterToday(Routine routine, LocalDateTime today);

  @Query(value="SELECT member_routine.routine.category.id "
          +"FROM member_routine "
          +"WHERE member_routine.member.memberId=:memberId "
          +"AND member_routine.achievedYn=true "
          +"GROUP BY member_routine.routine.category.id "
          +"ORDER BY routine.category.id ASC")
  List<Long> countCategoryId(Long memberId);
}
