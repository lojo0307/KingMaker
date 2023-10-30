package com.dollyanddot.kingmaker.domain.kingdom.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KingdomDto {

    private String kingdomNm;
    private int level;
    private int citizen;
}
