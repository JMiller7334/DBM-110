/*EXERCISE 9: Transactions
This is a simple exercise working with transcations that updates two tables
together.
*/

DROP TABLE IF EXISTS personalRecords;
CREATE TABLE personalRecords(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    movement STRING NOT NULL,
    weight FLOAT NOT NULL,
    date STRING NOT NULL
);
INSERT INTO personalRecords(movement, weight, date)
    Values ('benchpress', 265.0, '2021-03-10'),
            ('sqaut(wide stance)', 294.5, '2021-03-10'),
            ('squat(full ROM)', 225, '2022-07-23'),
            ('weighted dips', 145.0, '2021-03-10');
DROP TABLE IF EXISTS currentWorkout;
CREATE TABLE currentWorkout(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    movement STRING NOT NULL,
    weight FLOAT NOT NULL,
    date STRING NOT NULL
    );
    
SELECT * FROM personalRecords;

BEGIN TRANSACTION;

    UPDATE personalRecords SET weight = 275.0, date = DATE('now') WHERE movement = 'squat(full ROM)';
    INSERT INTO currentWorkout(movement, weight, date)
        VALUES ('squat(full ROM)', 275.0, DATE('now'));
    
END TRANSACTION;

SELECT * FROM personalRecords;
SELECT * FROM currentWorkout;