package com.board.jamesboard.db.repository;

import com.board.jamesboard.db.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}
