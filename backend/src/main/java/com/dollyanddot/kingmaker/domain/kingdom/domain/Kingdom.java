package com.dollyanddot.kingmaker.domain.kingdom.domain;

import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Kingdom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long kingdomId;
    private int level;
    private String kingdomNm;
    private int citizen;

    @Builder
    public Kingdom(Long kingdomId, int level, String kingdomNm, int citizen) {
        this.kingdomId = kingdomId;
        this.level = level;
        this.kingdomNm = kingdomNm;
        this.citizen = citizen;
    }

    public void update(int citizen, int level) {
        this.citizen = citizen;
        this.level = level;
    }

    public void updateName(String kingdomNm) {
        this.kingdomNm = kingdomNm;
    }
}
