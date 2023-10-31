package com.dollyanddot.kingmaker.domain.member.repository;

import com.dollyanddot.kingmaker.domain.member.domain.FcmToken;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FcmTokenRepository extends JpaRepository<FcmToken,Long> {
    Optional<List<FcmToken>> findFcmTokensByMember_MemberId(Long memberId);
}
