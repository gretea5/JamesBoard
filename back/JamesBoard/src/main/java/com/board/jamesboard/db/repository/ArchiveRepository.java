package com.board.jamesboard.db.repository;

import com.board.jamesboard.db.entity.Archive;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArchiveRepository extends JpaRepository<Archive, Long> {
}
