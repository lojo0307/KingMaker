package com.dollyanddot.kingmaker.domain.member.domain;

import com.dollyanddot.kingmaker.domain.auth.domain.Credential;
import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import com.dollyanddot.kingmaker.global.common.BaseTimeEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import lombok.experimental.SuperBuilder;

@Getter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Member extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long memberId;

    @OneToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "credential_id", nullable = false)
    private Credential credential;

    @OneToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "kingdom_id", nullable = false)
    private Kingdom kingdom;

    @Column(nullable = false, length = 10)
    private String nickname;

    @Column(nullable = false)
    private Gender gender;

    public void update(String nickname) {
        this.nickname = nickname;
    }
}
