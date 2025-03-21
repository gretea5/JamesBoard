package com.board.jamesboard.domain.archive.controller;

import com.board.jamesboard.domain.archive.dto.ArchiveResponseDto;
import com.board.jamesboard.domain.archive.service.ArchiveService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/archives")
@CrossOrigin("*")
@RequiredArgsConstructor
public class ArchiveController {
    private final ArchiveService archiveService;

    @GetMapping("")
    @Operation(summary = "아카이브 전체조회(아이디와 첫번째 이미지)")
    public ResponseEntity<List<ArchiveResponseDto>> getAllArchives() {
        return ResponseEntity.ok(archiveService.getArchivesImage());
    }
}
