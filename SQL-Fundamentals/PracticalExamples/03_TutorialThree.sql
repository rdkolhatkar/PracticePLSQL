-- =====================================================
-- TABLE CREATION
-- =====================================================

-- MySQL example of creating table inside database/schema:
-- How it works: Creates the employees table with 6 columns.
--               AUTO_INCREMENT automatically assigns the next integer value to employee_id
--               on every INSERT (MySQL-specific keyword).
--               DECIMAL(10,2) stores exact numeric values with up to 10 total digits
--               and exactly 2 digits after the decimal point.
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2)
);
/*
Output (MySQL):
Query OK, 0 rows affected
*/

-- PostgreSQL example of creating table inside schema:
-- How it works: Functionally identical to the MySQL version above, but uses
--               PostgreSQL-specific syntax differences:
--               SERIAL is a PostgreSQL shorthand that creates an integer column backed
--               by an auto-incrementing sequence — equivalent to MySQL's INT AUTO_INCREMENT.
--               NUMERIC(10,2) is the PostgreSQL equivalent of MySQL's DECIMAL(10,2).
--               Both store exact fixed-point numbers with 2 decimal places.
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary NUMERIC(10,2)
);
/*
Output (PostgreSQL):
CREATE TABLE

Key syntax differences:
+------------------+-------------------------+---------------------------+
| Feature          | MySQL                   | PostgreSQL                |
+------------------+-------------------------+---------------------------+
| Auto-increment   | INT AUTO_INCREMENT      | SERIAL                    |
| Exact decimal    | DECIMAL(10,2)           | NUMERIC(10,2)             |
| Success message  | Query OK, 0 rows aff.   | CREATE TABLE              |
+------------------+-------------------------+---------------------------+
*/

-- =====================================================
-- INSERTING DATA
-- =====================================================

-- MySQL example of Inserting data into table inside database/schema:
-- How it works: Inserts 5 rows in a single multi-value INSERT statement.
--               employee_id is omitted — AUTO_INCREMENT assigns 1 through 5 automatically.
--               NOT NULL on employee_name means all 5 names must be provided.
--               All other columns (position, department, hire_date, salary) allow NULL
--               but are supplied here with actual values.
INSERT INTO employees (employee_name, position, department, hire_date, salary) VALUES
('John Doe', 'Software Engineer', 'IT', '2022-01-15', 65000.00),
('Priya Sharma', 'QA Analyst', 'Quality Assurance', '2021-03-10', 52000.00),
('Michael Brown', 'Project Manager', 'Management', '2020-11-01', 85000.00),
('Anita Desai', 'HR Executive', 'Human Resources', '2023-06-18', 45000.00),
('Rakesh Kumar', 'Data Analyst', 'Analytics', '2022-09-25', 60000.00);
/*
Output (MySQL):
Query OK, 5 rows affected

Resulting table:
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  65000.00 |
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           3 | Michael Brown | Project Manager   | Management        | 2020-11-01 |  85000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+
*/

-- PostgreSQL example of Inserting data into table inside schema:
-- How it works: The INSERT syntax is identical to MySQL here.
--               PostgreSQL uses its SERIAL sequence to auto-assign employee_id values.
--               The only behavioral difference: PostgreSQL reports the number of rows
--               inserted differently in its output message.
INSERT INTO employees (employee_name, position, department, hire_date, salary) VALUES
('John Doe', 'Software Engineer', 'IT', '2022-01-15', 65000.00),
('Priya Sharma', 'QA Analyst', 'Quality Assurance', '2021-03-10', 52000.00),
('Michael Brown', 'Project Manager', 'Management', '2020-11-01', 85000.00),
('Anita Desai', 'HR Executive', 'Human Resources', '2023-06-18', 45000.00),
('Rakesh Kumar', 'Data Analyst', 'Analytics', '2022-09-25', 60000.00);
/*
Output (PostgreSQL):
INSERT 0 5

Resulting table: (identical to MySQL result above)
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  65000.00 |
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           3 | Michael Brown | Project Manager   | Management        | 2020-11-01 |  85000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 5 rows affected |
| PostgreSQL | INSERT 0 5                |
+------------+---------------------------+
*/

-- =====================================================
-- DELETING DATA
-- =====================================================

-- MySQL example of deleting data from table inside database/schema:
-- How it works: DELETE FROM removes entire rows (not individual columns) from the table.
--               WHERE employee_id = 3 targets only the row where employee_id equals 3.
--               Michael Brown (Project Manager, Management, 85000.00) is permanently deleted.
--               All other rows are unaffected.
--               ⚠ Always run SELECT * FROM employees WHERE employee_id = 3 first
--               to preview the row before deleting in a production environment.
DELETE FROM employees WHERE employee_id = 3;
/*
Output (MySQL):
Query OK, 1 row affected

Table state after DELETE:
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  65000.00 |
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+
Note: employee_id = 3 is gone permanently. AUTO_INCREMENT / SERIAL will NOT reuse it —
      the next inserted row will receive employee_id = 6.
*/

-- PostgreSQL example of deleting data from table inside schema:
-- How it works: Identical syntax to MySQL. The DELETE behavior is the same —
--               only the success message format differs.
DELETE FROM employees WHERE employee_id = 3;
/*
Output (PostgreSQL):
DELETE 1

Table state after DELETE: (identical to MySQL result above)
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  65000.00 |
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 1 row affected  |
| PostgreSQL | DELETE 1                  |
+------------+---------------------------+
*/

-- =====================================================
-- UPDATING DATA
-- =====================================================

-- MySQL example of updating data in table inside database/schema:
-- How it works: SET salary = 70000.00 replaces the existing salary value for the targeted row.
--               WHERE employee_id = 1 limits the update to John Doe's row only.
--               John Doe's salary changes from 65000.00 to 70000.00 — a raise of 5000.00.
--               All other rows remain unchanged.
UPDATE employees SET salary = 70000.00 WHERE employee_id = 1;
/*
Output (MySQL):
Query OK, 1 row affected
Rows matched: 1  Changed: 1  Warnings: 0

Table state after UPDATE:
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  70000.00 |  ← updated
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+
*/

-- PostgreSQL example of updating data in table inside schema:
-- How it works: Identical syntax to MySQL. The UPDATE behavior is the same —
--               only the success message format differs.
UPDATE employees SET salary = 70000.00 WHERE employee_id = 1;
/*
Output (PostgreSQL):
UPDATE 1

Table state after UPDATE: (identical to MySQL result above)
+-------------+---------------+-------------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | department        | hire_date  | salary    |
+-------------+---------------+-------------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | IT                | 2022-01-15 |  70000.00 |  ← updated
|           2 | Priya Sharma  | QA Analyst        | Quality Assurance | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | Human Resources   | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | Analytics         | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+-------------------+------------+-----------+

Output message difference:
+------------+---------------------------------------------+
| Database   | Success message                             |
+------------+---------------------------------------------+
| MySQL      | Query OK, 1 row affected, Rows matched: 1   |
| PostgreSQL | UPDATE 1                                    |
+------------+---------------------------------------------+
*/

-- =====================================================
-- DROPPING A COLUMN
-- =====================================================

-- MySQL example of deleting a specific column from table inside database/schema:
-- How it works: ALTER TABLE DROP COLUMN permanently removes the department column
--               along with all data stored in it across every row.
--               The remaining columns and their data are completely unaffected.
--               This operation cannot be undone without a backup.
ALTER TABLE employees DROP COLUMN department;
/*
Output (MySQL):
Query OK, 4 rows affected
Records: 4  Duplicates: 0  Warnings: 0

Table state after DROP COLUMN department:
+-------------+---------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | hire_date  | salary    |
+-------------+---------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | 2022-01-15 |  70000.00 |
|           2 | Priya Sharma  | QA Analyst        | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+------------+-----------+
Note: The department column (IT, Quality Assurance, Human Resources, Analytics) is
      permanently gone. Any future query referencing 'department' will fail with
      "Unknown column 'department'".
*/

-- PostgreSQL example of deleting a specific column from table inside schema:
-- How it works: Identical syntax and behavior to MySQL.
--               PostgreSQL also permanently drops the column and all its data.
ALTER TABLE employees DROP COLUMN department;
/*
Output (PostgreSQL):
ALTER TABLE

Table state after DROP COLUMN: (identical to MySQL result above)
+-------------+---------------+-------------------+------------+-----------+
| employee_id | employee_name | position          | hire_date  | salary    |
+-------------+---------------+-------------------+------------+-----------+
|           1 | John Doe      | Software Engineer | 2022-01-15 |  70000.00 |
|           2 | Priya Sharma  | QA Analyst        | 2021-03-10 |  52000.00 |
|           4 | Anita Desai   | HR Executive      | 2023-06-18 |  45000.00 |
|           5 | Rakesh Kumar  | Data Analyst      | 2022-09-25 |  60000.00 |
+-------------+---------------+-------------------+------------+-----------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 4 rows affected |
| PostgreSQL | ALTER TABLE               |
+------------+---------------------------+
*/

-- =====================================================
-- DROPPING THE ENTIRE TABLE
-- =====================================================

-- MySQL example of deleting the entire table from database/schema:
-- How it works: DROP TABLE permanently removes the entire employees table —
--               its structure (all columns, indexes, constraints) AND all its data.
--               This is irreversible without a backup.
--               ⚠ If another table has a FOREIGN KEY referencing employees, MySQL will
--               raise an error — that foreign key must be dropped first.
--               Use DROP TABLE IF EXISTS to avoid errors when the table may not exist.
DROP TABLE employees;
/*
Output (MySQL):
Query OK, 0 rows affected
Note: The employees table no longer exists. Running SELECT * FROM employees now gives:
      ERROR 1146 (42S02): Table 'your_database.employees' doesn't exist
*/

-- PostgreSQL example of deleting the entire table from schema:
-- How it works: Identical behavior to MySQL — permanently drops the table and all its data.
--               ⚠ If another table references employees via FOREIGN KEY, PostgreSQL raises:
--               ERROR: cannot drop table employees because other objects depend on it.
--               Use DROP TABLE employees CASCADE to also drop dependent constraints automatically.
DROP TABLE employees;
/*
Output (PostgreSQL):
DROP TABLE
Note: The employees table no longer exists. Running SELECT * FROM employees now gives:
      ERROR: relation "employees" does not exist

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 0 rows affected |
| PostgreSQL | DROP TABLE                |
+------------+---------------------------+

Overall MySQL vs PostgreSQL syntax comparison:
+----------------------------+--------------------------------+----------------------------------+
| Operation                  | MySQL                          | PostgreSQL                       |
+----------------------------+--------------------------------+----------------------------------+
| Auto-increment column      | INT AUTO_INCREMENT             | SERIAL                           |
| Exact decimal type         | DECIMAL(10,2)                  | NUMERIC(10,2)                    |
| INSERT success message     | Query OK, N rows affected      | INSERT 0 N                       |
| UPDATE success message     | Query OK, 1 row affected       | UPDATE 1                         |
| DELETE success message     | Query OK, 1 row affected       | DELETE 1                         |
| ALTER TABLE success        | Query OK, N rows affected      | ALTER TABLE                      |
| DROP TABLE success         | Query OK, 0 rows affected      | DROP TABLE                       |
| Drop with dependencies     | Requires FK drop first         | CASCADE keyword available        |
+----------------------------+--------------------------------+----------------------------------+
*/