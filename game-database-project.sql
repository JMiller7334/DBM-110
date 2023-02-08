-- BASE TABLES --
DROP TABLE IF EXISTS gameData;
CREATE TABLE gameData(
    userId INTEGER NOT NULL,
    money INTEGER DEFAULT 0,
    inv TEXT,
    ownedObj TEXT,
    ownedObjQuantity INTEGER);

DROP TABLE IF EXISTS playerHouseData;
CREATE TABLE playerHouseData(
    userId INTEGER NOT NULL,
    objName TEXT,
    objPos TEXT,
    objRot TEXT);

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
        
    INSERT INTO playerHouseData(userId)
        VALUES(last_insert_rowid());
    SELECT * FROM gameData;
END;

-- TASKS --
-- Players Join
INSERT INTO players(username)
    VALUES('player1'), ('player2'), ('player3');

--UPDATE--
UPDATE gameData SET OwnedObj = 'iron nails' WHERE userId = (
SELECT userId from players WHERE username = 'player3');

-- JOINS --
SELECT * FROM playerHouseData
    JOIN gameData ON gameData.userId = playerHouseData.userId;

-- SELECT STATEMENT
SELECT * FROM players;
SELECT * FROM gameData;
SELECT * FROM playerhouseData