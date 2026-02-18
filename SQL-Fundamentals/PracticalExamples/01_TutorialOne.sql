-- ------------------------------------------------------------
-- Difference between: CREATE DATABASE and CREATE SCHEMA
--   CREATE DATABASE company;
--   CREATE SCHEMA company;
-- In MySQL:
-- ------------------------------------------------------------
-- 1) There is NO difference between CREATE DATABASE and CREATE SCHEMA.
-- 2) CREATE SCHEMA is simply a synonym for CREATE DATABASE.
-- 3) Both commands create a new database named "company".
-- 4) Internally, MySQL treats a SCHEMA as a DATABASE.
-- 5) Both allow storing tables, views, procedures, triggers, etc.
--
-- Example (both are identical in MySQL):
-- CREATE DATABASE company;
-- CREATE SCHEMA company;
-- ------------------------------------------------------------
-- In other SQL systems (PostgreSQL, SQL Server, Oracle):
-- ------------------------------------------------------------
-- 1) DATABASE and SCHEMA are different.
-- 2) A DATABASE is a complete container.
-- 3) A SCHEMA is a namespace inside a database (like a folder).
-- 4) These systems allow multiple schemas inside one database.
--
-- Example (PostgreSQL):
--   Database: company_db
--   Schemas inside it: hr, sales, accounts
-- ------------------------------------------------------------
-- MySQL Example For Creating Database and Schema:
CREATE DATABASE company;

-- In MySQL, the command SHOW DATABASES; will list all the databases (schemas) available in the MySQL server. Since CREATE SCHEMA is a synonym for CREATE DATABASE in MySQL, both commands will create a database that can be listed with SHOW DATABASES;.
SHOW DATABASES; 

-- On Windows and MacOS, Database name is case-insensitive, so "company", "Company", and "COMPANY" would all refer to the same database. However, on Linux, MySQL treats database names as case-sensitive by default, so "company", "Company", and "COMPANY" would be considered different databases. This behavior can be changed by setting the lower_case_table_names system variable in MySQL configuration.

SELECT DATABASE(); -- This command will show the current database you are connected to.
-- Database() is a MySQL function that returns the name of the current database you are connected to. If you have not selected a database, it will return NULL.

CREATE SCHEMA company;

-- PosgreSQL Example:
CREATE DATABASE company_db;

CREATE SCHEMA hr;

-- MySQL Example For Using Database/Schema:
USE company;

-- PosgreSQL Example:
-- In postgreSQL, We cannot use USE command. Instead, we have to open the SQL Query tab inside the datbase manually.
-- To set SQL Query tab inside the datbase manually first right click on the database name and then click on the option "Query Tool".
-- Then do the right click on the database name and then click on refresh button.
CREATE SCHEMA hr;

SET
    search_path TO hr;

-- MySQL example of creating table inside database/schema:
CREATE TABLE company.employees (
    id INT PRIMARY KEY,
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

-- MySQL example of Selecting data from table inside database/schema:
SELECT * FROM company.employees;
-- PosgreSQL example of Selecting data from table inside schema:
SELECT * FROM hr.employees;
-- ------------------------------------------------------------