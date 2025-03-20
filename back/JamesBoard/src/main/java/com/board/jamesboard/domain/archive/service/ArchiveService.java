package com.board.jamesboard.domain.archive.service;

import com.board.jamesboard.domain.archive.dto.ArchiveResponseDto;

import java.util.List;

public interface ArchiveService {
    List<ArchiveResponseDto> getArchives();
}
