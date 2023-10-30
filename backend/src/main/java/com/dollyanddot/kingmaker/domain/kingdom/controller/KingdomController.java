package com.dollyanddot.kingmaker.domain.kingdom.controller;

import com.dollyanddot.kingmaker.domain.kingdom.dto.KingdomDto;
import com.dollyanddot.kingmaker.domain.kingdom.service.KingdomService;
import com.dollyanddot.kingmaker.domain.notification.dto.NotificationSettingDto;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/mypage")
public class KingdomController {

    private final KingdomService kingdomService;

    @GetMapping("/kingdom/{memberId}")
    EnvelopeResponse<?> getKingdomDetail(@PathVariable Long memberId) {
        KingdomDto kingdomDto = kingdomService.getKingdomDetail(memberId);
        return EnvelopeResponse.builder()
            .data(kingdomDto)
            .build();
    }

    //TODO: notificationController로 옮기기
    @GetMapping("/notification/{memberId}")
    EnvelopeResponse<?> getNotificationSetting(@PathVariable Long memberId) {
        List<NotificationSettingDto> notificationSettingDtoList
            = kingdomService.getNotificationSetting(memberId);
        return EnvelopeResponse.builder()
            .data(notificationSettingDtoList)
            .build();
    }
}
