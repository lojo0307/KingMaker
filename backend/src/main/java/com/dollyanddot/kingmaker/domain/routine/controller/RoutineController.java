package com.dollyanddot.kingmaker.domain.routine.controller;

import com.dollyanddot.kingmaker.domain.routine.dto.request.DeleteRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.request.PutRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.service.RoutineService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/routine")
@RequiredArgsConstructor
public class RoutineController{

  private final RoutineService routineService;

  @PostMapping()
  public EnvelopeResponse<Void> registerRoutine (@RequestBody PostRoutineReqDto postRoutineReqDto){
    return EnvelopeResponse.<Void>builder()
        .data(routineService.registerRoutine(postRoutineReqDto))
        .build();
  }

  @PutMapping()
  public EnvelopeResponse<Void> editRoutine(@RequestBody PutRoutineReqDto putRoutineReqDto){
    return EnvelopeResponse.<Void>builder()
        .data(routineService.editRoutine(putRoutineReqDto))
        .build();
  }

  @DeleteMapping()
  public EnvelopeResponse<Void> deleteRoutine(@RequestBody DeleteRoutineReqDto deleteRoutineReqDto){
    return EnvelopeResponse.<Void>builder()
        .data(routineService.deleteRoutine(deleteRoutineReqDto))
        .build();
  }
}
