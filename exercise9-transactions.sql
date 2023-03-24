/*EXERCISE 9: Transactions
This is a simple exercise working with transcations that updates two tables
together.
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

SELECT * FROM reservations
    JOIN customers ON reservations.customerId = customers.id;

END TRANSACTION;
BEGIN TRANSACTION;

    INSERT INTO customers(firstname, lastname, phone)
        VALUES('Jacob', 'Miller', '815-344-1446');
    
    INSERT INTO reservations(customerId, datePlaced, stayEnd, stayStart)
        VALUES(last_insert_rowid(), DATE('now'), DATE('now', '+1 day'), DATE('now', '+6 day'));
    
END TRANSACTION;


