/*EXERCISE 10: Triggers
While I've touched on triggered earlier, I was working ahead. This the college assignment regarding triggers.
*/

DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    phone STRING NOT NULL,
    datePlaced STRING NOT NULL,
    stayEnd STRING NOT NULL,
    stayStart STRING NOT NULL
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstname STRING NOT NULL,
    lastname STRING NOT NULL,
    phone STRING NOT NULL
);

DROP TRIGGER IF EXISTS formatEntry;
CREATE TRIGGER formatEntry AFTER INSERT ON customers
BEGIN
    UPDATE customers SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    UPDATE customers SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE phone NOT LIKE 'invalid%' AND CAST(phone AS INTEGER) IS NOT phone OR
            LENGTH(phone) !=10 AND phone NOT LIKE 'invalid%'; 
    -- This deletes entry if duplicate --
    DELETE FROM customers WHERE rowId NOT IN (
        SELECT min(rowId) FROM customers 
        GROUP BY phone);
END;
DROP TRIGGER IF EXISTS formatReservations;
CREATE TRIGGER formatReservations AFTER INSERT ON reservations
BEGIN
    UPDATE reservations SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    UPDATE reservations SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE phone NOT LIKE 'invalid%' AND CAST(phone AS INTEGER) IS NOT phone OR
            LENGTH(phone) !=10 AND phone NOT LIKE 'invalid%'; 
    -- This deletes entry if duplicate --
    DELETE FROM reservations WHERE rowid >(
        SELECT MIN(rowid) FROM reservations AS found
        WHERE reservations.phone = found.phone AND reservations.stayStart = found.stayStart OR
        reservations.phone = found.phone AND reservations.stayEnd = found.stayEnd);
END;


SELECT * FROM reservations
    JOIN customers ON reservations.phone = customers.phone;
    

SELECT * FROM reservations;
SELECT * FROM customers;

BEGIN TRANSACTION;

    INSERT INTO customers(firstname, lastname, phone)
        VALUES(
        'jacob', 'miller', '815-344-1446'),
        ('chloe', 'skinner', '8026788894'),
        ('jake', 'miller', '8153441446'),
        ('jacob', 'miller', '815-344-1446');
    
    INSERT INTO reservations(phone, datePlaced, stayEnd, stayStart)
        VALUES(
        '815-344-1446', DATE('now'), DATE('now', '+1 day'), DATE('now', '+6 day')),
        ('8026788894', DATE('now'), DATE('now', '+1 day'), DATE('now', '+6 day')),
        ('815-344-1446', DATE('now'), DATE('now', '+1 day'), DATE('now', '+6 day')),
        ('815-344-1446', DATE('now'), DATE('now', '+13 day'), DATE('now', '+68 day'));
    
END TRANSACTION;

