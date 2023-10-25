package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MemberRoutineService {

  private final MemberRoutineRepository memberRoutineRepository;

  @Transactional
  public PatchRoutineResDto changeAchievedStatement(Long memberRoutineId) {

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();

    return PatchRoutineResDto.from(memberRoutine.toggleAchieved());
  }

  @Transactional(readOnly = true)
  public GetRoutineResDto getMemberRoutine(Long memberRoutineId){

    MemberRoutine memberRoutine = memberRoutineRepository.findById(memberRoutineId).orElseThrow();

    Routine routine = memberRoutine.getRoutine();

    return GetRoutineResDto.of(memberRoutine, routine);
  }
}
