package com.dollyanddot.kingmaker.domain.member.repository;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findMemberByMemberId(Long memberId);
}
