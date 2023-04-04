-- Module 11 -- SUBSELECT & VIEWS

DROP TABLE IF EXISTS employeeA;
DROP TABLE IF EXISTS employeeB;
CREATE TABLE employeeA(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name STRING NOT NULL,
    salary INTEGER
    );
    
CREATE TABLE employeeB(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name STRING NOT NULL,
    salary INTEGER
    );

INSERT INTO employeeA(name, salary)
    VALUES("Jacob", 65000), ("Chloe", 67000), ("Nicholas", 15000);
INSERT INTO employeeB(name, salary)
    VALUES("Derek", 19000), ("AJ", 79000);
    

SELECT * FROM employeeA;
SELECT * FROM employeeB;

DROP VIEW IF EXISTS highestPaidA;
CREATE VIEW highestPaidA AS
    SELECT name, MAX(salary) AS salary FROM employeeA;
    
DROP VIEW IF EXISTS highestPaidB;
CREATE VIEW highestPaidB AS
    SELECT name, MAX(salary) AS salary FROM employeeB;
    

SELECT name, salary FROM HighestPaidB
    WHERE salary > 
    (SELECT salary FROM HighestPaidA);