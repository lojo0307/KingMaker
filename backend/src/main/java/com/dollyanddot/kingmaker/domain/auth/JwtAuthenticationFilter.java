package com.dollyanddot.kingmaker.domain.auth;

import com.dollyanddot.kingmaker.domain.auth.domain.Credential;
import com.dollyanddot.kingmaker.domain.auth.domain.RefreshToken;
import com.dollyanddot.kingmaker.domain.auth.exception.JwtExceptionList;
import com.dollyanddot.kingmaker.domain.auth.repository.CredentialRepository;
import com.dollyanddot.kingmaker.domain.auth.repository.RefreshTokenRepository;
import com.dollyanddot.kingmaker.domain.auth.service.JwtService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.mapping.GrantedAuthoritiesMapper;
import org.springframework.security.core.authority.mapping.NullAuthoritiesMapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final String NO_CHECK_URL = "/api/auth/";
    private final JwtService jwtService;
    private final CredentialRepository credentialRepository;
    private final RefreshTokenRepository refreshTokenRepository;

   private GrantedAuthoritiesMapper authoritiesMapper = new NullAuthoritiesMapper();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        // 로그인 요청이 들어오면 아래 과정 무시하고 다음 필터 호출
        if (request.getRequestURI().contains(NO_CHECK_URL)) {
            log.info("로그인 요청이 들어와 인증 과정을 시행하지 않음");
            filterChain.doFilter(request, response);
            return;
        }

        // 사용자 헤더에서 RefreshToken 추출
        String refreshToken = jwtService.extractRefreshToken(request)
                .filter(jwtService::isTokenValid)
                .orElse(null);

        // 요청 헤더에 Refresh 토큰이 있었다면 토큰 확인후 AccessToken 재발급
        if (refreshToken != null) {
            log.info("요청 헤더에 Refresh 토큰 존재 = {}", refreshToken);
            checkRefreshTokenAndReIssueAccessToken(response, refreshToken);
            return;
        }

        // RefreshToken이 없거나 유효하지 않다면 AccessToken 검사후 인증
        log.info("Refresh 토큰 존재하지 않아 Access 토큰 확인과정 진행");
        checkAccessTokenAndAuthentication(request, response, filterChain);
    }

    public void checkRefreshTokenAndReIssueAccessToken(HttpServletResponse response, String refreshToken) {
        refreshTokenRepository.findByRefreshToken(refreshToken)
                .ifPresentOrElse(token -> {
                    Optional<Credential> credential = credentialRepository.findById(Long.parseLong(token.getCredentialId()));
                    if (credential.isEmpty()) throw new JwtException(JwtExceptionList.UNAUTHORIZED.getMessage());
                    String reIssuedRefreshToken = reIssueRefreshToken(token);
                    jwtService.sendAccessAndRefreshToken(response, jwtService.generateAccessToken(credential.get().getCredentialId()), reIssuedRefreshToken);
                }, () -> {
                    throw new JwtException(JwtExceptionList.TOKEN_EXCEPTION.getMessage());
                });
    }

    public String reIssueRefreshToken(RefreshToken token) {
        String reIssuedRefreshToken = jwtService.generateRefreshToken();
        token.updateRefreshToken(reIssuedRefreshToken);
        refreshTokenRepository.save(token);
        return reIssuedRefreshToken;
    }

    public void checkAccessTokenAndAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        log.info("AccessToken을 확인하고 인증을 진행");
        jwtService.extractAccessToken(request)
                .filter(jwtService::isTokenValid)
                .ifPresentOrElse(accessToken -> jwtService.extractCredentialId(accessToken)
                        .ifPresentOrElse(credentialId -> credentialRepository.findById(credentialId)
                                .ifPresentOrElse(this::saveAuthentication, () -> {throw new JwtException(JwtExceptionList.UNAUTHORIZED.getMessage());})
                        , () -> {throw new JwtException(JwtExceptionList.UNAUTHORIZED.getMessage());})
                        , () -> {throw new JwtException(JwtExceptionList.TOKEN_NOTFOUND.getMessage());});
        filterChain.doFilter(request, response);
    }

    public void saveAuthentication(Credential credential) {
        log.info("인증 완료, 권한 부여");
        UserDetails userDetails = User.builder()
                .username(String.valueOf(credential.getCredentialId()))
                .password("")
                .roles(credential.getRole().name())
                .build();

        Authentication authentication =
                new UsernamePasswordAuthenticationToken(userDetails, null,
                        authoritiesMapper.mapAuthorities(userDetails.getAuthorities()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
    }







































}
