package com.dollyanddot.kingmaker.domain.kingdom.service;

import com.dollyanddot.kingmaker.domain.kingdom.domain.Kingdom;
import com.dollyanddot.kingmaker.domain.kingdom.dto.KingdomDto;
import com.dollyanddot.kingmaker.domain.kingdom.repository.KingdomRepository;
import com.dollyanddot.kingmaker.domain.member.domain.Member;
import com.dollyanddot.kingmaker.domain.member.repository.MemberRepository;
import com.dollyanddot.kingmaker.domain.notification.domain.NotificationSetting;
import com.dollyanddot.kingmaker.domain.notification.dto.NotificationSettingDto;
import com.dollyanddot.kingmaker.domain.notification.repository.NotificationSettingRepository;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KingdomService {

    private final KingdomRepository kingdomRepository;
    private final MemberRepository memberRepository;
    private final NotificationSettingRepository notificationSettingRepository;

    //TODO: 예외 발생 시 메시지

    public KingdomDto getKingdomDetail(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow();
        Long kingdomId = member.getKingdom().getKingdomId();
        Kingdom kingdom = kingdomRepository.findById(kingdomId).orElseThrow();

        return KingdomDto.builder()
            .kingdomNm(kingdom.getKingdomNm())
            .level(kingdom.getLevel())
            .citizen(kingdom.getCitizen())
            .build();
    }

    //TODO: notificationService로 옮기기
    public List<NotificationSettingDto> getNotificationSetting(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow();
        List<NotificationSetting> notificationDtoList
            = notificationSettingRepository.findNotificationSettingsByMember(member);

        return notificationDtoList.stream()
            .map(n -> NotificationSettingDto.builder()
            .notificationTypeId(n.getNotificationSettingId())
            .activatedYn((byte) (n.isActivatedYn() ? 1 : 0))
            .build())
            .collect(Collectors.toList());
    }
}
