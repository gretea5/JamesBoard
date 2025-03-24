package com.board.jamesboard.domain.mypage.service;

import com.board.jamesboard.core.constant.ErrorCode;
import com.board.jamesboard.core.exception.CustomException;
import com.board.jamesboard.db.entity.User;
import com.board.jamesboard.db.repository.UserRepository;
import com.board.jamesboard.domain.mypage.dto.UserProfileResponseDto;
import com.board.jamesboard.domain.mypage.dto.UserProfileUpdateRequestDto;
import com.board.jamesboard.domain.mypage.dto.UserProfileUpdateResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    // 내 정보 조회
    @Override
    public UserProfileResponseDto getUserProfile(Long userId) {
        // 사용자 정보 조회
        User user = userRepository.findByUserId(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

        // 내 정보 반환
        return UserProfileResponseDto.builder()
                .userProfile(user.getUserProfile())
                .userNickname(user.getUserNickname())
                .build();

    }
    // 프로필 수정
    @Override
    @Transactional
    public UserProfileUpdateResponseDto updateUserProfile(Long userId, UserProfileUpdateRequestDto request) {
        try {
            //사용자 정보 조회
            User user = userRepository.findByUserId(userId)
                    .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));

            // 프로필 정보 업데이트
            user.updateProfile(request.getUserProfile(), request.getUserName());

            log.info("사용자 프로필 업데이트 완료 : user={}", userId);

            //응답 반환
            return UserProfileUpdateResponseDto.builder()
                    .usersId(userId)
                    .build();
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            log.error("사용자 프로필 업데이트 실패 : {}", e.getMessage());
            throw new CustomException(ErrorCode.INTERNAL_SERVER_ERROR);
        }
    }


}
