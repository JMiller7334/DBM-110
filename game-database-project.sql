-- BASE TABLES --
DROP TABLE IF EXISTS gameData;
CREATE TABLE gameData (
    userId INTEGER NOT NULL,
    money INTEGER DEFAULT 0,
    inv TEXT,
    ownObj TEXT
);

DROP TABLE IF EXISTS players;
CREATE TABLE players(
    userId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    email TEXT);
 
-- TABLE TRIGGERS --
DROP TRIGGER IF EXISTS onPlayerAdded;
CREATE TRIGGER onPlayerAdded AFTER INSERT ON players
BEGIN
    INSERT INTO gameData(userId)
        VALUES(last_insert_rowid());
    SELECT * FROM gameData;
END;

-- TASKS --
INSERT INTO players(username)
    VALUES('jmiller7334');

SELECT * FROM players, gameData;