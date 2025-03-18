package com.board.jamesboard.db.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Builder
@Table(name = "archive")
@Entity
public class Archive {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "archive_id", nullable = false)
    private Long archiveId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "game_id", nullable = false)
    private Game game;

    @Size(max = 255)
    @Column(name = "archive_content")
    private String archiveContent;

    @Column(name = "archive_game_play_count")
    private Integer archiveGamePlayCount;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "is_deleted")
    private Byte isDeleted;

    //Archive 삭제시 image도 삭제되어야한다.
    @OneToMany(mappedBy = "archive", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ArchiveImage> archiveImages = new ArrayList<>();
}
