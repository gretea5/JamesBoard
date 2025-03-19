package com.board.jamesboard.domain.onboard.controller;

import com.board.jamesboard.domain.onboard.dto.OnBoardResponseDto;
import com.board.jamesboard.domain.onboard.service.OnBoardService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/onboard")
@CrossOrigin("*")
@RequiredArgsConstructor
public class OnBoardController {

    @Autowired
    private OnBoardService onBoardService;

    @GetMapping("games")
    @Operation(summary = "장르별 TOP 30 보드게임 조회")
    public ResponseEntity<List<OnBoardResponseDto>> getOnBoardGamesByCategory(@RequestParam(required = true) String category) {
        return ResponseEntity.ok(onBoardService.getOnBoardGames(category));
    }

}
