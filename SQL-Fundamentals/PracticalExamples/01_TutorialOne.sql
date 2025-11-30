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