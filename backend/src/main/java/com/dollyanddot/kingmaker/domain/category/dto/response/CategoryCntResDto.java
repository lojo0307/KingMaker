package com.dollyanddot.kingmaker.domain.category.dto.response;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryCntResDto {

    private Long categoryId;
    private Long cnt;
    private LocalDateTime modifiedAt;
}
