-- End To End Example Of Creating Database, Tables, Adding Columns, Constraints, and Using Timestamps

-- Create a new database
-- How it works: Creates a new, empty database schema named employee_database.
--               All tables, views, and stored procedures created afterward will belong to it.
CREATE DATABASE employee_database;
/*
Output:
Query OK, 1 row affected
*/

-- Use the newly created database
-- How it works: Switches the active database context to employee_database.
--               Every subsequent SQL statement targets this database until USE is called again.
USE employee_database;
/*
Output:
Database changed
*/

-- Create tables and insert data
-- How it works: Creates the employees table with 10 columns covering identity, contact,
--               compensation, status, and audit timestamps. Key constraints applied:
--               PRIMARY KEY + AUTO_INCREMENT on employee_id → unique, auto-generated IDs.
--               NOT NULL on first_name and last_name → these fields are mandatory.
--               DEFAULT (CURRENT_DATE()) on hire_date → auto-fills today's date if not given.
--               UNIQUE on email → no two employees can share the same email address.
--               CHECK (salary > 0.0) → rejects any salary that is zero or negative.
--               ENUM on employment_status → restricts values to the 4 listed options.
--               DEFAULT CURRENT_TIMESTAMP on created_at → records insertion timestamp.
--               ON UPDATE CURRENT_TIMESTAMP on updated_at → auto-refreshes on every UPDATE.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE()),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    salary DECIMAL(10, 2) CHECK (salary > 0.0),
    employment_status ENUM('active', 'on_leave', 'inactive', 'terminated') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/*
Output:
Query OK, 0 rows affected
*/

-- Insert sample data
-- How it works: Only the listed columns are supplied. Unmentioned columns fall back to their
--               defaults: employee_id is auto-incremented to 1, hire_date is set to today's
--               date, created_at and updated_at are both set to the current timestamp.
--               The CHECK constraint verifies salary (50000.00) > 0 before accepting the row.
INSERT INTO employees (first_name, last_name, email, phone_number, salary, employment_status) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 50000.00, 'active');
/*
Output:
Query OK, 1 row affected

Resulting row:
+-------------+------------+-----------+------------+----------------------+--------------+-----------+-------------------+---------------------+---------------------+
| employee_id | first_name | last_name | hire_date  | email                | phone_number | salary    | employment_status | created_at          | updated_at          |
+-------------+------------+-----------+------------+----------------------+--------------+-----------+-------------------+---------------------+---------------------+
|           1 | John       | Doe       | 2026-03-20 | john.doe@example.com | 555-1234     | 50000.00  | active            | 2026-03-20 10:00:00 | 2026-03-20 10:00:00 |
+-------------+------------+-----------+------------+----------------------+--------------+-----------+-------------------+---------------------+---------------------+
Note: hire_date, created_at, and updated_at are auto-filled by their DEFAULT values.
*/

-- Create a new table for departments
-- How it works: Creates the departments table with 4 columns.
--               department_id is the auto-incrementing primary key.
--               department_name has a UNIQUE constraint — no two departments can share a name.
--               NOT NULL ensures a name is always required.
--               created_at and updated_at work the same as in the employees table.
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/*
Output:
Query OK, 0 rows affected
*/

-- Insert sample data into departments
-- How it works: Inserts 3 rows in a single multi-value INSERT statement.
--               department_id values are auto-assigned (1, 2, 3).
--               created_at and updated_at are set to the current timestamp for each row.
INSERT INTO departments (department_name) VALUES
('Human Resources'),
('Engineering'),
('Marketing');
/*
Output:
Query OK, 3 rows affected

Resulting table:
+---------------+-----------------+---------------------+---------------------+
| department_id | department_name | created_at          | updated_at          |
+---------------+-----------------+---------------------+---------------------+
|             1 | Human Resources | 2026-03-20 10:00:00 | 2026-03-20 10:00:00 |
|             2 | Engineering     | 2026-03-20 10:00:00 | 2026-03-20 10:00:00 |
|             3 | Marketing       | 2026-03-20 10:00:00 | 2026-03-20 10:00:00 |
+---------------+-----------------+---------------------+---------------------+
*/

-- Add new description column to employees table
-- How it works: ALTER TABLE ADD COLUMN adds a new column to an existing table without
--               dropping or recreating it. Existing rows are unaffected; MySQL fills the
--               new column with NULL for all existing rows (since no DEFAULT is provided).
--               TEXT can store up to 65,535 bytes of variable-length character data.
ALTER TABLE employees
ADD COLUMN description TEXT;
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: The existing row (John Doe) now has description = NULL.
*/

/* ============================================================
   1️⃣ ADD COLUMN WITH NOT NULL + CHECK CONSTRAINT (Single Step)
   ============================================================ */

-- How it works: Adds the emergency_contact column with two constraints simultaneously.
--               NOT NULL means the column cannot hold NULL values.
--               CHECK with REGEXP validates that the value matches the pattern:
--               "Name: PhoneNumber" (e.g. "John Doe: +919876543210").
--               REGEXP '^[A-Za-z ]+: [0-9+-]+$' means:
--                 ^ = start of string
--                 [A-Za-z ]+ = one or more letters or spaces (the name part)
--                 : = literal colon and space
--                 [0-9+-]+ = one or more digits, +, or - (the phone part)
--                 $ = end of string
--               ⚠ This will FAIL if the table already has rows with no DEFAULT provided,
--               because existing rows cannot satisfy NOT NULL on the new column.
ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100) NOT NULL 
CHECK (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');
/*
Output (on a table with existing rows and no DEFAULT):
ERROR 1364 (HY000): Field 'emergency_contact' doesn't have a default value
  — OR —
ERROR 3819 (HY000): Check constraint 'employees_chk_2' is violated.

Output (on an empty table):
Query OK, 0 rows affected

⚠ Important: This approach works safely only when the table is empty or when a DEFAULT
             value that satisfies both NOT NULL and the CHECK pattern is also provided.
*/


/* ============================================================
   2️⃣ ADD COLUMN ONLY (No Constraints)
   ============================================================ */

-- How it works: Adds the emergency_contact column with no constraints.
--               Existing rows receive NULL in this column automatically.
--               This is the safest approach when the table already contains data,
--               because no validation is required at the time of the ALTER.
ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100);
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: All existing rows now have emergency_contact = NULL.
      No format validation is enforced — any VARCHAR(100) value is accepted.
*/


/* ============================================================
   3️⃣ ADD CHECK CONSTRAINT SEPARATELY
   ============================================================ */

-- How it works: Adds only a CHECK constraint to the already-existing emergency_contact column.
--               Does NOT change nullability — NULL values are still permitted.
--               The CHECK is evaluated only when a value is actually inserted or updated;
--               NULL bypasses the CHECK because NULL is treated as "unknown", not invalid.
--               Good when you want to enforce format on new data without touching existing NULLs.
ALTER TABLE employees
ADD CHECK (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');
/*
Output:
Query OK, 1 row affected
Records: 1  Duplicates: 0  Warnings: 0
Note: Existing NULL values are not validated by the CHECK.
      Future INSERT/UPDATE values must satisfy the REGEXP pattern or they will be rejected.
*/

/* ============================================================
   4️⃣ MODIFY COLUMN TO ADD NOT NULL
   ============================================================ */

-- How it works: MODIFY COLUMN rewrites the column definition entirely.
--               Here it changes emergency_contact to VARCHAR(100) NOT NULL.
--               ⚠ This will FAIL if any existing rows currently hold NULL in this column.
--               You must first UPDATE all NULL rows to a valid value before running this.
ALTER TABLE employees
MODIFY COLUMN emergency_contact VARCHAR(100) NOT NULL;
/*
Output (when existing NULLs are present):
ERROR 1138 (22004): Invalid use of NULL value

Output (when no NULLs exist):
Query OK, N rows affected
Records: N  Duplicates: 0  Warnings: 0
*/

/* ============================================================
   🔎 SUMMARY DIFFERENCE
   ============================================================

1️⃣ ADD COLUMN ... NOT NULL + CHECK  → Adds column with full validation in one step.
                                       Fails on tables with existing rows (no DEFAULT given).

2️⃣ ADD COLUMN (no constraints)      → Adds column safely, allows NULL, no validation.
                                       Always succeeds regardless of existing data.

3️⃣ ADD CHECK separately             → Adds format validation only, NULL still allowed.
                                       Good for adding validation to an existing column.

4️⃣ MODIFY COLUMN ... NOT NULL       → Enforces NOT NULL on an existing column.
                                       Fails if any existing rows contain NULL.

============================================================ */


-- Rename the column to emergency_contact_info
-- How it works: RENAME COLUMN changes only the column's name — data type, constraints,
--               and all stored data remain completely unchanged.
--               Available in MySQL 8.0+. Use CHANGE COLUMN in older versions.
ALTER TABLE employees 
RENAME COLUMN emergency_contact TO emergency_contact_info;
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: The column is now referenced as emergency_contact_info in all future queries.
*/

-- Add a new column for department_id and set it as a foreign key in employees table
-- How it works: Adds department_id as a nullable INT column first.
--               Adding it nullable is the safe approach when the table already has rows,
--               because existing rows cannot immediately satisfy NOT NULL.
ALTER TABLE employees
ADD COLUMN department_id INT;
/*
Output:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
Note: Existing rows now have department_id = NULL.
*/

-- How it works: MODIFY COLUMN changes the department_id column to NOT NULL.
--               ⚠ This will fail if any existing rows still have department_id = NULL.
--               You must UPDATE those rows to assign valid department IDs first.
ALTER TABLE employees
MODIFY COLUMN department_id INT NOT NULL;
/*
Output (when existing NULLs are present):
ERROR 1138 (22004): Invalid use of NULL value

Output (when all rows have a valid department_id):
Query OK, N rows affected
Records: N  Duplicates: 0  Warnings: 0
*/

-- How it works: ADD FOREIGN KEY creates a referential integrity constraint linking
--               employees.department_id to departments.department_id.
--               MySQL enforces that every value inserted into employees.department_id
--               must already exist in departments.department_id.
--               Attempting to insert an employees row with a non-existent department_id
--               or to delete a department that has associated employees will fail.
ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
/*
Output:
Query OK, N rows affected
Records: N  Duplicates: 0  Warnings: 0
Note: MySQL automatically names this constraint (e.g. employees_ibfk_1).
      To specify a name: ADD CONSTRAINT fk_department FOREIGN KEY (department_id)
      REFERENCES departments(department_id);
*/

-- Writing Foreign Key inside the CREATE TABLE statement
-- How it works: This is the preferred approach — defining the FOREIGN KEY inline at table
--               creation time avoids the multi-step ALTER TABLE workflow.
--               The FOREIGN KEY clause at the bottom of the CREATE TABLE links
--               department_id directly to departments(department_id) from the start.
--               Note: departments table must already exist before this CREATE TABLE runs.
CREATE TABLE employees (    
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE()),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    salary DECIMAL(10, 2) CHECK (salary > 0.0),
    employment_status ENUM('active', 'on_leave', 'inactive', 'terminated') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
/*
Output:
Query OK, 0 rows affected
Note: This assumes departments table already exists. If not, MySQL raises:
      ERROR 1824 (HY000): Failed to open the referenced table 'departments'.
*/

/*
============================================================
Difference Between created_at and updated_at Columns
============================================================
*/

-- How it works: This CREATE TABLE version is used purely as a teaching example to highlight
--               the behavioral difference between created_at and updated_at columns.
CREATE TABLE employees (    
    employee_id INT PRIMARY KEY AUTO_INCREMENT,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    hire_date DATE DEFAULT (CURRENT_DATE()),

    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),

    salary DECIMAL(10, 2) CHECK (salary > 0.0),

    employment_status ENUM('active', 'on_leave', 'inactive', 'terminated') 
    DEFAULT 'active',

    /* ------------------------------------------------------
       1️⃣ created_at COLUMN
       ------------------------------------------------------ */
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    /*
    How it works:
    - DEFAULT CURRENT_TIMESTAMP auto-fills the column with the current date and time
      at the moment a new row is INSERTed.
    - The value is set ONCE at creation and never automatically changes afterward.
    - Even when the row is later UPDATEd, created_at stays the same.
    - Use this to track when a record was originally created.
    */


    /* ------------------------------------------------------
       2️⃣ updated_at COLUMN
       ------------------------------------------------------ */
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,

    /*
    How it works:
    - DEFAULT CURRENT_TIMESTAMP sets the value during INSERT (same as created_at).
    - ON UPDATE CURRENT_TIMESTAMP additionally instructs MySQL to automatically
      overwrite this column with the current timestamp whenever the row is modified
      via an UPDATE statement — even if updated_at itself is not mentioned in the UPDATE.
    - Use this to track when a record was last modified.
    */


    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
/*
Output:
Query OK, 0 rows affected
*/


/*
============================================================
🔎 Practical Example
============================================================

-- Insert new record
INSERT INTO employees (first_name, last_name, department_id)
VALUES ('John', 'Doe', 1);

Immediately after INSERT:
+---------------------+---------------------+
| created_at          | updated_at          |
+---------------------+---------------------+
| 2026-02-18 10:00:00 | 2026-02-18 10:00:00 |
+---------------------+---------------------+
Both are identical at insertion time.

-- Update record (1.5 hours later)
UPDATE employees
SET salary = 50000
WHERE employee_id = 1;

After UPDATE:
+---------------------+---------------------+
| created_at          | updated_at          |
+---------------------+---------------------+
| 2026-02-18 10:00:00 | 2026-02-18 11:30:00 |  ← updated_at changed automatically
+---------------------+---------------------+
created_at remains 2026-02-18 10:00:00 (unchanged — records when row was born).
updated_at is now 2026-02-18 11:30:00 (auto-refreshed — records last modification).

============================================================
📌 Key Difference Summary
============================================================

created_at  → Tracks when record was CREATED.
              Set once during INSERT.
              Never automatically changes.

updated_at  → Tracks when record was LAST MODIFIED.
              Set during INSERT (same value as created_at initially).
              Auto-updates to the current timestamp on every UPDATE.

============================================================
*/

-- How it works: This CREATE TABLE version explains the syntax differences between the
--               three timestamp-related defaults: CURRENT_DATE(), CURRENT_TIMESTAMP,
--               and ON UPDATE CURRENT_TIMESTAMP.
CREATE TABLE employees (    
    employee_id INT PRIMARY KEY AUTO_INCREMENT,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    /* -------------------------------------------------------
       1️⃣ hire_date with CURRENT_DATE()
       ------------------------------------------------------- */
    hire_date DATE DEFAULT (CURRENT_DATE()),

    /*
    How it works:
    - CURRENT_DATE() is a MySQL function returning only the current date (YYYY-MM-DD).
    - Parentheses are required because it is a function call used inside an expression default.
    - The column type is DATE, so only the date portion is stored — no time component.
    - If hire_date is omitted during INSERT, MySQL fills it with today's date automatically.
    - CURRENT_DATE (without parentheses) also works in MySQL as a keyword synonym.
    */


    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),

    salary DECIMAL(10, 2) CHECK (salary > 0.0),

    employment_status ENUM('active', 'on_leave', 'inactive', 'terminated') 
    DEFAULT 'active',

    /* -------------------------------------------------------
       2️⃣ created_at with CURRENT_TIMESTAMP
       ------------------------------------------------------- */
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    /*
    How it works:
    - CURRENT_TIMESTAMP is a special SQL keyword (not a function call).
    - It returns the current date AND time (YYYY-MM-DD HH:MM:SS).
    - Parentheses are OPTIONAL in MySQL: CURRENT_TIMESTAMP and CURRENT_TIMESTAMP() both work.
    - The column type is TIMESTAMP, so both date and time are stored.
    - This column is set automatically when a row is inserted.
    */

    /* -------------------------------------------------------
       3️⃣ updated_at with ON UPDATE CURRENT_TIMESTAMP
       ------------------------------------------------------- */
    updated_at TIMESTAMP 
    DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,

    /*
    How it works:
    - DEFAULT CURRENT_TIMESTAMP → sets the value during INSERT.
    - ON UPDATE CURRENT_TIMESTAMP → MySQL automatically updates this column to the
      current timestamp whenever an UPDATE modifies any column in the same row.
    - Parentheses are optional here as well.
    - No application-level code is needed to maintain this column.
    */

    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
/*
Output:
Query OK, 0 rows affected
*/

-- Drop Column description from employees table
-- How it works: DROP COLUMN permanently removes the description column and all its data
--               from the employees table. The operation cannot be undone without a backup.
--               All other columns and their data are unaffected.
ALTER TABLE employees
DROP COLUMN description;
/*
Output:
Query OK, N rows affected
Records: N  Duplicates: 0  Warnings: 0
Note: The description column no longer appears in DESCRIBE employees or SELECT * queries.
*/

-- Drop the employees table
-- How it works: DROP TABLE permanently removes the employees table along with all its data,
--               indexes, and constraints. Cannot be undone without a backup.
--               ⚠ If a FOREIGN KEY in another table references employees, MySQL will raise
--               an error — that constraint must be dropped first.
DROP TABLE employees;
/*
Output:
Query OK, 0 rows affected
Note: The table and all its rows are permanently deleted.
      If another table holds a FOREIGN KEY pointing to employees, MySQL raises:
      ERROR 3730 (HY000): Cannot drop table 'employees' referenced by a foreign key
      constraint '...' on table '...'.
      Drop or disable the referencing foreign key first.
*/

-- Drop constraints before dropping the departments table
-- How it works: Before dropping the departments table, the FOREIGN KEY on the employees
--               table that references departments must be removed first.
--               MySQL auto-names foreign key constraints (e.g. employees_ibfk_1).
--               Run SHOW CREATE TABLE employees; to find the exact constraint name,
--               then replace employees_ibfk_1 below with the actual name.
--               Once the foreign key is dropped, the departments table can be dropped freely.
ALTER TABLE employees
DROP FOREIGN KEY employees_ibfk_1; -- Replace with actual constraint name
/*
Output:
Query OK, N rows affected
Records: N  Duplicates: 0  Warnings: 0
Note: To find the actual foreign key constraint name, run:
      SHOW CREATE TABLE employees;
      Look for the CONSTRAINT name next to the FOREIGN KEY definition.
      Example output line: CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`)
                            REFERENCES `departments` (`department_id`)
      After dropping the foreign key, you can safely run:
      DROP TABLE departments;
*/