package com.board.jamesboard.db.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.Instant;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Table(name = "archive")
@Entity
public class archive {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "archive_id", nullable = false)
    private Long id;

    @NotNull
    @Column(name = "user_id", nullable = false)
    private Long userId;

    @NotNull
    @Column(name = "game_id", nullable = false)
    private Long gameId;

    @Size(max = 255)
    @Column(name = "archive_content")
    private String archiveContent;

    @Column(name = "archive_game_play_count")
    private Integer archiveGamePlayCount;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "is_deleted")
    private Byte isDeleted;
}
