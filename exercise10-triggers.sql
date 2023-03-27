/*EXERCISE 10: Triggers
While I've touched on triggered earlier, I was working ahead. This the college assignment regarding triggers.
*/

DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    customerId INTEGER NOT NULL,
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

SELECT * FROM customers;
SELECT * FROM reservations;

DROP TRIGGER IF EXISTS formatEntry;
CREATE TRIGGER formatEntry AFTER INSERT ON customers
BEGIN
    UPDATE customers SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    UPDATE costumers SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE phone NOT LIKE 'invalid%' AND CAST(phone AS INTEGER) IS NOT phone OR
            LENGTH(phone) !=10 AND phone NOT LIKE 'invalid%'; 
    -- This deletes entry if duplicate --
    DELETE FROM customers WHERE rowId NOT IN (
        SELECT min(rowId) FROM customers 
        GROUP BY phone);

    DELETE FROM reservations WHERE rowId NOT IN (
        SELECT MIN(rowid) FROM customers AS found
        WHERE reservations.customerId = found.customerId AND reservations.stayStart = found.stayStart);
END;

SELECT * FROM reservations
    JOIN customers ON reservations.customerId = customers.id;

END TRANSACTION;
BEGIN TRANSACTION;

    INSERT INTO customers(firstname, lastname, phone)
        VALUES('Jacob', 'Miller', '815-344-1446');
    
    INSERT INTO reservations(customerId, datePlaced, stayEnd, stayStart)
        VALUES(last_insert_rowid(), DATE('now'), DATE('now', '+1 day'), DATE('now', '+6 day'));
    
END TRANSACTION;