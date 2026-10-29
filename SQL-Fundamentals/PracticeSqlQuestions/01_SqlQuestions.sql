-- =====================================================================
-- Problem: Find the second highest salary of an employee
-- Database: PracticeQuestions (MySQL)
-- =====================================================================


-- =====================================================================
-- 1. CREATE SCHEMA (database)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS PracticeQuestions;
USE PracticeQuestions;

-- Drop the table if it already exists so the script can be re-run cleanly
DROP TABLE IF EXISTS Employee;


-- =====================================================================
-- 2. CREATE TABLE
-- =====================================================================
CREATE TABLE Employee (
    id     INT PRIMARY KEY,        -- Unique employee identifier
    name   VARCHAR(100) NOT NULL,  -- Employee name
    salary INT NOT NULL            -- Employee salary
);


-- =====================================================================
-- 3. INSERT SAMPLE RECORDS
-- =====================================================================
INSERT INTO Employee (id, name, salary) VALUES
(1, 'Alice', 100),
(2, 'Bob',   200),
(3, 'Carol', 300),
(4, 'Dave',  300),   -- duplicate highest salary to test DISTINCT handling
(5, 'Eve',   150);

-- View the table contents
-- Expected output:
-- +----+-------+--------+
-- | id | name  | salary |
-- +----+-------+--------+
-- |  1 | Alice |    100 |
-- |  2 | Bob   |    200 |
-- |  3 | Carol |    300 |
-- |  4 | Dave  |    300 |
-- |  5 | Eve   |    150 |
-- +----+-------+--------+
SELECT * FROM Employee;


-- =====================================================================
-- 4. SOLUTION - APPROACH 1: DISTINCT + ORDER BY + LIMIT/OFFSET
-- =====================================================================
-- DISTINCT   : removes duplicate salaries so 300 (Carol & Dave) counts once
-- ORDER BY   : sorts salaries from highest to lowest
-- LIMIT 1 OFFSET 1 : skips the highest value and returns the next one
-- Expected output: 200
SELECT DISTINCT salary AS SecondHighestSalary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


-- =====================================================================
-- 5. SOLUTION - APPROACH 2: SUBQUERY WITH MAX
-- =====================================================================
-- Inner query : finds the highest salary (300)
-- Outer query : finds the largest salary strictly less than that maximum
-- Expected output: 200
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
-- -----------------------------------------------------------------------
SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);


-- =====================================================================
-- 6. HANDLING THE "NO SECOND HIGHEST" CASE
-- =====================================================================
-- If there is no second highest salary, the query should return NULL
-- instead of an empty result. Wrapping the query in a scalar subquery
-- guarantees a single row with NULL when nothing is found.
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;


-- =====================================================================
-- 7. EDGE CASE TEST: only one distinct salary -> expected NULL
-- =====================================================================
DROP TABLE IF EXISTS EmployeeSingle;
CREATE TABLE EmployeeSingle (
    id     INT,
    salary INT
);
INSERT INTO EmployeeSingle VALUES (1, 500), (2, 500);

-- Expected output: NULL
SELECT (
    SELECT DISTINCT salary
    FROM EmployeeSingle
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;

-- Clean up the test table
DROP TABLE EmployeeSingle;