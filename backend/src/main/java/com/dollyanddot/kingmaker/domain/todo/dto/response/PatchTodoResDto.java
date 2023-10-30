package com.dollyanddot.kingmaker.domain.todo.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PatchTodoResDto {

  private boolean isAchieved;

  public static PatchTodoResDto from(boolean isAchieved){
    return new PatchTodoResDto(isAchieved);
  }
}
