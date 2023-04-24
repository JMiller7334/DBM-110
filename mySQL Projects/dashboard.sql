/*MYSQL - SQL
this code has been convert from code for SQLite Studio to code meant for mySQL.

PROJECT GOALS:
create code the runs within mySQL & mySQLWorkBench.
Learn new syntax for SQL.
*/
-- CREATE TABLES --
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
    id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) DEFAULT 'notEntered',
    customer_type VARCHAR(255) NOT NULL
);
DROP TABLE IF EXISTS usage_data;
CREATE TABLE usage_data(
    id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    customerId INTEGER(255) NOT NULL,
    usage_month VARCHAR(255) NOT NULL,
    customer_usage DOUBLE NOT NULL
);

-- CREATE TRIGGERS --
/* NOTE: Delimiter is set as // means we are using // to indicate the end of the statement, since this
trigger uses multiple ;s already required - the delimiter must be set to // to indicate the finish of the 
trigger and should be reverted back to ; after the func/trigger/etc is finished*/

DROP TRIGGER IF EXISTS formatEntry;
DELIMITER //
CREATE TRIGGER formatEntry BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
	SET NEW.firstName = LOWER(NEW.firstName);
    SET NEW.lastName = LOWER(NEW.lastName);
    SET NEW.address = LOWER(NEW.address);
    SET NEW.email = REPLACE(NEW.email, ' ', '');
    SET NEW.email = LOWER(NEW.email);
    
    SET NEW.phone = REPLACE(REPLACE(NEW.phone, ' ', ''),'-', '');
    
	IF NEW.phone NOT LIKE 'invalid%' AND (CAST(NEW.phone AS UNSIGNED INTEGER) IS NULL OR LENGTH(NEW.phone) != 10) THEN
		SET NEW.phone = CONCAT('invalid(', NEW.phone, ')');
	END IF;
END//
DELIMITER ;


DROP TRIGGER IF EXISTS formatUsage;
DELIMITER //
CREATE TRIGGER formatUsage BEFORE INSERT ON usage_data
FOR EACH ROW
BEGIN
    SET NEW.customer_usage = REPLACE(NEW.customer_usage, NEW.customer_usage, CAST(NEW.customer_usage AS DOUBLE));
END//
DELIMITER ;


-- INSERT AND COMMANDS --
INSERT INTO customers(firstName, lastName, address, phone, email, customer_type)
    VALUES
    ('jacob', 'Miller', '1813 Grandview Dr.', '815-344 1446', 'Jmiller@student.com', 'standard');
    
INSERT INTO usage_data(customerId, usage_month, customer_usage) 
    VALUES
    (2, 'march', 10045);
    
    
SELECT * FROM customers;
SELECT * FROM usage_data;