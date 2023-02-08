/* Small SQLite exercise for practice adding,
deleting, altering tables; filtering values and
working with ids, conditionals, and removing duplicates.
*/
-- Exercise 3 --
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT,
    email TEXT NOT NULL,
    phone INTEGER DEFAULT 'notEntered');

-- DATA INSERTS --
INSERT INTO users(username, email, phone) 
    VALUES
    ('jmiller', 'jmiller@stsudents.mchenry.edu', '815 3441 446'),
    ('emilyStone05', 'estone7571@students.mchenry.edu', NULL);  
INSERT INTO users(email)
    VALUES
    ('someone@hotmail.com'),
    ('someone2@hotmail.com');
    
SELECT * FROM users;
SELECT DISTINCT username FROM users WHERE username IS NOT NULL;

DELETE FROM users WHERE username IS NULL;

ALTER TABLE users ADD password TEXT DEFAULT 'password';
UPDATE users SET password = 'newPassword11' WHERE username = 'jmiller';

-- HANDLING DUPLICATES --
-- insert duplicates --
INSERT INTO users(email)
    VALUES
    ('not dup'),
    ('someone@hotmail.com'),
    ('someone@hotmail.com'),
    ('Jmiller@hotmail.com');

-- DELETE DUPLICATE DOCS --
SELECT * FROM users;

SELECT rowid FROM users WHERE email = 'Jmiller@hotmail.com';
SELECT MIN(rowid) FROM users;

--clear duplicated data where emails match.
DELETE FROM users WHERE rowid >(
    SELECT MIN(rowid) FROM users AS found
    WHERE users.email = found.email);