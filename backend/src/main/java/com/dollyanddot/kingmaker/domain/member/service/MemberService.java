package com.dollyanddot.kingmaker.domain.member.service;

import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.dto.NicknameDto;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    public void updateNickname(NicknameDto nicknameDto) {
        Member member
            = memberRepository.findById(nicknameDto.getMemberId()).orElseThrow();

        member.setNickname(nicknameDto.getNickname());
        memberRepository.save(member);
    }

}
