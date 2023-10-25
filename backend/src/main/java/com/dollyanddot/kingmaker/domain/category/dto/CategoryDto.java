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

  public static CategoryDto from(Category category){
    return CategoryDto.builder()
        .categoryId(category.getId())
        .categoryNm(category.getName())
        .build();
  }
}
