package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PutRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
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
  private final MemberRoutineRepository memberRoutineRepository;

  @Transactional
  public Void registerRoutine(PostRoutineReqDto postRoutineReqDto) {

    Category category = categoryRepository.findById(postRoutineReqDto.getCategoryId())
        .orElseThrow();
    Member member = memberRepository.findById(postRoutineReqDto.getMemberId()).orElseThrow();
    LocalDateTime time = LocalDateTime.now();

    Routine routine = routineRepository.save(new Routine().builder()
        .category(category)
        .member(member)
        .name(postRoutineReqDto.getRoutineNm())
        .detail(postRoutineReqDto.getRoutineDetail())
        .period(postRoutineReqDto.getPeriod())
        .importantYn(postRoutineReqDto.isImportantYn())
        .startAt(postRoutineReqDto.getStartAt())
        .endAt(postRoutineReqDto.getEndAt())
        .build());

    if (routine.getStartAt().isBefore(time) && routine.getEndAt().isAfter(time)) {
      memberRoutineRepository.save(new MemberRoutine().builder()
          .member(member)
          .routine(routine)
          .achievedYn(false)
          .monsterCd(1)
          .build());
    }

    return null;
  }

  @Transactional
  public Void editRoutine(PutRoutineReqDto putRoutineReqDto) {

    Routine routine = routineRepository.findById(putRoutineReqDto.getRoutineId()).orElseThrow();

    routine.update(categoryRepository.findById(putRoutineReqDto.getCategoryId()).orElseThrow(),
        routine.getMember(), putRoutineReqDto.getRoutineNm(), putRoutineReqDto.getRoutineDetail(),
        putRoutineReqDto.getPeriod(), putRoutineReqDto.isImportantYn(),
        putRoutineReqDto.getStartAt(), putRoutineReqDto.getEndAt());

    return null;
  }

  @Transactional
  public Void deleteRoutine(Long routineId) {

    Routine routine =
        routineRepository.findById(routineId)
            .orElseThrow();

    routineRepository.delete(routine);

    return null;
  }
}
