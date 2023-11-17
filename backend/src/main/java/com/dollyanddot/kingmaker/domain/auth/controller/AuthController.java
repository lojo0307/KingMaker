package com.dollyanddot.kingmaker.domain.auth.controller;

import com.dollyanddot.kingmaker.domain.auth.service.OAuth2Service;
import com.dollyanddot.kingmaker.domain.auth.dto.LoginResDto;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/api/auth")
@AllArgsConstructor
@Slf4j
public class AuthController {
    private final OAuth2Service oAuth2Service;

    @GetMapping("/{provider}")
    public EnvelopeResponse<LoginResDto> login(@PathVariable(name = "provider") String provider,
                                               @RequestParam(name = "code") String code, HttpServletResponse response) throws IOException {
        log.info("로그인 요청 " + provider + "로 code = {} 전달", code);
        return EnvelopeResponse.<LoginResDto>builder().data(oAuth2Service.login(code, provider, response)).build();
    }
}