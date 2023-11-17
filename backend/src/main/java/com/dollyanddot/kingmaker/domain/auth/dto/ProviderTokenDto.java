package com.dollyanddot.kingmaker.domain.auth.dto;

import lombok.Data;

@Data
public class ProviderTokenDto {
    private String access_token;
    private String token_type;
    private Long expires_in;
    private String scope;
    private String refresh_token;
    private Long refresh_token_expires_in;
    private String id_token;
}
