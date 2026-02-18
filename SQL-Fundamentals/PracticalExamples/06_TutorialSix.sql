-- End To End Example Of Creating Database, Tables, Adding Columns, Constraints, and Using Timestamps

-- Create a new database
CREATE DATABASE employee_database;
-- Use the newly created database
USE employee_database;
-- Create tables and insert data
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
-- Insert sample data
INSERT INTO employees (first_name, last_name, email, phone_number, salary, employment_status) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 50000.00, 'active');

-- Create a new table for departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);  
-- Insert sample data into departments
INSERT INTO departments (department_name) VALUES
('Human Resources'),
('Engineering'),
('Marketing');

-- Add new description column to employees table
ALTER TABLE employees
ADD COLUMN description TEXT;

/* ============================================================
   1️⃣ ADD COLUMN WITH NOT NULL + CHECK CONSTRAINT (Single Step)
   ============================================================ */

ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100) NOT NULL 
CHECK (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');

/*
Explanation:
- Adds a new column 'emergency_contact'
- Data type: VARCHAR(100)
- NOT NULL → Column cannot contain NULL values
- CHECK → Ensures value follows this pattern:
          "Name: PhoneNumber"
          Example: John Doe: +919876543210

⚠ Important:
- This works only if the table has no existing rows 
  OR if a DEFAULT value is provided.
- Otherwise, it will fail because existing rows 
  cannot satisfy NOT NULL immediately.
*/


/* ============================================================
   2️⃣ ADD COLUMN ONLY (No Constraints)
   ============================================================ */

ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100);

/*
Explanation:
- Adds column with no constraints.
- Column allows NULL values.
- No format validation.
- Safest way when table already contains data.

✔ This will always succeed.
❌ But no validation is enforced.
*/


/* ============================================================
   3️⃣ ADD CHECK CONSTRAINT SEPARATELY
   ============================================================ */

ALTER TABLE employees
ADD CHECK (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');

/*
Explanation:
- Adds only CHECK constraint.
- Ensures emergency_contact matches required format.
- Does NOT make column NOT NULL.
- NULL values are still allowed unless specified.

✔ Good approach when:
   - Column already exists
   - You want to add validation later
*/


/* ============================================================
   4️⃣ MODIFY COLUMN TO ADD NOT NULL
   ============================================================ */

ALTER TABLE employees
MODIFY COLUMN emergency_contact VARCHAR(100) NOT NULL;

/*
Explanation:
- Changes existing column definition.
- Makes column NOT NULL.
- Now NULL values are not allowed.

⚠ Important:
- This will fail if existing rows contain NULL values.
- You must update existing NULL rows before running this.
*/


/* ============================================================
   🔎 SUMMARY DIFFERENCE
   ============================================================

1️⃣ First Query
   → Adds column + NOT NULL + CHECK together.
   → Strict and immediate validation.

2️⃣ Second Query
   → Only adds column.
   → No validation, allows NULL.

3️⃣ Third Query
   → Adds format validation (CHECK) separately.
   → Does not restrict NULL.

4️⃣ Fourth Query
   → Enforces NOT NULL later.
   → Requires no existing NULL values.

============================================================ */


-- Rename the column to emergency_contact_info
ALTER TABLE employees 
RENAME COLUMN emergency_contact TO emergency_contact_info;

-- Add a new column for department_id and set it as a foreign key in employees table
ALTER TABLE employees
ADD COLUMN department_id INT;

ALTER TABLE employees
MODIFY COLUMN department_id INT NOT NULL;

ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Writing Foreign Key inside the CREATE TABLE statement
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
============================================================
Difference Between created_at and updated_at Columns
============================================================
*/

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
    Explanation:
    - Automatically stores the current date & time
      when a new row is INSERTED.
    - Value is set only once at creation time.
    - It does NOT change automatically when row is updated.
    - Used to track when the record was created.
    */


    /* ------------------------------------------------------
       2️⃣ updated_at COLUMN
       ------------------------------------------------------ */
    updated_at TIMESTAMP 
    DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,

    /*
    Explanation:
    - Automatically stores current date & time
      when a new row is INSERTED.
    - Additionally, it automatically updates its value
      whenever the row is UPDATED.
    - Used to track last modification time.
    */


    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


/*
============================================================
🔎 Practical Example
============================================================

-- Insert new record
INSERT INTO employees (first_name, last_name, department_id)
VALUES ('John', 'Doe', 1);

Result:
created_at = 2026-02-18 10:00:00
updated_at = 2026-02-18 10:00:00

-- Update record
UPDATE employees
SET salary = 50000
WHERE employee_id = 1;

Result:
created_at = 2026-02-18 10:00:00   (unchanged)
updated_at = 2026-02-18 11:30:00   (automatically updated)

============================================================
📌 Key Difference Summary
============================================================

created_at  → Tracks when record was created.
              Set once during INSERT.
              Does NOT auto-update.

updated_at  → Tracks when record was last modified.
              Set during INSERT.
              Auto-updates on every UPDATE.

============================================================
*/
CREATE TABLE employees (    
    employee_id INT PRIMARY KEY AUTO_INCREMENT,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    /* -------------------------------------------------------
       1️⃣ hire_date with CURRENT_DATE()
       ------------------------------------------------------- */
    hire_date DATE DEFAULT (CURRENT_DATE()),

    /*
    Explanation:
    - CURRENT_DATE() is a DATE function.
    - It returns only the current date (YYYY-MM-DD).
    - Parentheses () are used because it is written
      as a function call.
    - Some databases allow CURRENT_DATE without (),
      but CURRENT_DATE() is the function-style syntax.
    - Since column type is DATE, only date is stored
      (no time part).
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
    Explanation:
    - CURRENT_TIMESTAMP is a special SQL keyword.
    - It returns current date + time.
    - In MySQL, parentheses are optional.
      You can write:
          CURRENT_TIMESTAMP
          CURRENT_TIMESTAMP()
      Both work the same.
    - Since column type is TIMESTAMP,
      it stores both date and time.
    */


    /* -------------------------------------------------------
       3️⃣ updated_at with ON UPDATE CURRENT_TIMESTAMP
       ------------------------------------------------------- */
    updated_at TIMESTAMP 
    DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,

    /*
    Explanation:
    - DEFAULT CURRENT_TIMESTAMP → sets value during INSERT.
    - ON UPDATE CURRENT_TIMESTAMP → automatically updates
      the column whenever the row is modified.
    - Again, parentheses are optional here.
    */


    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Drop Column description from employees table
ALTER TABLE employees
DROP COLUMN description;

-- Drop the employees table
DROP TABLE employees;

-- Drop constraints before dropping the departments table
ALTER TABLE employees
DROP FOREIGN KEY employees_ibfk_1; -- Replace with actual constraint name