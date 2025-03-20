package com.board.jamesboard.domain.archive.service;

import com.board.jamesboard.db.repository.ArchiveRepository;
import com.board.jamesboard.domain.archive.dto.ArchiveResponseDto;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ArchiveServiceImpl implements ArchiveService {

    private final ArchiveRepository archiveRepository;

    @Override
    public List<ArchiveResponseDto> getArchives() {

        archiveRepository.findAll();

        return List.of();
    }
}
