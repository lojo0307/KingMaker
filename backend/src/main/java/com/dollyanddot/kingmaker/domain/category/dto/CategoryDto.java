package com.dollyanddot.kingmaker.domain.category.dto;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class CategoryDto {

  private Long categoryId;
  private String categoryNm;
  private String type;

  public static CategoryDto from(Category category, String type){
    return CategoryDto.builder()
        .categoryId(category.getId())
        .categoryNm(category.getName())
        .type(type)
        .build();
  }
}
