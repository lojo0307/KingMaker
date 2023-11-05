package com.dollyanddot.kingmaker.domain.achievement.domain;

import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class Achievement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int achievementId;

    @Column(nullable = false)
    private String achievementNm;

    @Column(nullable = false)
    private String achievementWay;

    @Column(nullable = false)
    private String achievementMsg;

}
