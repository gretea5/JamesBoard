package com.board.jamesboard.domain.mypage.service;

import com.board.jamesboard.core.constant.ErrorCode;
import com.board.jamesboard.core.exception.CustomException;
import com.board.jamesboard.db.entity.User;
import com.board.jamesboard.db.repository.UserRepository;
import com.board.jamesboard.domain.mypage.dto.UserProfileResponseDto;
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

}
