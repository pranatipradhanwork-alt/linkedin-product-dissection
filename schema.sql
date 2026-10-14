-- LinkedIn product dissection: database schema (MySQL)
-- Built from the ER diagram in images/er_diagram.png

CREATE TABLE users (
    user_id          INT PRIMARY KEY,
    username         VARCHAR(50)  NOT NULL,
    email            VARCHAR(100) NOT NULL,
    full_name        VARCHAR(100) NOT NULL,
    profile_summary  TEXT,
    join_date        DATE NOT NULL
);

CREATE TABLE profiles (
    profile_id       INT PRIMARY KEY,
    user_id          INT NOT NULL UNIQUE,          -- one profile per user
    experience       JSON,
    education        JSON,
    skills           JSON,
    accomplishments  JSON,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE posts (
    post_id          INT PRIMARY KEY,
    user_id          INT NOT NULL,
    content_type     VARCHAR(20),                  -- text, article, poll, ...
    text             TEXT,
    media_url        VARCHAR(200),
    post_date        TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id       INT PRIMARY KEY,
    post_id          INT NOT NULL,
    user_id          INT NOT NULL,
    text             TEXT,
    comment_date     TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
    like_id          INT PRIMARY KEY,
    post_id          INT NOT NULL,
    user_id          INT NOT NULL,
    like_date        TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE connections (
    connection_id    INT PRIMARY KEY,
    user_id1         INT NOT NULL,
    user_id2         INT NOT NULL,
    connection_date  DATE,
    status           VARCHAR(20),                  -- pending, accepted, ...
    FOREIGN KEY (user_id1) REFERENCES users(user_id),
    FOREIGN KEY (user_id2) REFERENCES users(user_id)
);

CREATE TABLE endorsements (
    endorsement_id    INT PRIMARY KEY,
    endorsed_user_id  INT NOT NULL,
    endorser_id       INT NOT NULL,
    skill             VARCHAR(100),
    endorsement_date  TIMESTAMP,
    FOREIGN KEY (endorsed_user_id) REFERENCES users(user_id),
    FOREIGN KEY (endorser_id)      REFERENCES users(user_id)
);

CREATE TABLE companies (
    company_id       INT PRIMARY KEY,
    name             VARCHAR(100),
    description      TEXT,
    industry         VARCHAR(50),
    followers        INT
);

CREATE TABLE jobs (
    job_id           INT PRIMARY KEY,
    company_id       INT NOT NULL,
    title            VARCHAR(100),
    description      TEXT,
    location         VARCHAR(100),
    post_date        DATE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);
