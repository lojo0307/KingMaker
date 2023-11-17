package com.dollyanddot.kingmaker.domain.member.repository;

import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

public interface FcmTokenRepository extends JpaRepository<FcmToken,Long> {
    Optional<List<FcmToken>> findFcmTokensByMember_MemberId(Long memberId);

    @Query(value="SELECT f.token FROM fcm_token f WHERE f.member_id=:memberId",nativeQuery = true)
    Optional<List<String>> findTokensByMemberId(Long memberId);

    Optional<FcmToken> findFcmTokenByToken(String token);

    @Modifying
    @Query("UPDATE fcm_token ft SET ft.member.memberId=:memberId WHERE ft.token=:token")
    void updateFcmTokenMember(Long memberId,String token);

    int deleteFcmTokensByToken(String token);
}
