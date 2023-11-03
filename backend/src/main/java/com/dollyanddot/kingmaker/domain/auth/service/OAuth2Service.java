package com.dollyanddot.kingmaker.domain.auth.service;

import com.dollyanddot.kingmaker.domain.auth.domain.Credential;
import com.dollyanddot.kingmaker.domain.auth.domain.Provider;
import com.dollyanddot.kingmaker.domain.auth.domain.Role;
import com.dollyanddot.kingmaker.domain.auth.dto.LoginResDto;
import com.dollyanddot.kingmaker.domain.auth.dto.ProviderTokenDto;
import com.dollyanddot.kingmaker.domain.auth.repository.CredentialRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.MediaType;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@Service
public class OAuth2Service {

    private final CredentialRepository credentialRepository;
    private final InMemoryClientRegistrationRepository inMemoryClientRegistrationRepository;
    private final JwtService jwtService;

    public LoginResDto login(String code, String provider, HttpServletResponse response) throws IOException {
        log.info("로그인 로직 시작");
        ClientRegistration providerInfo = inMemoryClientRegistrationRepository.findByRegistrationId(provider);
        ProviderTokenDto providerToken = getAccessToken(provider, code, providerInfo);
        log.info("토큰 발급 완료 = {}", providerToken.getAccess_token());

        loginSuccess(response, getCredential(getUserInfo(providerToken, providerInfo, Provider.valueOf(provider.toUpperCase())), Provider.valueOf(provider.toUpperCase())));
        log.info("로그인 성공!");
        log.info("발급된 Access Token = {}", response.getHeader("Authorization"));
        // credentialtoresdto
        return null;
    }

    private void loginSuccess(HttpServletResponse response, Credential credential) throws IOException {
        String accessToken = jwtService.generateAccessToken(credential.getCredentialId());
        String refreshToken = jwtService.generateRefreshToken();
        response.addHeader(jwtService.getAccessHeader(), "Bearer " + accessToken);
        response.addHeader(jwtService.getRefreshHeader(), "Bearer " + refreshToken);

        jwtService.sendAccessAndRefreshToken(response, accessToken, refreshToken);
        jwtService.updateRefreshToken(credential.getCredentialId(), refreshToken);
    }


    /**
     * OAuth2 Provider로부터 엑세스 토큰 발급
     */
    public ProviderTokenDto getAccessToken(String provider, String code, ClientRegistration providerInfo) {

        log.info("토큰 요청 로직 시작");
        // 요청 param
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", providerInfo.getClientId());
        params.add("redirect_uri", providerInfo.getRedirectUri());
        params.add("code", code);
        params.add("client_secret", providerInfo.getClientSecret());

        log.info("client_id: {}", providerInfo.getClientId());
        log.info("토큰 요청 시작");
        // 토큰 요청
        WebClient webClient = WebClient.create();
        String response = webClient.post()
                .uri(providerInfo.getProviderDetails().getTokenUri())
                .body(BodyInserters.fromFormData(params))
                .header("Content-type", "application/x-www-form-urlencoded;charset=utf-8")
                .retrieve()
                .bodyToMono(String.class)
                .block();
        log.info("토큰 발급 완료 = {}", response);

        // json -> Token class
        ObjectMapper objectMapper = new ObjectMapper();
        ProviderTokenDto token = null;
        try {
            token = objectMapper.readValue(response, ProviderTokenDto.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return token;
    }

    /**
     * 발급받은 엑세스 토큰으로 사용자 정보 요청
     */
    public String getUserInfo(ProviderTokenDto token, ClientRegistration providerInfo, Provider provider) {

        log.info("사용자 정보 요청 시작");
        // 사용자 정보 요청
        String response = WebClient.create()
                .post()
                .uri(providerInfo.getProviderDetails().getUserInfoEndpoint().getUri())
                .headers(header -> {
                    header.setBearerAuth(token.getAccess_token());
                })
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
//                .body(BodyInserters.fromFormData("property_keys", "[\"kakao_account.email\"]"))
                .retrieve()
                .bodyToMono(String.class)
                .block();

        log.info("Provider로부터 사용자 정보 받아옴 = {}", response);

        String email = null;
        JSONParser parser = new JSONParser();
        try {
            JSONObject jsonObject = (JSONObject) parser.parse(response);
            switch (provider) {
                case KAKAO:
                    JSONObject kakaoAccount = (JSONObject) jsonObject.get("kakao_account");
                    email = kakaoAccount.get("email").toString();
                    break;
                case GOOGLE:
                    email = jsonObject.get("email").toString();
                    break;
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        log.info("응답으로부터 이메일 추출 = {}", email);

        return email;
    }

    /**
     * 사용자 정보 조회하고 찾아옴
     */
    public Credential getCredential(String email, Provider provider) {
        Optional<Credential> findCredential = credentialRepository.findByEmailAndProvider(email, provider);

        if (findCredential.isEmpty()) return saveCredential(email, provider);
        log.info("사용자 정보가 존재합니다. 로그인을 진행합니다.");
        return findCredential.get();
    }

    /**
     * 사용자 정보가 존재하지 않을 시 회원가입
     */
    public Credential saveCredential(String email, Provider provider) {
        log.info("사용자 정보가 존재하지 않습니다. 회원가입을 진행합니다.");
        return credentialRepository.save(Credential.builder().role(Role.GUEST).email(email).provider(provider).build());
    }
}
