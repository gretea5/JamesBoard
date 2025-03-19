package com.board.jamesboard.domain.onboard.service;

import com.board.jamesboard.domain.onboard.dto.OnBoardResponseDto;

import java.util.List;

public interface OnBoardService {
    public List<OnBoardResponseDto> getOnBoardGames(String category);
}
