package com.board.jamesboard.db.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Timestamp;
import java.time.Instant;

@Entity
@Table(name = "users")
@Getter
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

    @CreationTimestamp
    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private Timestamp createdAt;

    @Column(name = "user_nickname")
    private String userNickname;


    @Builder
    public User(String loginId, String userProfile, String userNickname, Game preferGame) {
        this.loginId = loginId;
        this.userProfile = userProfile;
        this.userNickname = userNickname;
        this.preferGame = preferGame;
        this.createdAt = Timestamp.from(Instant.now());
    }

    // 유저의 선호게임 변경
    public void updatePreferGame(Game preferGame) {
        this.preferGame = preferGame;
    }
}
