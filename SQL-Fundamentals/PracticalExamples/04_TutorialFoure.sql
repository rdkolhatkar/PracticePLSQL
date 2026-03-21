-- =====================================================
-- EMPLOYEES TABLE SETUP
-- =====================================================

-- Drop the table if it already exists
-- How it works: Safely removes the employees table only if it exists.
--               Without IF EXISTS, MySQL/PostgreSQL raises an error when the table is missing.
DROP TABLE IF EXISTS employees;
/*
Output:
Query OK, 0 rows affected
*/

-- Create the employees table
-- How it works: Creates the employees table with 7 columns.
--               ⚠ SERIAL is a PostgreSQL shorthand for INT NOT NULL AUTO_INCREMENT with a sequence.
--               MySQL equivalent: employee_id INT PRIMARY KEY AUTO_INCREMENT.
--               CHECK (salary > 0) rejects zero or negative salaries.
--               CHECK (age >= 18) enforces a minimum age of 18 for all employees.
--               joining_date is NOT NULL, so it must always be provided during INSERT.
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2) CHECK (salary > 0),
    joining_date DATE NOT NULL,
    age INT CHECK (age >= 18)
);
/*
Output:
Query OK, 0 rows affected

MySQL equivalent for SERIAL:
    employee_id INT PRIMARY KEY AUTO_INCREMENT
*/

-- Insert sample data into employees table
-- How it works: Inserts 5 rows in a single multi-value INSERT statement.
--               employee_id is auto-assigned (1–5) by the SERIAL / AUTO_INCREMENT mechanism.
--               Each row's salary and age is validated against the CHECK constraints before insertion.
INSERT INTO employees (first_name, last_name, department, salary, joining_date, age) VALUES
('Amit', 'Sharma', 'IT', 60000.00, '2022-05-01', 29),
('Neha', 'Patel', 'HR', 55000.00, '2021-08-15', 32),
('Ravi', 'Kumar', 'Finance', 70000.00, '2020-03-10', 35),
('Anjali', 'Verma', 'IT', 65000.00, '2019-11-22', 28),
('Suresh', 'Reddy', 'Operations', 50000.00, '2023-01-10', 26);
/*
Output:
Query OK, 5 rows affected

Resulting table:
+-------------+------------+-----------+------------+----------+-------------+-----+
| employee_id | first_name | last_name | department | salary   | joining_date| age |
+-------------+------------+-----------+------------+----------+-------------+-----+
|           1 | Amit       | Sharma    | IT         | 60000.00 | 2022-05-01  |  29 |
|           2 | Neha       | Patel     | HR         | 55000.00 | 2021-08-15  |  32 |
|           3 | Ravi       | Kumar     | Finance    | 70000.00 | 2020-03-10  |  35 |
|           4 | Anjali     | Verma     | IT         | 65000.00 | 2019-11-22  |  28 |
|           5 | Suresh     | Reddy     | Operations | 50000.00 | 2023-01-10  |  26 |
+-------------+------------+-----------+------------+----------+-------------+-----+
*/

-- =====================================================
-- Q1: Retrieve all employees' first_name and their departments
-- =====================================================
-- How it works: SELECT with specific column names returns only those two columns.
--               No WHERE clause means all 5 rows are returned.
--               Rows appear in insertion order (primary-key order in InnoDB).
SELECT first_name, department
FROM employees;
/*
Output:
+------------+------------+
| first_name | department |
+------------+------------+
| Amit       | IT         |
| Neha       | HR         |
| Ravi       | Finance    |
| Anjali     | IT         |
| Suresh     | Operations |
+------------+------------+
5 rows in set
*/

-- =====================================================
-- Q2: Update the salary of all employees in the 'IT' department
--     by increasing it by 10%
-- =====================================================
-- How it works: SET salary = salary * 1.10 multiplies the current salary by 1.10,
--               effectively applying a 10% raise in a single expression.
--               WHERE department = 'IT' limits the update to IT employees only.
--               Amit: 60000.00 × 1.10 = 66000.00
--               Anjali: 65000.00 × 1.10 = 71500.00
--               Neha, Ravi, and Suresh are unaffected (different departments).
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT';
/*
Output:
Query OK, 2 rows affected
Rows matched: 2  Changed: 2  Warnings: 0

Table state after Q2:
+-------------+------------+-----------+------------+----------+-------------+-----+
| employee_id | first_name | last_name | department | salary   | joining_date| age |
+-------------+------------+-----------+------------+----------+-------------+-----+
|           1 | Amit       | Sharma    | IT         | 66000.00 | 2022-05-01  |  29 |
|           2 | Neha       | Patel     | HR         | 55000.00 | 2021-08-15  |  32 |
|           3 | Ravi       | Kumar     | Finance    | 70000.00 | 2020-03-10  |  35 |
|           4 | Anjali     | Verma     | IT         | 71500.00 | 2019-11-22  |  28 |
|           5 | Suresh     | Reddy     | Operations | 50000.00 | 2023-01-10  |  26 |
+-------------+------------+-----------+------------+----------+-------------+-----+
*/

-- =====================================================
-- Q3: Delete all employees who are older than 34 years
-- =====================================================
-- How it works: DELETE FROM removes entire rows (not columns) from the table.
--               WHERE age > 34 restricts deletion to employees whose age exceeds 34.
--               Ravi Kumar (age = 35) is the only employee older than 34 → deleted.
--               All other employees (ages 29, 32, 28, 26) are unaffected.
--               ⚠ Always run SELECT ... WHERE age > 34 first to preview affected rows
--               before executing DELETE in a production environment.
DELETE FROM employees
WHERE age > 34;
/*
Output:
Query OK, 1 row affected
Note: Ravi Kumar (employee_id = 3, age = 35) is permanently deleted.

Table state after Q3:
+-------------+------------+-----------+------------+----------+-------------+-----+
| employee_id | first_name | last_name | department | salary   | joining_date| age |
+-------------+------------+-----------+------------+----------+-------------+-----+
|           1 | Amit       | Sharma    | IT         | 66000.00 | 2022-05-01  |  29 |
|           2 | Neha       | Patel     | HR         | 55000.00 | 2021-08-15  |  32 |
|           4 | Anjali     | Verma     | IT         | 71500.00 | 2019-11-22  |  28 |
|           5 | Suresh     | Reddy     | Operations | 50000.00 | 2023-01-10  |  26 |
+-------------+------------+-----------+------------+----------+-------------+-----+
4 rows in set
Note: employee_id = 3 is gone and will NOT be reused by AUTO_INCREMENT.
*/

-- =====================================================
-- Q4: Add a new column `email` to the employees table
-- =====================================================
-- How it works: ALTER TABLE ADD COLUMN adds a new column to the existing table
--               without dropping or recreating it. Existing rows are unaffected —
--               MySQL fills the new email column with NULL for all current rows
--               since no DEFAULT value or NOT NULL constraint is specified.
ALTER TABLE employees
ADD COLUMN email VARCHAR(100);
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: All 4 existing rows now have email = NULL.
      The column can be populated later with UPDATE statements.
*/

-- =====================================================
-- Q5: Rename the `department` column to `dept_name`
-- =====================================================
-- How it works: RENAME COLUMN changes only the column's name.
--               All data, data types, and constraints on the column remain intact.
--               Available in MySQL 8.0+ and PostgreSQL.
--               After this step, any query still referencing 'department' will fail
--               with "Unknown column 'department'".
ALTER TABLE employees
RENAME COLUMN department TO dept_name;
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: The column is now referenced as dept_name in all future queries.
      Using 'department' in any subsequent query will cause an error.
*/

-- =====================================================
-- Q6: Retrieve the names of employees who joined after
--     January 1, 2021
-- =====================================================
-- How it works: WHERE joining_date > '2021-01-01' compares DATE values chronologically.
--               Strictly greater than means '2021-01-01' itself is excluded.
--               Amit (2022-05-01) ✓, Neha (2021-08-15) ✓, Suresh (2023-01-10) ✓.
--               Anjali (2019-11-22) joined before 2021 → excluded.
--               Ravi was already deleted in Q3.
SELECT first_name, last_name, joining_date
FROM employees
WHERE joining_date > '2021-01-01';
/*
Output:
+------------+-----------+--------------+
| first_name | last_name | joining_date |
+------------+-----------+--------------+
| Amit       | Sharma    | 2022-05-01   |
| Neha       | Patel     | 2021-08-15   |
| Suresh     | Reddy     | 2023-01-10   |
+------------+-----------+--------------+
3 rows in set
*/

-- =====================================================
-- Q7: Change the data type of the salary column to INTEGER
-- =====================================================
-- How it works (PostgreSQL): ALTER COLUMN ... TYPE ... USING is PostgreSQL syntax.
--               USING salary::INTEGER tells PostgreSQL how to cast the existing
--               DECIMAL values to INTEGER — any fractional part is truncated (not rounded).
--               e.g. 66000.00 → 66000, 71500.00 → 71500 (no fractional loss here).
--               ⚠ This syntax is NOT supported in MySQL.
--               MySQL equivalent: ALTER TABLE employees MODIFY COLUMN salary INT;
ALTER TABLE employees
ALTER COLUMN salary TYPE INTEGER
USING salary::INTEGER;
/*
Output (PostgreSQL):
ALTER TABLE

MySQL equivalent:
ALTER TABLE employees MODIFY COLUMN salary INT;
Output: Query OK, 4 rows affected

Table state after Q7 (salary now stored as INTEGER, .00 suffix dropped):
+-------------+------------+-----------+-----------+--------+--------------+-----+-------+
| employee_id | first_name | last_name | dept_name | salary | joining_date | age | email |
+-------------+------------+-----------+-----------+--------+--------------+-----+-------+
|           1 | Amit       | Sharma    | IT        |  66000 | 2022-05-01   |  29 | NULL  |
|           2 | Neha       | Patel     | HR        |  55000 | 2021-08-15   |  32 | NULL  |
|           4 | Anjali     | Verma     | IT        |  71500 | 2019-11-22   |  28 | NULL  |
|           5 | Suresh     | Reddy     | Operations|  50000 | 2023-01-10   |  26 | NULL  |
+-------------+------------+-----------+-----------+--------+--------------+-----+-------+
Note: All decimal values here had no fractional part, so no data is lost during truncation.
      Caution: a value like 66000.75 would become 66000 (fractional part silently dropped).
*/

-- =====================================================
-- Q8: List all employees with their age and salary in
--     descending order of salary
-- =====================================================
-- How it works: ORDER BY salary DESC sorts rows from the highest salary to the lowest.
--               No WHERE clause — all 4 remaining employees are included.
--               Anjali (71500) appears first; Suresh (50000) appears last.
SELECT first_name, age, salary
FROM employees
ORDER BY salary DESC;
/*
Output:
+------------+-----+--------+
| first_name | age | salary |
+------------+-----+--------+
| Anjali     |  28 |  71500 |
| Amit       |  29 |  66000 |
| Neha       |  32 |  55000 |
| Suresh     |  26 |  50000 |
+------------+-----+--------+
4 rows in set
*/

-- =====================================================
-- Q9: Insert a new employee with the following details:
--     ('Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30)
-- =====================================================
-- How it works: The INSERT uses dept_name (the renamed column from Q5).
--               Using the old name 'department' here would cause an error.
--               employee_id is auto-assigned as 6 by SERIAL / AUTO_INCREMENT.
--               (Note: even though employee_id = 3 was deleted, AUTO_INCREMENT
--               continues from the last used value — it does NOT reuse 3.)
INSERT INTO employees (first_name, last_name, dept_name, salary, joining_date, age)
VALUES ('Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30);
/*
Output:
Query OK, 1 row affected

Table state after Q9:
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
| employee_id | first_name | last_name | dept_name  | salary | joining_date | age | email |
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
|           1 | Amit       | Sharma    | IT         |  66000 | 2022-05-01   |  29 | NULL  |
|           2 | Neha       | Patel     | HR         |  55000 | 2021-08-15   |  32 | NULL  |
|           4 | Anjali     | Verma     | IT         |  71500 | 2019-11-22   |  28 | NULL  |
|           5 | Suresh     | Reddy     | Operations |  50000 | 2023-01-10   |  26 | NULL  |
|           6 | Raj        | Singh     | Marketing  |  60000 | 2023-09-15   |  30 | NULL  |
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
5 rows in set
Note: employee_id = 6 (not 3) because AUTO_INCREMENT never reuses deleted IDs.
*/

-- =====================================================
-- Q10: Update age of every employee by adding 1 year
-- =====================================================
-- How it works: SET age = age + 1 increments the current age by 1 for every row.
--               No WHERE clause means ALL employees are updated — use with care.
--               This is a bulk update; 5 rows are affected.
UPDATE employees
SET age = age + 1;
/*
Output:
Query OK, 5 rows affected
Rows matched: 5  Changed: 5  Warnings: 0

Table state after Q10:
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
| employee_id | first_name | last_name | dept_name  | salary | joining_date | age | email |
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
|           1 | Amit       | Sharma    | IT         |  66000 | 2022-05-01   |  30 | NULL  |
|           2 | Neha       | Patel     | HR         |  55000 | 2021-08-15   |  33 | NULL  |
|           4 | Anjali     | Verma     | IT         |  71500 | 2019-11-22   |  29 | NULL  |
|           5 | Suresh     | Reddy     | Operations |  50000 | 2023-01-10   |  27 | NULL  |
|           6 | Raj        | Singh     | Marketing  |  60000 | 2023-09-15   |  31 | NULL  |
+-------------+------------+-----------+------------+--------+--------------+-----+-------+
*/

-- =====================================================
-- Q11 (NEW): List all employees with their age and salary
--            in ascending order of salary
-- =====================================================
-- How it works: ORDER BY salary ASC sorts rows from lowest salary to highest.
--               ASC is the default direction and can be omitted, but is written explicitly here.
--               No WHERE clause — all 5 employees are included.
--               Suresh (50000) appears first; Anjali (71500) appears last.
SELECT first_name, age, salary
FROM employees
ORDER BY salary ASC;
/*
Output:
+------------+-----+--------+
| first_name | age | salary |
+------------+-----+--------+
| Suresh     |  27 |  50000 |
| Neha       |  33 |  55000 |
| Raj        |  31 |  60000 |
| Amit       |  30 |  66000 |
| Anjali     |  29 |  71500 |
+------------+-----+--------+
5 rows in set
Note: Ages shown here reflect the values after the Q10 bulk update (age + 1).
      This is the final state of the table.
*/