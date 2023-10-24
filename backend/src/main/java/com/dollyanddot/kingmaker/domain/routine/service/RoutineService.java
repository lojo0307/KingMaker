package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.domain.RoutineRegistraion;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRegistrationRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RoutineService {

  private final RoutineRepository routineRepository;
  private final CategoryRepository categoryRepository;
  private final MemberRepository memberRepository;
  private final RoutineRegistrationRepository routineRegistrationRepository;
  private final MemberRoutineRepository memberRoutineRepository;

  @Transactional(readOnly = true)
  public Void registerRoutine(PostRoutineReqDto postRoutineReqDto){

    Category category = categoryRepository.findById(postRoutineReqDto.getCategoryId()).orElseThrow();
    Member member = memberRepository.findById(postRoutineReqDto.getMemberId()).orElseThrow();
    LocalDateTime time = LocalDateTime.now();

    Routine routine = routineRepository.save(new Routine().builder()
        .routineName(postRoutineReqDto.getRoutineNm())
        .category(category)
        .detail(postRoutineReqDto.getRoutineDetail())
        .build());

    RoutineRegistraion routineRegistraion = routineRegistrationRepository.save(new RoutineRegistraion().builder()
        .member(member)
        .routine(routine)
        .period(postRoutineReqDto.getPeriod())
        .importantYn(postRoutineReqDto.isImportantYn())
        .startAt(postRoutineReqDto.getStartAt())
        .endAt(postRoutineReqDto.getEndAt())
        .build());

    if(routineRegistraion.getStartAt().isBefore(time) && routineRegistraion.getEndAt().isAfter(time)){
      MemberRoutine memberRoutine = memberRoutineRepository.save(new MemberRoutine().builder()
          .routineRegistraion(routineRegistraion)
          .monsterCd(1)
          .build());
    }

    return null;
  }
}
