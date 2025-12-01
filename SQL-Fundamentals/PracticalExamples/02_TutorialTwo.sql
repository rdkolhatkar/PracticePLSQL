-- MySQL example of creating table inside database/schema:
CREATE TABLE company.employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
-- PosgreSQL example of creating table inside schema:
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);

-- MySQL example for inserting data into table inside database/schema:
INSERT INTO company.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith', '2019-03-22', 55000.00),
('Charlie Brown', '2021-07-30', 70000.00);
-- PosgreSQL example for inserting data into table inside schema:
INSERT INTO hr.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith', '2019-03-22', 55000.00),
('Charlie Brown', '2021-07-30', 70000.00);

-- MySQL exampe for altering table/column inside table in database/schema:
ALTER TABLE company.employees
RENAME COLUMN hire_date TO date_hired;
-- PosgreSQL example for altering table/column inside table in schema:      
ALTER TABLE hr.employees
RENAME COLUMN hire_date TO date_hired;

-- MYSQL example for inserting new column into table inside database/schema:
ALTER TABLE company.employees   
ADD COLUMN department VARCHAR(50);
-- PosgreSQL example for inserting new column into table inside schema: 
ALTER TABLE hr.employees   
ADD COLUMN department VARCHAR(50);

-- MySQL example for updating data inside table in database/schema:
UPDATE company.employees
SET salary = salary * 1.05
WHERE date_hired < '2020-01-01';
-- PosgreSQL example for updating data inside table in schema:
UPDATE hr.employees 
SET salary = salary * 1.05
WHERE date_hired < '2020-01-01';

-- MySQL example for deleting data inside table in database/schema:
DELETE FROM company.employees
WHERE name = 'Bob Smith';   
-- PosgreSQL example for deleting data inside table in schema:
DELETE FROM hr.employees
WHERE name = 'Bob Smith';

-- MySQL example for dropping table inside database/schema:
DROP TABLE company.employees;
-- PosgreSQL example for dropping table inside schema:
DROP TABLE hr.employees;

-- MySQL example for truncating table inside database/schema:
TRUNCATE TABLE company.employees;
-- PosgreSQL example for truncating table inside schema:
TRUNCATE TABLE hr.employees;    

-- MySQL example for truncating table inside database/schema with restart identity:
TRUNCATE TABLE company.employees RESTART IDENTITY;
-- PosgreSQL example for truncating table inside schema with restart identity:
TRUNCATE TABLE hr.employees RESTART IDENTITY;    

-- MySQL example for dropping database/schema:
DROP DATABASE company;
-- PosgreSQL example for dropping schema:
DROP SCHEMA hr CASCADE;
-- Note: In PostgreSQL, CASCADE is used to drop all objects in the schema.

