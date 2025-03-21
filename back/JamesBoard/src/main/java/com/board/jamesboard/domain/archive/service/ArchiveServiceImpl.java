package com.board.jamesboard.domain.archive.service;

import com.board.jamesboard.db.entity.Archive;
import com.board.jamesboard.db.entity.ArchiveImage;
import com.board.jamesboard.db.repository.ArchiveImageRepository;
import com.board.jamesboard.db.repository.ArchiveRepository;
import com.board.jamesboard.domain.archive.dto.ArchiveResponseDto;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class ArchiveServiceImpl implements ArchiveService {

    private final ArchiveRepository archiveRepository;
    private final ArchiveImageRepository archiveImageRepository;

    @Override
    public List<ArchiveResponseDto> getArchivesImage() {

        // 1. 아카이브 전체 조회
        List<Archive> archiveList = archiveRepository.findAll();

        // 2. 조회한 아카이브를 통해 이미지 조회
        List<ArchiveImage> images = archiveImageRepository.findAllByArchiveIn(archiveList);

        // 3. 아카이브별 첫 번째 이미지 매핑
        Map<Long, String> archiveImageMap = images.stream()
                .collect(Collectors.toMap(
                        img -> img.getArchive().getArchiveId(), // key: archiveId
                        ArchiveImage::getArchiveImageUrl,       // value: 이미지 URL
                        (existing, replacement) -> existing      // 여러 이미지 중 첫 번째만 유지
                ));

        // 4. DTO로 변환
        return archiveList.stream()
                .map(archive -> {
                    String firstImage = archiveImageMap.getOrDefault(archive.getArchiveId(), null);
                    return new ArchiveResponseDto(
                            String.valueOf(archive.getArchiveId()),
                            firstImage
                    );
                })
                .toList();
    }

}
