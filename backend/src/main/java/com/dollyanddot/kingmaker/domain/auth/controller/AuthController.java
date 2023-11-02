package com.dollyanddot.kingmaker.domain.auth.controller;

import com.dollyanddot.kingmaker.domain.auth.dto.LoginResDto;
import com.dollyanddot.kingmaker.domain.auth.service.OAuth2Service;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
@Slf4j
public class AuthController {
    private final OAuth2Service oAuth2Service;

    @GetMapping("/auth/{provider}")
    public ResponseEntity<LoginResDto> login(@PathVariable(name = "provider") String provider,
                                             @RequestParam(name = "code") String code) {
        log.info("로그인 요청 " + provider + "로 code = {} 전달", code);
        return ResponseEntity.ok().body(oAuth2Service.login(code, provider));
    }
}