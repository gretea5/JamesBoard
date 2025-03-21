package com.board.jamesboard.domain.auth;

import com.board.jamesboard.domain.auth.dto.RefreshTokenResponseDto;
import com.board.jamesboard.domain.auth.service.AuthService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class OAuthCallbackController {

    private final AuthService authService;

    @GetMapping("/login/oauth2/code/kakao")
    public ResponseEntity<RefreshTokenResponseDto> processKakaoLogin(@RequestParam String code) {
        log.info("========== OAuthCallbackController 시작: 카카오 인가 코드 = {} ==========", code);

        // 로직 실행 전 로그
        log.info("AuthService.processKakaoLogin 호출 전");
        log.info("카카오 인가 코드: {}", code);
        try {
            RefreshTokenResponseDto response = authService.processKakaoLogin(code);
            log.info("카카오 로그인 성공 {}", response.getUserId());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("카카오 로그인 처리 중 오류 발생 {}", e.getMessage(), e);
            throw e;
        }
    }

}
