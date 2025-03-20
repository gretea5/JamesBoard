package com.board.jamesboard.db.repository;

import com.board.jamesboard.db.entity.Game;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GameRepository extends JpaRepository<Game,Long> {
    List<Game> findTop30ByGameIdInOrderByGameRank(List<Long> gameIds);
}
