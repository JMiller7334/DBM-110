/*MODULE 6: NUMBERS
further building on my previous database I've added several
new columns to the users table and fixed an issue with the
format trigger that allowed invalid strings that were 10 chars
long to bypass being marked as invalid. 

database now creates two views for seperating users by age
showing the avg age and round that while keeping 2 decimal places.
*/

-- CREATE TABLE --
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT,
    email TEXT NOT NULL,
    phone TEXT DEFAULT 'notEntered',
    gender TEXT,
    age INTEGER DEFAULT -1); -- -1 indicates an age was not defined.

-- CREATE TRIGGERS --
DROP TRIGGER IF EXISTS formatEntry;
CREATE TRIGGER formatEntry AFTER INSERT ON users
BEGIN

    UPDATE users 
        SET email = REPLACE(email, ' ', ''),
        email = REPLACE(email, email, LOWER(email));
        
    UPDATE users SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    

    UPDATE users SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE phone NOT LIKE 'invalid%' AND CAST(phone AS INTEGER) IS NOT phone OR
            LENGTH(phone) !=10 AND phone NOT LIKE 'invalid%'; 

    -- This deletes entry if duplicate --
    DELETE FROM users WHERE rowId NOT IN (
        SELECT min(rowId) FROM users 
        GROUP BY email);
END;
-- CREATE VIEW --
DROP VIEW IF EXISTS [avg age females];
CREATE VIEW [avg age females] AS
    SELECT ROUND(AVG(age)/1.0, 2) || "yrs" AS [users:average age females] FROM users
    WHERE UPPER(gender) = 'F' AND age > 0;
    
DROP VIEW IF EXISTS [avg age males];
CREATE VIEW [avg age males] AS
    SELECT ROUND(AVG(age)/1.0, 2) || "yrs" AS [users:average age males] FROM users
    WHERE UPPER(gender) = 'M' AND age > 0;

-- COMMAND --
INSERT INTO users(username, email, phone, gender, age) 
    VALUES
    ('jacobMiller', 'JmiLler@students.mchenry. edu', '815 3441 446', 'M', 29),
    ('Tilak_Patel', 'Tpatel@nyCityMed.edu', 'abdabdabds', 'm', 25),
    ('emilyStone05', 'estone7571@students.mchenry.edu', '20', 'F', 19),
    ('kanaKuromiya', 'adrenalineJunkie0559@gmail.com', '815-728-9989', 'F', 24),
    ('chloe_s', 'chloeCocoa@Gmail.com', '', 'f', 21);  

INSERT INTO users(email, gender, age)
    VALUES
    ('not DUP', 'm', -1),
    ('someone @hotmail.com', 'f', -1),
    ('someone@hotmail.com', 'f', -1);

SELECT * FROM users;
SELECT * FROM [avg age females];
SELECT * FROM [avg age males];