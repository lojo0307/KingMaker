package com.dollyanddot.kingmaker.domain.member.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Data
@Entity(name="fcm_token")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FcmToken {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Long fcmTokenId;

    @ManyToOne(fetch=FetchType.LAZY)
    @OnDelete(action= OnDeleteAction.CASCADE)
    @JoinColumn(name="member_id",nullable=false)
    private Member member;
    
    //테이블 이름과 혼동될 것 같아 fcmToken->token으로 이름 바꿈
    @Column(name="token")
    String token;
}
