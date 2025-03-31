package com.board.jamesboard.domain.boardgame.service;

import java.util.List;

import com.board.jamesboard.domain.boardgame.dto.BoardgameRecommendDto;

public interface BoardgameSearchService {
    List<BoardgameRecommendDto> searchBoardgames(Integer difficulty, Integer minPlayers, String name, String category);
}