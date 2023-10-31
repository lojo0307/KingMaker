package com.dollyanddot.kingmaker.domain.member.service;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.dto.NicknameDto;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional
    public void updateNickname(NicknameDto nicknameDto) {
        Member member
            = memberRepository.findById(nicknameDto.getMemberId()).orElseThrow();

        member.update(nicknameDto.getNickname());
    }

}
