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
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class RoutineService {

  private final RoutineRepository routineRepository;
  private final CategoryRepository categoryRepository;
  private final MemberRepository memberRepository;
  private final MemberRoutineRepository memberRoutineRepository;

  @Transactional
  public Void registerRoutine(PostRoutineReqDto postRoutineReqDto) throws ParseException {

    Category category = categoryRepository.findById(postRoutineReqDto.getCategoryId())
        .orElseThrow();
    Member member = memberRepository.findById(postRoutineReqDto.getMemberId()).orElseThrow();
    LocalDateTime today = LocalDateTime.now();

    JSONParser jsonParser = new JSONParser();
    JSONObject jsonObject = (JSONObject) jsonParser.parse(postRoutineReqDto.getPeriod());

    String type = (String) jsonObject.get("type");
    Object obj = jsonObject.get("value");
    int value = 0;
    boolean isToday = false;
    if (type.equals("day")) {
      boolean[] days = (boolean[]) obj;
      for (int i = today.getDayOfWeek().getValue(); i < days.length; i++) {
        if (days[i % days.length] && today.getDayOfWeek().getValue() == i) {
          isToday = true;
          continue;
        }
        if (days[i % days.length]) {
          value = i;
          break;
        }
        if (i == days.length) {
          i = 0;
        }
      }
    } else {
      value = (int) obj;
    }

    Routine routine = routineRepository.save(new Routine().builder()
        .category(category)
        .member(member)
        .name(postRoutineReqDto.getRoutineNm())
        .detail(postRoutineReqDto.getRoutineDetail())
        .period(postRoutineReqDto.getPeriod())
        .importantYn(postRoutineReqDto.isImportantYn())
        .startAt(postRoutineReqDto.getStartAt())
        .endAt(postRoutineReqDto.getEndAt())
        .registerAt(type.equals("day") ? null
            : type.equals("num") ? today.plusDays(value) : today.plusMonths(value))
        .registerDay(type.equals("day") ? value : null)
        .build());

    if ((routine.getStartAt().isBefore(today) && routine.getEndAt().isAfter(today)) &&
        (!type.equals("day") || (type.equals("day") && isToday))) {
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
  public Void editRoutine(PutRoutineReqDto putRoutineReqDto) throws ParseException {

    Routine routine = routineRepository.findById(putRoutineReqDto.getRoutineId()).orElseThrow();
    LocalDateTime today = LocalDateTime.now();

    routine.update(categoryRepository.findById(putRoutineReqDto.getCategoryId()).orElseThrow(),
        routine.getMember(), putRoutineReqDto.getRoutineNm(), putRoutineReqDto.getRoutineDetail(),
        putRoutineReqDto.getPeriod(), putRoutineReqDto.isImportantYn(),
        putRoutineReqDto.getStartAt(), putRoutineReqDto.getEndAt());

    JSONParser jsonParser = new JSONParser();

    JSONObject jsonObject = (JSONObject) jsonParser.parse(routine.getPeriod());
    String type = (String) jsonObject.get("type");
    if (type.equals("day")) {
      JSONArray dayArr = (JSONArray) jsonObject.get("value");

      for (int i = today.getDayOfWeek().getValue() + 1; i <= dayArr.size(); i++) {
        if ((boolean) dayArr.get(i % dayArr.size())) {
          routine.updateRegisterDay(i);
          break;
        }
        if (i == dayArr.size()) {
          i = 0;
        }
      }

    } else {
      MemberRoutine latestMemberRoutine =
          memberRoutineRepository.findMemberRoutineTop1ByRoutineOrderByCreatedAtDesc(routine);

      routine.updateRegisterAt(type.equals("num") ?
          latestMemberRoutine.getCreatedAt().plusDays((Long) jsonObject.get("value"))
          : latestMemberRoutine.getCreatedAt().plusMonths((Long) jsonObject.get("value")));
    }

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
