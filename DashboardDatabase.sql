-- CREATE TABLES --
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstName STRING NOT NULL,
    lastName STRING NOT NULL,
    address STRING NOT NULL,
    phone STRING NOT NULL,
    email STRING DEFAULT 'notEntered',
    type STRING NOT NULL
);
DROP TABLE IF EXISTS usage;
CREATE TABLE usage(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    customerId INTEGER NOT NULL,
    month STRING NOT NULL,
    usage DOUBLE NOT NULL
);

-- CREATE TRIGGERS --
DROP TRIGGER IF EXISTS formatCustomer;
CREATE TRIGGER formatCustomer AFTER INSERT ON customers
BEGIN
    UPDATE customers SET firstName = REPLaCE(firstName, firstName, LOWER(firstName));
    UPDATE customers SET lastName = REPLACE(lastName, lastName, LOWER(lastName));
    UPDATE customers SET address = REPLACE(address, address, LOWER(address));

    UPDATE customers SET email = REPLACE(email, ' ', '');
    UPDATE customers SET email = REPLACE(email, email, LOWER(email));
        
    UPDATE customers SET phone = REPLACE(REPLACE(phone, ' ', ''),'-', '');
    UPDATE customers SET phone = REPLACE(phone, phone, 'invalid('||phone||')') 
            WHERE phone NOT LIKE 'invalid%' AND CAST(phone AS INTEGER) IS NOT phone OR
            LENGTH(phone) !=10 AND phone NOT LIKE 'invalid%'; 
END;

DROP TRIGGER IF EXISTS formatUsage;
CREATE TRIGGER formatUsage AFTER INSERT ON usage
BEGIN
    UPDATE usage SET usage = REPLACE(usage, usage, CAST(usage AS DOUBLE));
END;

INSERT INTO customers(firstName, lastName, address, phone, email, type)
    VALUES
    ('Jacob', 'Miller', '1813 Grandview Dr.', '815-344-1446', 'Jmiller@student.com', 'standard');
    
INSERT INTO usage(customerId, month, usage)
    VALUES
    (2, 'march', '10045');
    
SELECT * FROM customers;
SELECT * FROM usage;