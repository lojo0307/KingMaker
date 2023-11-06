package com.dollyanddot.kingmaker.domain.routine.service;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.reward.domain.MemberReward;
import com.dollyanddot.kingmaker.domain.reward.domain.Reward;
import com.dollyanddot.kingmaker.domain.reward.repository.MemberRewardRepository;
import com.dollyanddot.kingmaker.domain.reward.repository.RewardRepository;
import com.dollyanddot.kingmaker.domain.routine.domain.MemberRoutine;
import com.dollyanddot.kingmaker.domain.routine.domain.Routine;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PutRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.exception.RoutineNotFoundException;
import com.dollyanddot.kingmaker.domain.routine.repository.MemberRoutineRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import java.time.LocalDateTime;
import java.util.List;
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
  private final RewardRepository rewardRepository;
  private final MemberRewardRepository memberRewardRepository;

  @Transactional
  public Void registerRoutine(PostRoutineReqDto postRoutineReqDto) throws ParseException {

    Category category = categoryRepository.findById(postRoutineReqDto.getCategoryId())
        .orElseThrow();
    Member member = memberRepository.findById(postRoutineReqDto.getMemberId()).orElseThrow(
        MemberNotFoundException::new);
    LocalDateTime today = LocalDateTime.now();

    JSONParser jsonParser = new JSONParser();
    JSONObject jsonObject = (JSONObject) jsonParser.parse(postRoutineReqDto.getPeriod());

    String type = (String) jsonObject.get("type");
    Object obj = jsonObject.get("value");

    int value = today.getDayOfWeek().getValue();
    boolean isToday = false;

    if (type.equals("day")) {
      JSONArray days = (JSONArray) obj;
      for (int i = today.getDayOfWeek().getValue(); i <= days.size() + 1; i++) {
        if (i > days.size()) {
          i = 1;
        }
        if ((boolean) days.get(i % days.size()) && today.getDayOfWeek().getValue() == i
            && !isToday) {
          isToday = true;
          continue;
        }
        if ((boolean) days.get(i % days.size())) {
          value = i;
          break;
        }
      }
    } else {
      value = Integer.parseInt(obj.toString());
    }

    LocalDateTime startDate =
        (postRoutineReqDto.getStartAt().isBefore(today) && postRoutineReqDto.getEndAt()
            .isAfter(today)) ? type.equals("num") ? today.plusDays(value) : today.plusMonths(value)
            : postRoutineReqDto.getStartAt();

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
            : startDate)
        .registerDay(type.equals("day") ? value : null)
        .build());

    if ((routine.getStartAt().isBefore(today) && routine.getEndAt().isAfter(today)) &&
        (!type.equals("day") || (type.equals("day") && isToday))) {
      memberRoutineRepository.save(new MemberRoutine().builder()
          .member(member)
          .routine(routine)
          .achievedYn(false)
          .build());
    }

    Reward reward = rewardRepository.findById(12).orElseThrow();
    MemberReward memberReward = memberRewardRepository.findByMemberAndReward(member, reward);
    if (memberReward == null) {
      List<Routine> routines = routineRepository.findAllByMember(member);
      if (routines.size() >= 20) {
        memberRewardRepository.save(MemberReward.builder().member(member).reward(reward).build());
      }
    }
    // responseDto 추가해서 해야 함... 루틴 20개 이상 되면 업적 달성하는 로직은 추가했으나 프론트에 반환하기 위한 ResponseDto가 없습니다.
    // 혹시라도 제가 없는 동안 하실 생각이라면 그부분을 하시면 됩니다.
    return null;
  }

  @Transactional
  public Void editRoutine(PutRoutineReqDto putRoutineReqDto) throws ParseException {

    Routine routine = routineRepository.findById(putRoutineReqDto.getRoutineId()).orElseThrow(
        RoutineNotFoundException::new);
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

      if (latestMemberRoutine != null) {
        routine.updateRegisterAt(type.equals("num") ?
            latestMemberRoutine.getCreatedAt().plusDays((Long) jsonObject.get("value"))
            : latestMemberRoutine.getCreatedAt().plusMonths((Long) jsonObject.get("value")));
      } else {
        routine.updateRegisterAt(routine.getStartAt());
      }
    }

    return null;
  }

  @Transactional
  public Void deleteRoutine(Long routineId) {

    Routine routine =
        routineRepository.findById(routineId)
            .orElseThrow(RoutineNotFoundException::new);

    routineRepository.delete(routine);

    return null;
  }
}
