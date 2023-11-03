package com.dollyanddot.kingmaker.domain.auth.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Credential {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long credentialId;

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column
    private String email;

    @Column
    @Enumerated(EnumType.STRING)
    private Role role;

    @Column
    @Enumerated(EnumType.STRING)
    private Provider provider;

    public void updateRefreshToken(String updateRefreshToken) {
        this.refreshToken = updateRefreshToken;
    }
}
