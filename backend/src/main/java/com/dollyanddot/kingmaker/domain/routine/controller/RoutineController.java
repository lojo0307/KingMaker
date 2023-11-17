package com.dollyanddot.kingmaker.domain.routine.controller;

import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PutRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetDailyRoutinesResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.GetRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PatchRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PostRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.service.MemberRoutineService;
import com.dollyanddot.kingmaker.domain.routine.service.RoutineService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/routine")
@RequiredArgsConstructor
public class RoutineController {

  private final RoutineService routineService;
  private final MemberRoutineService memberRoutineService;

  @PostMapping()
  public EnvelopeResponse<PostRoutineResDto> registerRoutine(@RequestBody PostRoutineReqDto postRoutineReqDto)
      throws ParseException {
    return EnvelopeResponse.<PostRoutineResDto>builder()
        .data(routineService.registerRoutine(postRoutineReqDto))
        .build();
  }

  @PutMapping()
  public EnvelopeResponse<Void> editRoutine(@RequestBody PutRoutineReqDto putRoutineReqDto)
      throws ParseException {
    return EnvelopeResponse.<Void>builder()
        .data(routineService.editRoutine(putRoutineReqDto))
        .build();
  }

  @DeleteMapping("/{routineId}")
  public EnvelopeResponse<Void> deleteRoutine(@PathVariable Long routineId) {
    return EnvelopeResponse.<Void>builder()
        .data(routineService.deleteRoutine(routineId))
        .build();
  }

  @PatchMapping("/{memberRoutineId}")
  public EnvelopeResponse<PatchRoutineResDto> toggleAchieved(@PathVariable Long memberRoutineId) {
    return EnvelopeResponse.<PatchRoutineResDto>builder()
        .data(memberRoutineService.changeAchievedStatement(memberRoutineId))
        .build();
  }

  @GetMapping("/detail/{memberRoutineId}")
  public EnvelopeResponse<GetRoutineResDto> getRoutineDetail(@PathVariable Long memberRoutineId){
    return EnvelopeResponse.<GetRoutineResDto>builder()
        .data(memberRoutineService.getMemberRoutine(memberRoutineId))
        .build();
  }

  @GetMapping("/{memberId}")
  public EnvelopeResponse<GetDailyRoutinesResDto> getDailyRoutines(@PathVariable Long memberId, @RequestParam String date){
    return EnvelopeResponse.<GetDailyRoutinesResDto>builder()
        .data(memberRoutineService.getDailyRoutines(memberId, date))
        .build();
  }
}
