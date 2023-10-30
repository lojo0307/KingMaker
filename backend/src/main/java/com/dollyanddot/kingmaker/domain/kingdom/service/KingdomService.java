package com.dollyanddot.kingmaker.domain.kingdom.service;

import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import com.dollyanddot.kingmaker.domain.kingdom.dto.KingdomDto;
import com.dollyanddot.kingmaker.domain.kingdom.repository.KingdomRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KingdomService {

    private final KingdomRepository kingdomRepository;
    private final MemberRepository memberRepository;

    public KingdomDto getKingdomDetail(Long memberId) {
        //TODO: 예외 발생 시 메시지
        Member member = memberRepository.findById(memberId).orElseThrow();
        Long kingdomId = member.getKingdom().getKingdomId();
        Kingdom kingdom = kingdomRepository.findById(kingdomId).orElseThrow();

        return KingdomDto.builder()
            .kingdomNm(kingdom.getKingdomNm())
            .level(kingdom.getLevel())
            .citizen(kingdom.getCitizen())
            .build();
    }

}
