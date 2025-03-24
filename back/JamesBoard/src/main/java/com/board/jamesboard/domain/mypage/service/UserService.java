package com.board.jamesboard.domain.mypage.service;

import com.board.jamesboard.domain.mypage.dto.UserProfileResponseDto;

public interface UserService {

    //내 정보 조회
    UserProfileResponseDto getUserProfile(Long userId);
}
