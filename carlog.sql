BEGIN;
/* rebuild all tables from scratch */
DROP TABLE IF EXISTS carlog_user;
DROP TABLE IF EXISTS carlog_vehicle;
DROP TABLE IF EXISTS carlog_trip;

CREATE TABLE carlog_user (
    id            INTEGER       NOT NULL  PRIMARY KEY  AUTOINCREMENT,
    user_name     VARCHAR(64)   NOT NULL,
    first_name    VARCHAR(128)  NOT NULL,
    last_name     VARCHAR(128)  NOT NULL,
    password      VARCHAR(64)   NOT NULL,

    email         TEXT          NOT NULL,

    created       DATETIME      NOT NULL,
    updated       DATETIME      NOT NULL
);

CREATE TABLE carlog_vehicle (
    id            INTEGER       NOT NULL  PRIMARY KEY  AUTOINCREMENT,
    user_id       INTEGER       NOT NULL  REFERENCES carlog_user(id),

    description   TEXT,

    registration  VARCHAR(32)   NOT NULL,

    created       DATETIME      NOT NULL,
    updated       DATETIME      NOT NULL
);

CREATE TABLE carlog_trip (
    id            INTEGER       NOT NULL  PRIMARY KEY  AUTOINCREMENT,
    vehicle_id    INTEGER       NOT NULL  REFERENCES carlog_vehicle(id),

    odo_start     INTEGER,
    dtg_start     DATETIME      NOT NULL,
    odo_end       INTEGER,
    dtg_end       DATETIME,

    description   TEXT,

    business      BOOL,

    created       DATETIME      NOT NULL,
    updated       DATETIME      NOT NULL
);

COMMIT;
