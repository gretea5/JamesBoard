package com.board.jamesboard.domain.auth.dto;

import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
public class RefreshTokenRequestDto {
    private String refreshToken;

}
