-- ------------------------------------------------------------
-- Difference between: CREATE DATABASE and CREATE SCHEMA
--   CREATE DATABASE company;
--   CREATE SCHEMA company;
-- In MySQL:
-- ------------------------------------------------------------

/*
In MySQL:
---------
1) There is NO difference between CREATE DATABASE and CREATE SCHEMA.
2) CREATE SCHEMA is simply a synonym for CREATE DATABASE.
3) Both commands create a new database named "company".
4) Internally, MySQL treats a SCHEMA as a DATABASE.
5) Both allow storing tables, views, procedures, triggers, etc.

Example (both are identical in MySQL):
    CREATE DATABASE company;
    CREATE SCHEMA company;    ← produces the exact same result

In other SQL systems (PostgreSQL, SQL Server, Oracle):
------------------------------------------------------
1) DATABASE and SCHEMA are different concepts entirely.
2) A DATABASE is a top-level, self-contained container.
3) A SCHEMA is a namespace (like a folder) INSIDE a database.
4) These systems allow multiple schemas inside one database.

Example (PostgreSQL):
    Database: company_db
    └── Schemas inside it:
        ├── hr
        ├── sales
        └── accounts

Visual comparison:
+---------------------+------------------------------------------+------------------------------------------+
| Concept             | MySQL                                    | PostgreSQL / SQL Server / Oracle         |
+---------------------+------------------------------------------+------------------------------------------+
| DATABASE            | Top-level container for tables/objects   | Top-level container                      |
| SCHEMA              | Synonym for DATABASE (same thing)        | Namespace folder INSIDE a database       |
| Relationship        | DATABASE = SCHEMA (no hierarchy)         | DATABASE > SCHEMA (two-level hierarchy)  |
| Multiple schemas    | Not applicable (schema IS the database)  | Yes — one database can have many schemas |
+---------------------+------------------------------------------+------------------------------------------+
*/

-- =====================================================
-- CREATING DATABASE / SCHEMA
-- =====================================================

-- MySQL Example For Creating Database and Schema:
-- How it works: CREATE DATABASE creates a new top-level database named company.
--               In MySQL, this is the only container level available.
--               All tables, views, stored procedures, and triggers are stored directly inside.
CREATE DATABASE company;
/*
Output (MySQL):
Query OK, 1 row affected
*/

-- How it works: SHOW DATABASES lists every database (schema) available on the MySQL server.
--               Since CREATE SCHEMA is a synonym for CREATE DATABASE in MySQL, any database
--               created with either command appears in this list.
--               The output always includes MySQL's built-in system databases in addition to
--               user-created ones.
-- Note: In MySQL, SHOW DATABASES; will list all the databases (schemas) available on the server.
--       Since CREATE SCHEMA is a synonym for CREATE DATABASE in MySQL, both commands create a
--       database that appears in this list.
SHOW DATABASES;
/*
Output (MySQL):
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| company            |   ← newly created database
+--------------------+
5 rows in set
*/

/*
Case Sensitivity Note:
On Windows and macOS: Database names are CASE-INSENSITIVE by default.
    "company", "Company", and "COMPANY" all refer to the same database.
On Linux: MySQL treats database names as CASE-SENSITIVE by default.
    "company", "Company", and "COMPANY" would be considered three different databases.
This behavior is controlled by the lower_case_table_names system variable in MySQL config:
    lower_case_table_names = 0  → case-sensitive  (Linux default)
    lower_case_table_names = 1  → case-insensitive (Windows/macOS default)
    lower_case_table_names = 2  → stored as given, compared case-insensitively (macOS option)
*/

-- How it works: DATABASE() is a MySQL built-in function that returns the name of the
--               currently active database (the one selected with USE).
--               If no database has been selected yet, it returns NULL.
SELECT DATABASE();
/*
Output (before USE):
+------------+
| DATABASE() |
+------------+
| NULL       |
+------------+
1 row in set

Output (after USE company):
+------------+
| DATABASE() |
+------------+
| company    |
+------------+
1 row in set
*/

-- How it works: In MySQL, CREATE SCHEMA is 100% identical to CREATE DATABASE.
--               Both commands create the same type of object.
--               Running this after CREATE DATABASE company; would raise an error
--               because a database named 'company' already exists.
--               In practice, pick one syntax and use it consistently throughout your project.
CREATE SCHEMA company;
/*
Output (MySQL — if 'company' doesn't already exist):
Query OK, 1 row affected

Output (MySQL — if 'company' already exists):
ERROR 1007 (HY000): Can't create database 'company'; database exists

Note: CREATE DATABASE and CREATE SCHEMA are completely interchangeable in MySQL.
      There is no technical reason to prefer one over the other.
*/

-- PostgreSQL Example:
-- How it works: In PostgreSQL, CREATE DATABASE creates a top-level container
--               that is entirely separate from other databases on the server.
--               Each database has its own set of schemas, roles, and settings.
--               You can only be connected to one database at a time in PostgreSQL.
CREATE DATABASE company_db;
/*
Output (PostgreSQL):
CREATE DATABASE

Note: company_db is now a top-level database on the PostgreSQL server.
      It starts with a default schema called 'public' inside it.
*/

-- How it works: CREATE SCHEMA creates a namespace (folder) INSIDE the currently
--               connected database. In PostgreSQL this is a completely different
--               operation from CREATE DATABASE — it does NOT create a new database.
--               Multiple schemas can coexist inside one database, allowing you to
--               logically separate objects (e.g. hr, sales, accounts).
CREATE SCHEMA hr;
/*
Output (PostgreSQL):
CREATE SCHEMA

Resulting structure:
company_db (database)
└── hr (schema)        ← newly created namespace
└── public (schema)    ← default schema that always exists
*/

-- =====================================================
-- SELECTING / USING A DATABASE OR SCHEMA
-- =====================================================

-- MySQL Example For Using Database/Schema:
-- How it works: USE company switches the active database context to 'company'.
--               All subsequent queries (SELECT, INSERT, CREATE TABLE, etc.) that don't
--               use a fully qualified name (database.table) will target this database.
--               This persists for the entire session until another USE is called.
USE company;
/*
Output (MySQL):
Database changed

After this command:
SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| company    |
+------------+
*/

-- PostgreSQL Example:
-- How it works: PostgreSQL does NOT support the USE command.
--               To switch to a database, you must open a new connection to that database.
--               In pgAdmin (GUI tool): right-click the database → click "Query Tool"
--               to open an SQL editor already connected to that database.
--               In psql (command-line tool): use \c database_name to connect.
--               Example: \c company_db
/*
PostgreSQL connection methods:
+------------------+-----------------------------------------------+
| Tool             | How to switch database                        |
+------------------+-----------------------------------------------+
| pgAdmin (GUI)    | Right-click database → Query Tool             |
| psql (terminal)  | \c company_db                                 |
| Connection string| postgres://user:pass@host/company_db          |
+------------------+-----------------------------------------------+
Note: There is no USE command in PostgreSQL.
*/

-- How it works: After connecting to company_db in PostgreSQL, CREATE SCHEMA hr
--               creates a new namespace inside that database.
--               Tables, views, and functions created afterward can be placed inside
--               this schema using dot notation: hr.employees, hr.departments, etc.
CREATE SCHEMA hr;
/*
Output (PostgreSQL):
CREATE SCHEMA
*/

-- How it works: SET search_path TO hr tells PostgreSQL to look in the hr schema first
--               when a table name is referenced without a schema prefix.
--               This is the PostgreSQL equivalent of MySQL's USE command — it sets a
--               default namespace so you can write SELECT * FROM employees instead of
--               SELECT * FROM hr.employees.
--               search_path can list multiple schemas in priority order:
--               SET search_path TO hr, public;
SET search_path TO hr;
/*
Output (PostgreSQL):
SET

Effect:
Before: SELECT * FROM employees → ERROR: relation "employees" does not exist
After:  SELECT * FROM employees → looks in hr schema first → finds hr.employees ✓

To verify current search_path:
SHOW search_path;
+--------------+
| search_path  |
+--------------+
| hr           |
+--------------+
*/

-- =====================================================
-- CREATING TABLES
-- =====================================================

-- MySQL example of creating table inside database/schema:
-- How it works: company.employees uses fully-qualified dot notation (database.table).
--               This works even without running USE company; first.
--               id INT PRIMARY KEY has no AUTO_INCREMENT here — values must be
--               supplied manually in every INSERT statement.
CREATE TABLE company.employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
/*
Output (MySQL):
Query OK, 0 rows affected

Table structure:
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| id         | int          | NO   | PRI | NULL    |       |
| name       | varchar(100) | NO   |     | NULL    |       |
| hire_date  | date         | YES  |     | NULL    |       |
| salary     | numeric(10,2)| YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
Note: id has no AUTO_INCREMENT — you must supply id values explicitly in every INSERT.
*/

-- PostgreSQL example of creating table inside schema:
-- How it works: hr.employees uses fully-qualified dot notation (schema.table).
--               SERIAL makes id auto-incrementing (no need to supply id in INSERT).
--               This is the key difference from the MySQL version above where id is plain INT.
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
/*
Output (PostgreSQL):
CREATE TABLE

Table structure (PostgreSQL \d hr.employees):
+-----------+-----------------------+-----------+
| Column    | Type                  | Nullable  |
+-----------+-----------------------+-----------+
| id        | integer (auto)        | not null  |
| name      | character varying(100)| not null  |
| hire_date | date                  | nullable  |
| salary    | numeric(10,2)         | nullable  |
+-----------+-----------------------+-----------+
Primary key: id (backed by a SERIAL sequence)

Key difference between the two CREATE TABLE statements:
+----------------+----------------------------+----------------------------+
| Feature        | MySQL (company.employees)  | PostgreSQL (hr.employees)  |
+----------------+----------------------------+----------------------------+
| id column      | INT PRIMARY KEY            | SERIAL PRIMARY KEY         |
| Auto-increment | No (manual id required)    | Yes (id auto-assigned)     |
| Schema prefix  | database.table             | schema.table               |
+----------------+----------------------------+----------------------------+
*/

-- =====================================================
-- SELECTING DATA
-- =====================================================

-- MySQL example of Selecting data from table inside database/schema:
-- How it works: SELECT * FROM company.employees retrieves all columns and all rows
--               from the employees table inside the company database.
--               Since no rows have been inserted yet, the result is an empty set.
--               The fully-qualified name company.employees works regardless of which
--               database is currently active (USE company is not required).
SELECT * FROM company.employees;
/*
Output (MySQL — empty table, no rows inserted yet):
+----+------+-----------+--------+
| id | name | hire_date | salary |
+----+------+-----------+--------+
(empty — 0 rows)
+----+------+-----------+--------+
0 rows in set

After inserting sample data:
INSERT INTO company.employees (id, name, hire_date, salary) VALUES
(1, 'Alice Johnson', '2020-01-15', 60000.00),
(2, 'Bob Smith',     '2019-03-22', 55000.00);

SELECT * FROM company.employees;
+----+---------------+------------+-----------+
| id | name          | hire_date  | salary    |
+----+---------------+------------+-----------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 |
+----+---------------+------------+-----------+
2 rows in set
Note: id must be supplied manually (no AUTO_INCREMENT on this table).
*/

-- PostgreSQL example of Selecting data from table inside schema:
-- How it works: SELECT * FROM hr.employees retrieves all columns and all rows from
--               the employees table inside the hr schema of the connected database.
--               Since no rows have been inserted yet, the result is an empty set.
--               The SERIAL id column will auto-assign values when rows are inserted.
SELECT * FROM hr.employees;
/*
Output (PostgreSQL — empty table, no rows inserted yet):
+----+------+-----------+--------+
| id | name | hire_date | salary |
+----+------+-----------+--------+
(empty — 0 rows)
+----+------+-----------+--------+
(0 rows)

After inserting sample data:
INSERT INTO hr.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith',     '2019-03-22', 55000.00);

SELECT * FROM hr.employees;
+----+---------------+------------+-----------+
| id | name          | hire_date  | salary    |
+----+---------------+------------+-----------+
|  1 | Alice Johnson | 2020-01-15 |  60000.00 |
|  2 | Bob Smith     | 2019-03-22 |  55000.00 |
+----+---------------+------------+-----------+
(2 rows)
Note: id is auto-assigned by SERIAL — it is omitted from the INSERT column list.

SELECT output message difference:
+------------+-------------------------------------+
| Database   | Empty result message                |
+------------+-------------------------------------+
| MySQL      | 0 rows in set                       |
| PostgreSQL | (0 rows)                            |
+------------+-------------------------------------+
*/

-- =====================================================
-- OVERALL SUMMARY
-- =====================================================
/*
+-----------------------------+-------------------------------+----------------------------------+
| Concept / Command           | MySQL                         | PostgreSQL                       |
+-----------------------------+-------------------------------+----------------------------------+
| CREATE DATABASE             | Creates a database            | Creates a database               |
| CREATE SCHEMA               | Synonym — same as DATABASE    | Creates a namespace inside DB    |
| USE database_name           | Switches active database      | Not supported (use \c or GUI)    |
| SET search_path TO schema   | Not applicable                | Sets default schema (like USE)   |
| SHOW DATABASES              | Lists all databases/schemas   | Use \l in psql                   |
| DATABASE()                  | Returns current database name | Use current_database() function  |
| Dot notation (prefix.table) | database.table                | schema.table                     |
| Multiple schemas per DB     | No — schema IS the database   | Yes — multiple schemas per DB    |
| Auto-increment syntax       | INT AUTO_INCREMENT            | SERIAL                           |
| Case sensitivity (names)    | OS-dependent (Linux: yes)     | Always case-sensitive            |
+-----------------------------+-------------------------------+----------------------------------+
*/