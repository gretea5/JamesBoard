package com.board.jamesboard.db.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Table(name = "game")
@Entity
public class game {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "game_id", nullable = false)
    private Long id;

    @Size(max = 255)
    @Column(name = "game_title")
    private String gameTitle;

    @Size(max = 255)
    @Column(name = "game_description")
    private String gameDescription;

    @Size(max = 255)
    @Column(name = "big_thumbnail")
    private String bigThumbnail;

    @Size(max = 255)
    @Column(name = "small_thumbnail")
    private String smallThumbnail;

    @Size(max = 255)
    @Column(name = "game_image")
    private String gameImage;

    @Column(name = "game_year")
    private Integer gameYear;

    @Column(name = "min_player")
    private Integer minPlayer;

    @Column(name = "max_player")
    private Integer maxPlayer;

    @Column(name = "game_play_time")
    private Integer gamePlayTime;

    @Column(name = "game_min_age")
    private Integer gameMinAge;

    @Size(max = 255)
    @Column(name = "game_publisher")
    private String gamePublisher;

    @Column(name = "game_difficulty")
    private Integer gameDifficulty;
}
