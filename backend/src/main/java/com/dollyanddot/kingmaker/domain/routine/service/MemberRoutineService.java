package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetDailyRoutinesResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MemberRoutineService {

  private final MemberRoutineRepository memberRoutineRepository;
  private final MemberRepository memberRepository;

  @Transactional
  public PatchRoutineResDto changeAchievedStatement(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();

    return PatchRoutineResDto.from(memberRoutine.toggleAchieved());
  }

  @Transactional(readOnly = true)
  public GetRoutineResDto getMemberRoutine(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();

    Routine routine = memberRoutine.getRoutine();

    return GetRoutineResDto.of(memberRoutine, routine);
  }

  @Transactional(readOnly = true)
  public GetDailyRoutinesResDto getDailyRoutines(Long memberId, String dateStr) {

    Member member = memberRepository.findById(memberId).orElseThrow();

    return GetMemberRoutinesByDate(member, dateStr);
  }

  private GetDailyRoutinesResDto GetMemberRoutinesByDate(Member member, String dateStr) {

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    LocalDateTime date = LocalDateTime.parse(dateStr, formatter);

    List<MemberRoutine> memberRoutines = memberRoutineRepository.findAllByMemberAndDate(
        member, date);

    return GetDailyRoutinesResDto.from(memberRoutines);
  }
}
