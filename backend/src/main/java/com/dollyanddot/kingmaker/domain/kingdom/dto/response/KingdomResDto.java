package com.dollyanddot.kingmaker.domain.kingdom.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class KingdomResDto {

    private String kingdomNm;
    private int level;
    private int citizen;
}
