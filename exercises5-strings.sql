/*MODULE 5: EXERCISE STRING MANIPULATION
A short exercise that takes user data inputs and corrects them.
This keeps the formatting in the database conisistent
THIS IS AN UPDATE ON MODULE 3: EXERCISES.*/

-- EXERCISE 5 --
-- CREATE TABLE --
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT,
    email TEXT NOT NULL,
    phone INTEGER DEFAULT 'notEntered');

-- CREATE TRIGGERS --
DROP TRIGGER IF EXISTS formatEntry;
CREATE TRIGGER formatEntry AFTER INSERT ON users
BEGIN

    UPDATE users 
        SET email = REPLACE(email, ' ', ''),
        email = REPLACE(email, email, LOWER(email));
        
    UPDATE users SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    UPDATE users SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE LENGTH(phone)!=10 AND phone NOT LIKE 'invalid%'; 

    -- This deletes entry if duplicate --
    DELETE FROM users WHERE rowId NOT IN (
        SELECT min(rowId) FROM users 
        GROUP BY email);
        
    /*DELETE FROM users WHERE rowid >(
        SELECT MIN(rowid) FROM users AS found
        WHERE users.email = found.email);*/
END;
    
-- COMMAND --
INSERT INTO users(username, email, phone) 
    VALUES
    ('jmiller', 'JmiLler@students.mchenry. edu', '815 3441 446'),
    ('emilyStone05', 'estone7571@students.mchenry.edu', '20'),
    ('kanaKuromiya', 'adrenalineJunkie0559@gmail.com', '815-728-9989');  

INSERT INTO users(email)
    VALUES
    ('not DUP'),
    ('someone @hotmail.com'),
    ('someone@hotmail.com');

SELECT * FROM users;

