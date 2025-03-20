package com.board.jamesboard.domain.onboard.service;

import com.board.jamesboard.domain.onboard.dto.OnBoardResponseDto;
import com.board.jamesboard.domain.onboard.dto.PreferGameRequestDto;

import java.util.List;

public interface OnBoardService {
    public List<OnBoardResponseDto> getOnBoardGames(String category);

    public Long updateUserPreferGame(long userId, PreferGameRequestDto preferGameRequestDto);
}
