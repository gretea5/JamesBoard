package com.board.jamesboard.domain.useractivity.controller;

import com.board.jamesboard.domain.useractivity.dto.RatingPatchRequestDto;
import com.board.jamesboard.domain.useractivity.dto.RatingPostRequestDto;
import com.board.jamesboard.domain.useractivity.dto.RatingResponseDto;
import com.board.jamesboard.domain.useractivity.dto.UserActivityResponseDto;
import com.board.jamesboard.domain.useractivity.service.UserActivityService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user-activity")
@CrossOrigin("*")
@RequiredArgsConstructor
@Slf4j
public class UserActivityController {
    private final UserActivityService userActivityService;

    @GetMapping("")
    @Operation(summary = "게임ID와 유저ID 조합에 해당하는 유저 활동 조회")
    public ResponseEntity<List<UserActivityResponseDto>> getUserActivity(@RequestParam Long userId, @RequestParam Long gameId) {
        return ResponseEntity.ok(userActivityService.getUserActivity(userId, gameId));
    }

    @GetMapping("/detail")
    @Operation(summary = "게임ID와 유저ID 조합에 해당하는 유저 활동 상세 조회")
    public ResponseEntity<RatingResponseDto> getUserActivityDetailById(@RequestParam Long userId, @RequestParam Long gameId) {
        return ResponseEntity.ok(userActivityService.getUserActivityRating(userId, gameId));
    }

    @PostMapping("")
    @Operation(summary = "유저 활동에 평점 추가")
    public ResponseEntity<Long> createUserRating(@RequestBody RatingPostRequestDto ratingPostRequestDto) {
        return ResponseEntity.ok(userActivityService.createUserActivityRating(ratingPostRequestDto));
    }

    @PatchMapping("/{userActivityId}")
    @Operation(summary = "유저 활동 평점 수정")
    public ResponseEntity<Long> updateUserRating(@PathVariable Long userActivityId, @RequestBody RatingPatchRequestDto ratingPatchRequestDto) {
        return ResponseEntity.ok(userActivityService.updateUserActivityRating(userActivityId, ratingPatchRequestDto));
    }

}
