package com.board.jamesboard.db.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;

@Entity
@Table(name = "users")
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prefer_game_id")
    private Game preferGame;

    @Column(name = "login_id")
    private String loginId;

    @Column(name = "user_profile")
    private String userProfile;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "user_nickname")
    private String userNickname;



}
