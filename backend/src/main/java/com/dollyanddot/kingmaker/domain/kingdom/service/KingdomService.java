package com.dollyanddot.kingmaker.domain.kingdom.service;

import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import com.dollyanddot.kingmaker.domain.kingdom.dto.response.KingdomResDto;
import com.dollyanddot.kingmaker.domain.kingdom.exception.KingdomNotFoundException;
import com.dollyanddot.kingmaker.domain.kingdom.repository.KingdomRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.exception.MemberNotFoundException;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationSettingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KingdomService {

    private final KingdomRepository kingdomRepository;
    private final MemberRepository memberRepository;
    private final NotificationSettingRepository notificationSettingRepository;

    public KingdomResDto getKingdomDetail(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow(
            () -> new MemberNotFoundException());
        Long kingdomId = member.getKingdom().getKingdomId();
        Kingdom kingdom = kingdomRepository.findById(kingdomId).orElseThrow(
            () -> new KingdomNotFoundException());

        return KingdomResDto.builder()
            .kingdomNm(kingdom.getKingdomNm())
            .level(kingdom.getLevel())
            .citizen(kingdom.getCitizen())
            .build();
    }

    public int changeCitizen(Long memberId, String sign) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            () -> new MemberNotFoundException());
        Long kingdomId = member.getKingdom().getKingdomId();
        Kingdom kingdom = kingdomRepository.findById(kingdomId).orElseThrow(
            () -> new KingdomNotFoundException());

        int changeCitizen = kingdom.getCitizen();
        if(sign.equals("plus")) {
            changeCitizen += 10;
        } else if(sign.equals("minus")) {
            changeCitizen -= 10;
        }

        int changeLevel = changeLevel(changeCitizen);
        kingdom.update(changeCitizen, changeLevel);
        return changeLevel;
    }

    private int changeLevel(int citizen) {
        if (citizen < 1000) return 1;
        if (citizen < 3000) return 2;
        if (citizen < 5000) return 3;
        if (citizen < 10000) return 4;
        if (citizen < 20000) return 5;
        if (citizen < 30000) return 6;
        if (citizen < 50000) return 7;
        if (citizen < 100000) return 8;
        return 9;
    }

    public int levelReward(int level) {
        int rewardId = 0;
        switch (level) {
            case 3: rewardId = 5;
                break;
            case 6: rewardId = 6;
                break;
            case 9: rewardId = 7;
                break;
        }
        return rewardId;
    }

}
