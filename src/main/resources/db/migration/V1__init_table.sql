-- V1__init_core_schema.sql

-- 사용자 테이블
CREATE TABLE users (
                       id              BIGINT PRIMARY KEY AUTO_INCREMENT,
                       username        VARCHAR(50) NOT NULL UNIQUE,
                       email           VARCHAR(100) NOT NULL UNIQUE,
                       password_hash   VARCHAR(255) NOT NULL,
                       role            ENUM('editor', 'admin') DEFAULT 'editor',
                       created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 포스트 테이블
CREATE TABLE posts (
                       id              BIGINT PRIMARY KEY AUTO_INCREMENT,
                       title           VARCHAR(200) NOT NULL,
                       slug            VARCHAR(200) NOT NULL UNIQUE,
                       content_path    VARCHAR(255) NOT NULL,
                       author_id       BIGINT NOT NULL,
                       author_username VARCHAR(50),
                       visibility      ENUM('public', 'private', 'unlisted') DEFAULT 'public',
                       created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 태그 마스터
CREATE TABLE tags (
                      id              BIGINT PRIMARY KEY AUTO_INCREMENT,
                      name            VARCHAR(50) NOT NULL UNIQUE,
                      created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 포스트-태그 연결
CREATE TABLE post_tags (
                           post_id         BIGINT NOT NULL,
                           tag_id          BIGINT NOT NULL,
                           PRIMARY KEY (post_id, tag_id)
);

-- 메뉴 정의
CREATE TABLE menus (
                       id              BIGINT PRIMARY KEY AUTO_INCREMENT,
                       name            VARCHAR(100) NOT NULL,
                       slug            VARCHAR(100) NOT NULL UNIQUE,
                       parent_id       BIGINT DEFAULT NULL,
                       order_no        INT DEFAULT 0,
                       created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 메뉴 접근 역할 설정
CREATE TABLE menu_roles (
                            menu_id         BIGINT NOT NULL,
                            role            ENUM('visitor', 'editor', 'admin') NOT NULL,
                            PRIMARY KEY (menu_id, role)
);