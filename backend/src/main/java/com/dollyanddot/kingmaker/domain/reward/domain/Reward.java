package com.dollyanddot.kingmaker.domain.reward.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import org.hibernate.annotations.ColumnDefault;

@Getter
@NoArgsConstructor
@Entity
public class Reward {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int rewardId;

    @Column(nullable = false)
    private String rewardNm;

    @Column(nullable = false)
    private String rewardWay;

    @Column(nullable = false)
    private String rewardMsg;

}
