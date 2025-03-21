package com.board.jamesboard.domain.auth.dto;

import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
public class RefreshTokenResponseDto { // 토큰 갱신시 반환 데이터
    private Long userId;
    private String userNickname;
    private String userProfile;
    private String accessToken;
    private String refreshToken;
}
