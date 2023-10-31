package com.dollyanddot.kingmaker.domain.member.domain;

import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long memberId;

    @OneToOne
    @JoinColumn(name = "credential_id", nullable = false)
    private Credential credential;

    @OneToOne
    @JoinColumn(name = "kingdom_id", nullable = false)
    private Kingdom kingdom;

    @Column(nullable = false, length = 10)
    private String nickname;

    @Column(nullable = false)
    private Gender gender;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    public void update(String nickname) {
        this.nickname = nickname;
    }
}
