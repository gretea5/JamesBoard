package com.board.jamesboard.domain.mypage.controller;

import com.board.jamesboard.core.constant.ErrorCode;
import com.board.jamesboard.core.error.ErrorResponse;
import com.board.jamesboard.core.exception.CustomException;
import com.board.jamesboard.domain.auth.controller.AuthController;
import com.board.jamesboard.domain.mypage.dto.UserProfileResponseDto;
import com.board.jamesboard.domain.mypage.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "Mypage", description = "마이페이지 API")
@SecurityRequirement(name = "bearer-jwt")
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @Operation(summary = "사용자 정보 조회", description = "사용자의 프로필 정보를 조회")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "사용자 정보 조회 성공",
                    content = @Content(schema = @Schema(implementation = UserProfileResponseDto.class))),
            @ApiResponse(responseCode = "401", description = "인증되지 않은 요청입니다. (JWT 토큰 누락 또는 유효하지 않을 시)"),
            @ApiResponse(responseCode = "404", description = "해당 유저를 찾을 수 없습니다. (회원 ID가 존재하지 않을 시)")
    })
    @GetMapping("/{userId}")
    public ResponseEntity<?> getUserProfile(@PathVariable Long userId) {
        try {
            // JWT 토큰에서 사용자 ID 추출
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            Long currentUserId = Long.parseLong(authentication.getName());

            // 요청 userId와 토큰 userId 일치 여부 확인
            if (!userId.equals(currentUserId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(new ErrorResponse(HttpStatus.FORBIDDEN, "접근 권한이 없습니다"));
            }

            // 내 정보 조회
            UserProfileResponseDto response = userService.getUserProfile(userId);
            return ResponseEntity.ok(response);

        } catch (CustomException e) {
            log.error("사용자 정보 조회 실패 : {}", e.getMessage());
            return ResponseEntity.status(e.getErrorCode().getHttpStatus())
                    .body(new ErrorResponse(e.getErrorCode().getHttpStatus(), e.getMessage()));
        } catch (Exception e) {
            log.error("사용자 정보 조회 중 오류 발생 : {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse(HttpStatus.UNAUTHORIZED, "인증되지 않은 요청입니다"));
        }

    }

}
