package com.board.jamesboard.domain.auth.controller;

import com.board.jamesboard.core.auth.dto.CustomUserDetails;
import com.board.jamesboard.domain.auth.dto.RefreshTokenRequestDto;
import com.board.jamesboard.domain.auth.dto.RefreshTokenResponseDto;
import com.board.jamesboard.domain.auth.service.AuthService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
    private String redirectUri;

    private final AuthService authService;

    @GetMapping("/login-oauth")
    public ResponseEntity<?> kakaoLogin(@RequestParam(required = false) String error) {
        // 로그출력부
        if (error != null) {
            log.error("OAuth 로그인 중 오류 발생: {}", error);
            return ResponseEntity.badRequest().body("OAuth 인증 중 오류 발생" + error);
        }


        //URL 구성
        String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize" +
                "?client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&response_type=code";

        // 리다이렉트 응답 반환
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create(kakaoAuthUrl));
        return new ResponseEntity<>(headers, HttpStatus.FOUND);
    }

    // 액세스 토큰 갱신
    @PostMapping("/refresh")
    public ResponseEntity<RefreshTokenResponseDto> refresh(@RequestBody RefreshTokenRequestDto request) {
        RefreshTokenResponseDto response = authService.refreshToken(request.getRefreshToken());
        return ResponseEntity.ok(response);
    }

    // 로그아웃 API
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@AuthenticationPrincipal CustomUserDetails userDetails) {
        authService.logout(userDetails.getUserId());
        return ResponseEntity.ok().build();
    }

//    @GetMapping("/login/oauth2/code/kakao")
//    public ResponseEntity<TokenResponseDto> processKakaoLogin(@RequestParam String code) {
//        log.info("카카오 인가 코드: {}", code);
//        try {
//            TokenResponseDto response = authService.processKakaoLogin(code);
//            log.info("카카오 로그인 성공 {}", response.getUserId());
//            return ResponseEntity.ok(response);
//        } catch (Exception e) {
//            log.error("카카오 로그인 처리 중 오류 발생 {}", e.getMessage(), e);
//            throw e;
//        }
//    }


//    // 로그인 콜백 api
//    @GetMapping("/oauth2/code/kakao")
//    public ResponseEntity<TokenResponseDto> kakaoCallback(@RequestParam String code) {
//        log.info("카카오 인가 코드: {}", code);
//        TokenResponseDto response = authService.processKakaoLogin(code);
//        return ResponseEntity.ok(response);
//    }

}
