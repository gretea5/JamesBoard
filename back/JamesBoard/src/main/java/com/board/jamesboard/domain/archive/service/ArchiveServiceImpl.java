package com.board.jamesboard.domain.archive.service;

import com.board.jamesboard.db.entity.*;
import com.board.jamesboard.db.repository.*;
import com.board.jamesboard.domain.archive.dto.ArchiveDetailResponseDto;
import com.board.jamesboard.domain.archive.dto.ArchiveImageDto;
import com.board.jamesboard.domain.archive.dto.ArchiveRequestDto;
import com.board.jamesboard.domain.archive.dto.ArchiveResponseDto;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
@AllArgsConstructor
@Slf4j
public class ArchiveServiceImpl implements ArchiveService {

    private final ArchiveRepository archiveRepository;
    private final ArchiveImageRepository archiveImageRepository;
    private final UserRepository userRepository;
    private final GameRepository gameRepository;
    private final UserActivityRepository userActivityRepository;

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

    @Override
    public ArchiveDetailResponseDto getArchiveDetail(Long archiveId) {

        Archive archive = archiveRepository.findById(archiveId)
                .orElseThrow(() -> new RuntimeException("Archive not found"));

        List<ArchiveImage> archiveImageList = archiveImageRepository.findByArchive(archive);

        User createUser = archive.getUser();
        Game playedGame = archive.getGame();

        log.debug("Archive userId: {}",
                createUser.getUserId());

        log.debug("Archive image list: {}",
                archiveImageList.stream()
                        .map(img -> "[id=" + img.getArchiveImageId() + ", url=" + img.getArchiveImageUrl() + "]")
                        .toList()
        );

        // 이미지 리스트 DTO 변환
        List<ArchiveImageDto> archiveImageDtoList = archiveImageList.stream()
                .map(img -> new ArchiveImageDto(img.getArchiveImageUrl()))
                .toList();

        return new ArchiveDetailResponseDto(
                archive.getArchiveId(),
                createUser.getUserNickname(),
                createUser.getUserProfile(),
                archive.getArchiveContent(),
                playedGame.getGameTitle(),
                archive.getArchiveGamePlayTime(),
                archiveImageDtoList
        );

    }

    @Override
    public Long createArchive(ArchiveRequestDto archiveRequestDto) {

        // JWT 현재 userId 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        Long userId = Long.parseLong(authentication.getName());

        Game game = gameRepository.findById(archiveRequestDto.getGameId())
                .orElseThrow(() -> new RuntimeException("해당 게임이 존재하지 않습니다."));

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("해당 유저가 존재하지 않습니다."));

        Archive archive = Archive.builder()
                .archiveContent(archiveRequestDto.getArchiveContent())
                .archiveGamePlayTime(archiveRequestDto.getArchiveGamePlayTime())
                .archiveGamePlayCount(archiveRequestDto.getArchiveGamePlayCount())
                .game(game)
                .user(user)
                .build();


        List<ArchiveImageDto> archiveImageList = archiveRequestDto.getArchiveImageList();

        List<ArchiveImage> archiveImages = archiveImageList.stream()
                .map(dto -> ArchiveImage.builder()
                        .archiveImageUrl(dto.getArchiveImageUrl())
                        .archive(archive)
                        .build())
                .toList();

        archiveImageRepository.saveAll(archiveImages);

        Archive savedArchive = archiveRepository.save(archive);

        int playTime = archive.getArchiveGamePlayTime();
        Instant now = Instant.now();

        userActivityRepository.findByUserAndGame(user, game)
                .ifPresentOrElse(
                        existing -> {
                            UserActivity updated = existing.toBuilder()
                                    .userActivityTime(existing.getUserActivityTime() + playTime)
                                    .modifiedAt(now)
                                    .build();
                            userActivityRepository.save(updated);
                        },
                        () -> {
                            UserActivity newActivity = UserActivity.builder()
                                    .user(user)
                                    .game(game)
                                    .userActivityTime(playTime)
                                    .userActivityRating(null)
                                    .createdAt(now)
                                    .modifiedAt(now)
                                    .build();
                            userActivityRepository.save(newActivity);
                        }
                );

        return savedArchive.getArchiveId();
    }

}
