package com.board.jamesboard.domain.onboard.service;

import com.board.jamesboard.db.entity.Game;
import com.board.jamesboard.db.repository.GameCategoryRepository;
import com.board.jamesboard.db.repository.GameRepository;
import com.board.jamesboard.domain.onboard.dto.OnBoardResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OnBoardServiceImpl implements OnBoardService {

    @Autowired
    private GameCategoryRepository gameCategoryRepository;

    @Autowired
    private GameRepository gameRepository;

    @Override
    public List<OnBoardResponseDto> getOnBoardGames(String category) {

        // Category 입력 받아서 게임ID 조회
        List<Long> gameIdList = gameCategoryRepository.findTop30ByGameCategoryName(category)
                .stream()
                .map(gameCategory -> gameCategory.getGame().getGameId()) // Game 객체에서 ID 추출
                .toList();

        List<Game> games = gameRepository.findAllById(gameIdList);


        List<OnBoardResponseDto> result = games.stream()
                .map(game -> new OnBoardResponseDto(game.getGameId(), game.getGameTitle())) // DTO 변환
                .toList();

        return result;
    }
}
