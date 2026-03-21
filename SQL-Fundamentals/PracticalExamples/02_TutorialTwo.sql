-- =====================================================
-- TABLE CREATION
-- =====================================================

-- MySQL example of creating table inside database/schema:
-- How it works: company.employees uses dot notation to specify the target database (company)
--               and table name (employees) explicitly — useful when multiple databases are open.
--               id INT AUTO_INCREMENT PRIMARY KEY auto-assigns a unique integer on every INSERT.
--               NUMERIC(10,2) stores exact decimal values (up to 10 digits, 2 after the decimal).
--               NOT NULL on name means every row must supply a name value.
CREATE TABLE company.employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
/*
Output (MySQL):
Query OK, 0 rows affected
*/

-- PostgreSQL example of creating table inside schema:
-- How it works: hr.employees uses dot notation to specify the PostgreSQL schema (hr)
--               and table name (employees). In PostgreSQL, schemas are namespaces within
--               a single database — unlike MySQL where the dot refers to the database itself.
--               SERIAL is PostgreSQL's shorthand for an auto-incrementing integer sequence.
--               NUMERIC(10,2) is identical in both MySQL and PostgreSQL.
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
/*
Output (PostgreSQL):
CREATE TABLE

Key concept difference:
+------------+-----------------------------------------------+
| Database   | What the prefix means                         |
+------------+-----------------------------------------------+
| MySQL      | company.employees → database.table            |
| PostgreSQL | hr.employees      → schema.table (within one  |
|            |                     database)                 |
+------------+-----------------------------------------------+

Syntax difference:
+---------------------+---------------------+---------------------+
| Feature             | MySQL               | PostgreSQL          |
+---------------------+---------------------+---------------------+
| Auto-increment      | INT AUTO_INCREMENT  | SERIAL              |
| Exact decimal       | NUMERIC(10,2) ✓     | NUMERIC(10,2) ✓     |
| Success message     | Query OK, 0 rows    | CREATE TABLE        |
+---------------------+---------------------+---------------------+
*/

-- =====================================================
-- INSERTING DATA
-- =====================================================

-- MySQL example for inserting data into table inside database/schema:
-- How it works: Uses the fully-qualified company.employees name to target the table.
--               id is omitted — AUTO_INCREMENT assigns 1, 2, 3 automatically.
--               3 rows are inserted in a single multi-value INSERT statement.
INSERT INTO company.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith', '2019-03-22', 55000.00),
('Charlie Brown', '2021-07-30', 70000.00);
/*
Output (MySQL):
Query OK, 3 rows affected

Resulting table (company.employees):
+----+---------------+------------+-----------+
| id | name          | hire_date  | salary    |
+----+---------------+------------+-----------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 |
+----+---------------+------------+-----------+
*/

-- PostgreSQL example for inserting data into table inside schema:
-- How it works: Identical syntax to MySQL. Uses the fully-qualified hr.employees name.
--               SERIAL sequence auto-assigns id values 1, 2, 3.
--               The only difference from MySQL is the output message format.
INSERT INTO hr.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith', '2019-03-22', 55000.00),
('Charlie Brown', '2021-07-30', 70000.00);
/*
Output (PostgreSQL):
INSERT 0 3

Resulting table (hr.employees): (identical to MySQL result above)
+----+---------------+------------+-----------+
| id | name          | hire_date  | salary    |
+----+---------------+------------+-----------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 |
+----+---------------+------------+-----------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 3 rows affected |
| PostgreSQL | INSERT 0 3                |
+------------+---------------------------+
*/

-- =====================================================
-- RENAMING A COLUMN
-- =====================================================

-- MySQL example for altering table/column inside table in database/schema:
-- How it works: RENAME COLUMN changes only the column's name — data type, constraints,
--               and all stored data remain completely intact.
--               hire_date is renamed to date_hired across the entire table.
--               After this, any query using 'hire_date' will fail with "Unknown column".
--               Available in MySQL 8.0+. Use CHANGE COLUMN in older MySQL versions.
ALTER TABLE company.employees
RENAME COLUMN hire_date TO date_hired;
/*
Output (MySQL):
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0

Table structure after rename:
+----+---------------+-------------+-----------+
| id | name          | date_hired  | salary    |
+----+---------------+-------------+-----------+
|  1 | Alice Johnson | 2020-01-15  |  60000.00 |
|  2 | Bob Smith     | 2019-03-22  |  55000.00 |
|  3 | Charlie Brown | 2021-07-30  |  70000.00 |
+----+---------------+-------------+-----------+
Note: Column is now date_hired. Using hire_date in any future query will cause an error.
*/

-- PostgreSQL example for altering table/column inside table in schema:
-- How it works: Identical syntax to MySQL 8.0+. RENAME COLUMN is standard SQL
--               and behaves exactly the same in PostgreSQL.
--               Only the success message format differs.
ALTER TABLE hr.employees
RENAME COLUMN hire_date TO date_hired;
/*
Output (PostgreSQL):
ALTER TABLE

Table structure after rename: (identical to MySQL result above)
+----+---------------+-------------+-----------+
| id | name          | date_hired  | salary    |
+----+---------------+-------------+-----------+
|  1 | Alice Johnson | 2020-01-15  |  60000.00 |
|  2 | Bob Smith     | 2019-03-22  |  55000.00 |
|  3 | Charlie Brown | 2021-07-30  |  70000.00 |
+----+---------------+-------------+-----------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 0 rows affected |
| PostgreSQL | ALTER TABLE               |
+------------+---------------------------+
*/

-- =====================================================
-- ADDING A NEW COLUMN
-- =====================================================

-- MySQL example for inserting new column into table inside database/schema:
-- How it works: ADD COLUMN appends the new department column at the end of the table.
--               No DEFAULT or NOT NULL is specified, so all existing rows receive NULL
--               in the department column automatically.
--               VARCHAR(50) stores up to 50 characters of variable-length text.
ALTER TABLE company.employees   
ADD COLUMN department VARCHAR(50);
/*
Output (MySQL):
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0

Table structure after ADD COLUMN:
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 | NULL       |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+
Note: All existing rows get department = NULL. Populate with UPDATE statements as needed.
*/

-- PostgreSQL example for inserting new column into table inside schema:
-- How it works: Identical syntax and behavior to MySQL.
--               ADD COLUMN is standard SQL — all existing rows receive NULL in department.
ALTER TABLE hr.employees   
ADD COLUMN department VARCHAR(50);
/*
Output (PostgreSQL):
ALTER TABLE

Table structure after ADD COLUMN: (identical to MySQL result above)
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 | NULL       |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 0 rows affected |
| PostgreSQL | ALTER TABLE               |
+------------+---------------------------+
*/

-- =====================================================
-- UPDATING DATA
-- =====================================================

-- MySQL example for updating data inside table in database/schema:
-- How it works: SET salary = salary * 1.05 applies a 5% raise to every targeted row.
--               WHERE date_hired < '2020-01-01' filters to employees hired before 2020.
--               Only Bob Smith (hired 2019-03-22) satisfies this condition.
--               Bob's salary: 55000.00 × 1.05 = 57750.00.
--               Alice (2020-01-15) and Charlie (2021-07-30) are NOT before 2020 — excluded.
--               Note: The column is now called date_hired (renamed in the previous step).
UPDATE company.employees
SET salary = salary * 1.05
WHERE date_hired < '2020-01-01';
/*
Output (MySQL):
Query OK, 1 row affected
Rows matched: 1  Changed: 1  Warnings: 0

Table state after UPDATE:
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  2 | Bob Smith     | 2019-03-22 |  57750.00 | NULL       |  ← salary updated
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+
*/

-- PostgreSQL example for updating data inside table in schema:
-- How it works: Identical syntax and logic to MySQL.
--               Bob Smith (2019-03-22) is the only employee hired before 2020-01-01.
--               His salary is updated from 55000.00 to 57750.00.
UPDATE hr.employees 
SET salary = salary * 1.05
WHERE date_hired < '2020-01-01';
/*
Output (PostgreSQL):
UPDATE 1

Table state after UPDATE: (identical to MySQL result above)
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  2 | Bob Smith     | 2019-03-22 |  57750.00 | NULL       |  ← salary updated
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+

Output message difference:
+------------+---------------------------------------------+
| Database   | Success message                             |
+------------+---------------------------------------------+
| MySQL      | Query OK, 1 row affected, Rows matched: 1   |
| PostgreSQL | UPDATE 1                                    |
+------------+---------------------------------------------+
*/

-- =====================================================
-- DELETING DATA
-- =====================================================

-- MySQL example for deleting data inside table in database/schema:
-- How it works: WHERE name = 'Bob Smith' targets only the row matching that exact name.
--               The comparison is case-insensitive by default (utf8mb4_general_ci collation).
--               Bob Smith's entire row (id=2) is permanently deleted.
--               Alice Johnson and Charlie Brown are unaffected.
--               ⚠ Always preview with SELECT * FROM company.employees WHERE name = 'Bob Smith'
--               before running DELETE in production.
DELETE FROM company.employees
WHERE name = 'Bob Smith';
/*
Output (MySQL):
Query OK, 1 row affected

Table state after DELETE:
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+
Note: id = 2 is permanently gone. AUTO_INCREMENT will NOT reuse it —
      the next inserted row receives id = 4.
*/

-- PostgreSQL example for deleting data inside table in schema:
-- How it works: Identical syntax and behavior to MySQL.
--               Bob Smith (id = 2) is permanently deleted from hr.employees.
DELETE FROM hr.employees
WHERE name = 'Bob Smith';
/*
Output (PostgreSQL):
DELETE 1

Table state after DELETE: (identical to MySQL result above)
+----+---------------+------------+-----------+------------+
| id | name          | date_hired | salary    | department |
+----+---------------+------------+-----------+------------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 | NULL       |
|  3 | Charlie Brown | 2021-07-30 |  70000.00 | NULL       |
+----+---------------+------------+-----------+------------+
Note: SERIAL sequence will NOT reuse id = 2. The next INSERT will receive id = 4.

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 1 row affected  |
| PostgreSQL | DELETE 1                  |
+------------+---------------------------+
*/

-- =====================================================
-- DROPPING THE TABLE
-- =====================================================

-- MySQL example for dropping table inside database/schema:
-- How it works: DROP TABLE permanently removes the employees table — its structure
--               (columns, indexes, constraints) AND all remaining data.
--               This cannot be undone without a backup.
--               ⚠ If another table has a FOREIGN KEY referencing company.employees,
--               MySQL raises an error. Drop or disable that constraint first.
DROP TABLE company.employees;
/*
Output (MySQL):
Query OK, 0 rows affected
Note: The table is gone entirely. Running SELECT * FROM company.employees now gives:
      ERROR 1146 (42S02): Table 'company.employees' doesn't exist
*/

-- PostgreSQL example for dropping table inside schema:
-- How it works: Identical behavior to MySQL — permanently drops the table and all its data.
--               ⚠ If other objects (views, foreign keys) depend on hr.employees,
--               PostgreSQL raises an error unless DROP TABLE hr.employees CASCADE is used.
--               CASCADE automatically drops all dependent objects along with the table.
DROP TABLE hr.employees;
/*
Output (PostgreSQL):
DROP TABLE
Note: The table is gone entirely. Running SELECT * FROM hr.employees now gives:
      ERROR: relation "hr.employees" does not exist.
      To drop with dependencies: DROP TABLE hr.employees CASCADE;

Output message difference:
+------------+---------------------------+
| Database   | Success message           |
+------------+---------------------------+
| MySQL      | Query OK, 0 rows affected |
| PostgreSQL | DROP TABLE                |
+------------+---------------------------+
*/

-- =====================================================
-- TRUNCATING THE TABLE
-- =====================================================

-- MySQL example for truncating table inside database/schema:
-- How it works: TRUNCATE TABLE removes ALL rows from the table instantly.
--               Unlike DELETE (which removes rows one by one and logs each deletion),
--               TRUNCATE is a DDL operation that deallocates the data pages directly —
--               making it significantly faster on large tables.
--               The table structure (columns, constraints, indexes) is preserved.
--               AUTO_INCREMENT counter is reset to 1 automatically in MySQL.
--               ⚠ TRUNCATE cannot be rolled back in MySQL (it commits immediately).
TRUNCATE TABLE company.employees;
/*
Output (MySQL):
Query OK, 0 rows affected

Table state after TRUNCATE:
+----+------+------------+--------+------------+
| id | name | date_hired | salary | department |
+----+------+------------+--------+------------+
(empty — 0 rows)
+----+------+------------+--------+------------+
Note: Table structure remains intact. AUTO_INCREMENT resets to 1.
      The next INSERT will assign id = 1 again.
*/

-- PostgreSQL example for truncating table inside schema:
-- How it works: Same behavior as MySQL — removes all rows instantly while keeping the structure.
--               Unlike MySQL, PostgreSQL's TRUNCATE does NOT automatically reset the SERIAL
--               sequence. The next INSERT after a plain TRUNCATE will continue from where
--               the sequence left off (e.g. id = 4, not 1).
--               To reset the sequence, use TRUNCATE TABLE hr.employees RESTART IDENTITY.
--               ⚠ TRUNCATE CAN be rolled back in PostgreSQL if wrapped inside a transaction.
TRUNCATE TABLE hr.employees;
/*
Output (PostgreSQL):
TRUNCATE TABLE

Table state after TRUNCATE:
+----+------+------------+--------+------------+
| id | name | date_hired | salary | department |
+----+------+------------+--------+------------+
(empty — 0 rows)
+----+------+------------+--------+------------+
Note: Table structure remains intact. SERIAL sequence is NOT reset by default.
      The next INSERT will continue from the previous sequence value (e.g. id = 4).
      Use RESTART IDENTITY (shown below) to reset the sequence to 1.

Key TRUNCATE behavior difference:
+---------------------+-----------------------------+-----------------------------+
| Behavior            | MySQL                       | PostgreSQL                  |
+---------------------+-----------------------------+-----------------------------+
| Removes all rows    | Yes                         | Yes                         |
| Keeps structure     | Yes                         | Yes                         |
| Resets sequence     | Yes (AUTO_INCREMENT → 1)    | No (use RESTART IDENTITY)   |
| Transactional       | No (auto-commits)           | Yes (can be rolled back)    |
+---------------------+-----------------------------+-----------------------------+
*/

-- =====================================================
-- TRUNCATE WITH RESTART IDENTITY
-- =====================================================

-- MySQL example for truncating table inside database/schema with restart identity:
-- How it works: ⚠ RESTART IDENTITY is NOT supported in MySQL syntax.
--               MySQL's plain TRUNCATE TABLE already resets AUTO_INCREMENT to 1 by default.
--               Writing RESTART IDENTITY in MySQL raises a syntax error.
--               If you need to reset AUTO_INCREMENT explicitly in MySQL, use:
--               ALTER TABLE company.employees AUTO_INCREMENT = 1;
TRUNCATE TABLE company.employees RESTART IDENTITY;
/*
Output (MySQL):
ERROR 1064 (42000): You have an error in your SQL syntax near 'RESTART IDENTITY'

MySQL equivalent to reset auto-increment:
    TRUNCATE TABLE company.employees;
    -- AUTO_INCREMENT resets to 1 automatically, no extra syntax needed.

    -- OR, to reset manually without truncating:
    ALTER TABLE company.employees AUTO_INCREMENT = 1;
*/

-- PostgreSQL example for truncating table inside schema with restart identity:
-- How it works: RESTART IDENTITY tells PostgreSQL to reset the SERIAL sequence back to 1
--               after truncating. Without this clause, the sequence continues from its last value.
--               This is the PostgreSQL equivalent of MySQL's automatic AUTO_INCREMENT reset.
--               CONTINUE IDENTITY (the default) keeps the current sequence value unchanged.
TRUNCATE TABLE hr.employees RESTART IDENTITY;
/*
Output (PostgreSQL):
TRUNCATE TABLE

Table state after TRUNCATE ... RESTART IDENTITY:
+----+------+------------+--------+------------+
| id | name | date_hired | salary | department |
+----+------+------------+--------+------------+
(empty — 0 rows)
+----+------+------------+--------+------------+
Note: SERIAL sequence is now reset to 1. The next INSERT will assign id = 1.

RESTART IDENTITY support:
+------------+-----------------------------------------------+
| Database   | RESTART IDENTITY support                      |
+------------+-----------------------------------------------+
| MySQL      | NOT supported — raises syntax error.          |
|            | Plain TRUNCATE resets AUTO_INCREMENT to 1     |
|            | automatically.                                |
| PostgreSQL | Supported — explicitly resets SERIAL sequence |
|            | to 1 after truncation.                        |
+------------+-----------------------------------------------+
*/

-- =====================================================
-- DROPPING THE DATABASE / SCHEMA
-- =====================================================

-- MySQL example for dropping database/schema:
-- How it works: DROP DATABASE permanently removes the entire 'company' database
--               along with ALL its tables, views, stored procedures, and data.
--               This is completely irreversible without a backup.
--               ⚠ In MySQL, a "database" and a "schema" are the same concept —
--               DROP DATABASE and DROP SCHEMA are synonymous.
DROP DATABASE company;
/*
Output (MySQL):
Query OK, N rows affected  (N = number of objects dropped)
Note: The entire 'company' database is permanently gone.
      All tables, data, and objects inside it are destroyed.
      Running USE company; now gives:
      ERROR 1049 (42000): Unknown database 'company'
*/

-- PostgreSQL example for dropping schema:
-- How it works: DROP SCHEMA removes the 'hr' schema from the current database.
--               Unlike MySQL, in PostgreSQL a schema is a namespace WITHIN a database —
--               dropping a schema does NOT drop the database itself.
--               CASCADE automatically drops all objects (tables, views, sequences, functions)
--               that exist inside the schema. Without CASCADE, PostgreSQL raises an error
--               if the schema still contains any objects.
-- Note: In PostgreSQL, CASCADE is used to drop all objects in the schema.
DROP SCHEMA hr CASCADE;
/*
Output (PostgreSQL):
DROP SCHEMA
Note: The hr schema and ALL objects inside it (hr.employees, its SERIAL sequence, etc.)
      are permanently destroyed. The database itself still exists.
      Running SELECT * FROM hr.employees now gives:
      ERROR: schema "hr" does not exist

Without CASCADE (if hr schema contains objects):
      ERROR: cannot drop schema hr because other objects depend on it
      DETAIL: table hr.employees depends on schema hr
      HINT: Use DROP ... CASCADE to drop the dependent objects too.

Key concept difference:
+------------+-----------------------------------------------+
| Database   | What gets dropped                             |
+------------+-----------------------------------------------+
| MySQL      | DROP DATABASE company                         |
|            | → Drops the entire database + all its tables  |
|            | → "Database" and "Schema" are synonymous      |
|            | → No CASCADE needed (implicit)                |
+------------+-----------------------------------------------+
| PostgreSQL | DROP SCHEMA hr CASCADE                        |
|            | → Drops just the schema namespace + contents  |
|            | → The parent database still exists            |
|            | → CASCADE required if schema has any objects  |
+------------+-----------------------------------------------+
*/

-- =====================================================
-- OVERALL MySQL vs PostgreSQL SYNTAX SUMMARY
-- =====================================================
/*
+-------------------------------+------------------------------------+------------------------------------+
| Operation                     | MySQL                              | PostgreSQL                         |
+-------------------------------+------------------------------------+------------------------------------+
| Namespace prefix              | database.table (company.employees) | schema.table (hr.employees)        |
| Namespace concept             | Database = Schema (same thing)     | Schema is inside a Database        |
| Auto-increment                | INT AUTO_INCREMENT                 | SERIAL                             |
| CREATE TABLE success          | Query OK, 0 rows affected          | CREATE TABLE                       |
| INSERT success                | Query OK, N rows affected          | INSERT 0 N                         |
| UPDATE success                | Query OK, N rows affected          | UPDATE N                           |
| DELETE success                | Query OK, N rows affected          | DELETE N                           |
| ALTER TABLE success           | Query OK, 0 rows affected          | ALTER TABLE                        |
| DROP TABLE success            | Query OK, 0 rows affected          | DROP TABLE                         |
| TRUNCATE resets sequence      | Yes (automatic)                    | Only with RESTART IDENTITY         |
| TRUNCATE transactional        | No (auto-commits)                  | Yes (can roll back)                |
| RESTART IDENTITY              | Not supported (syntax error)       | Supported                          |
| Drop namespace                | DROP DATABASE company              | DROP SCHEMA hr CASCADE             |
| Drop namespace success        | Query OK, N rows affected          | DROP SCHEMA                        |
| CASCADE on drop               | Not needed (implicit)              | Required if objects exist inside   |
+-------------------------------+------------------------------------+------------------------------------+
*/