package com.board.jamesboard.db.repository;

import com.board.jamesboard.db.entity.GameCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GameCategoryRepository extends JpaRepository<GameCategory, Long> {
    List<GameCategory> findByGameCategoryName(String category);
}
