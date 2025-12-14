# 📘 README — Complete Guide to UPDATE Operations in SQL (MySQL & PostgreSQL)

This document explains **every type of UPDATE operation** in SQL including:

* Updating **data**
* Updating **columns**
* Updating **table structure**
* Updating **data types**
* Updating **constraints**
* Differences between **MySQL** and **PostgreSQL**

All concepts include:

* Practical tables
* Before/After outputs
* Flow diagrams
* Charts & explanations

---

# 🔹 1. Introduction to UPDATE in SQL

The `UPDATE` statement modifies existing records in a table. But **UPDATE** extends far beyond just updating data—it includes updating table structure, datatypes, constraints and more.

---

# 🔹 2. Updating Data in SQL

### Syntax

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

---

# 🧪 Example Table

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    department VARCHAR(30)
);

INSERT INTO employees VALUES
(1, 'Alice', 50000, 'IT'),
(2, 'Bob', 45000, 'Finance'),
(3, 'Charlie', 55000, 'IT');
```

### 📊 **Before Update**

| emp_id | emp_name | salary | department |
| ------ | -------- | ------ | ---------- |
| 1      | Alice    | 50000  | IT         |
| 2      | Bob      | 45000  | Finance    |
| 3      | Charlie  | 55000  | IT         |

---

# 🔹 2.1 Update a Single Column

```sql
UPDATE employees
SET salary = 60000
WHERE emp_id = 1;
```

### 📊 **After Update**

| emp_id | emp_name | salary | department |
| ------ | -------- | ------ | ---------- |
| 1      | Alice    | 60000  | IT         |
| 2      | Bob      | 45000  | Finance    |
| 3      | Charlie  | 55000  | IT         |

---

# 🔹 2.2 Update Multiple Columns

```sql
UPDATE employees
SET salary = 48000, department = 'Accounts'
WHERE emp_id = 2;
```

### 📊 After Update

| emp_id | emp_name | salary | department |
| ------ | -------- | ------ | ---------- |
| 2      | Bob      | 48000  | Accounts   |

---

# 🔹 2.3 Update All Rows

```sql
UPDATE employees
SET salary = salary + 5000;
```

---

# 🔹 3. Updating Columns (ALTER TABLE)

Updating columns means modifying column names, types, default values.

## 3.1 Rename a Column

### MySQL

```sql
ALTER TABLE employees RENAME COLUMN emp_name TO employee_name;
```

### PostgreSQL

Same syntax.

---

## 3.2 Modify Column Data Type

### MySQL

```sql
ALTER TABLE employees MODIFY salary DECIMAL(10,2);
```

### PostgreSQL

```sql
ALTER TABLE employees ALTER COLUMN salary TYPE DECIMAL(10,2);
```

---

# 🧩 Before Changing Data Type

| Column | Type |
| ------ | ---- |
| salary | INT  |

# 🧩 After Changing Data Type

| Column | Type          |
| ------ | ------------- |
| salary | DECIMAL(10,2) |

---

# 🔹 4. Updating Table Structure

These include adding, dropping or modifying columns.

## 4.1 Add a Column

### MySQL/PostgreSQL

```sql
ALTER TABLE employees ADD address VARCHAR(100);
```

---

## 4.2 Drop a Column

### MySQL

```sql
ALTER TABLE employees DROP COLUMN address;
```

### PostgreSQL

Same syntax.

---

# 🔹 5. Updating Constraints

Constraints control rules applied to data.

## 5.1 Add NOT NULL Constraint

### MySQL

```sql
ALTER TABLE employees MODIFY emp_name VARCHAR(50) NOT NULL;
```

### PostgreSQL

```sql
ALTER TABLE employees ALTER COLUMN emp_name SET NOT NULL;
```

---

## 5.2 Add UNIQUE Constraint

```sql
ALTER TABLE employees ADD CONSTRAINT unique_name UNIQUE(emp_name);
```

---

## 5.3 Add CHECK Constraint

### PostgreSQL

```sql
ALTER TABLE employees ADD CONSTRAINT salary_check CHECK (salary > 0);
```

### MySQL (v8+ only)

```sql
ALTER TABLE employees ADD CONSTRAINT salary_check CHECK (salary > 0);
```

---

# 🔹 6. Updating Primary Key

```sql
ALTER TABLE employees
ADD CONSTRAINT pk_emp PRIMARY KEY (emp_id);
```

---

# 🔹 7. Updating Foreign Keys

```sql
ALTER TABLE orders
ADD CONSTRAINT fk_emp FOREIGN KEY(emp_id) REFERENCES employees(emp_id);
```

---

# 🔹 8. Dropping Constraints

```sql
ALTER TABLE employees DROP CONSTRAINT salary_check;
```

MySQL:

```sql
ALTER TABLE employees DROP CHECK salary_check;
```

---

# 🔹 9. Flow Diagram: UPDATE Lifecycle

```
           +----------------------+
           |  User Executes Query |
           +----------+-----------+
                      |
                      v
         +------------+-------------+
         | SQL Parser Validates SQL |
         +------------+-------------+
                      |
                      v
     +----------------+------------------+
     | Database Engine Finds Rows to Update |
     +----------------+------------------+
                      |
                      v
        +-------------+--------------+
        |    Data is Modified        |
        +-------------+--------------+
                      |
                      v
        +-------------+--------------+
        | Transaction Commit/Save    |
        +-----------------------------+
```

---

# 🔹 10. MySQL vs PostgreSQL — Differences for UPDATE

| Feature           | MySQL             | PostgreSQL                |
| ----------------- | ----------------- | ------------------------- |
| ALTER TYPE        | `MODIFY`          | `ALTER COLUMN TYPE`       |
| CHECK constraints | Limited earlier   | Fully supported           |
| JSON updates      | Basic             | Advanced JSONB operations |
| Concurrency       | Table-level locks | Row-level MVCC            |

---

# 🔹 11. Updating JSON Fields (Advanced)

### PostgreSQL

```sql
UPDATE employees
SET details = jsonb_set(details, '{address}', '"Mumbai"');
```

### MySQL

```sql
UPDATE employees
SET details = JSON_SET(details, '$.address', 'Mumbai');
```

---

# 🔹 12. Sorting Table Data Using ORDER BY (MySQL & PostgreSQL)

Sorting data is a **read-only operation** that helps organize query results in a meaningful order.
It does **not modify table data**, only how results are displayed.

The `ORDER BY` clause is used for sorting.

---

## 🔹 12.1 Syntax for Sorting Data

```sql
SELECT column1, column2
FROM table_name
ORDER BY column_name ASC | DESC;
```

* `ASC` → Ascending order (default)
* `DESC` → Descending order

---

## 🧪 Example Table (employees)

### 📊 **Before Sorting (Original Order)**

| emp_id | emp_name | salary | department |
| -----: | -------- | -----: | ---------- |
|      1 | Alice    |  50000 | IT         |
|      2 | Bob      |  45000 | Finance    |
|      3 | Charlie  |  55000 | IT         |

---

## 🔹 12.2 Sort Employees by Salary (Ascending Order)

### MySQL & PostgreSQL

```sql
SELECT emp_id, emp_name, salary, department
FROM employees
ORDER BY salary ASC;
```

### 📊 **After Sorting (Ascending Salary)**

| emp_id | emp_name | salary | department |
| -----: | -------- | -----: | ---------- |
|      2 | Bob      |  45000 | Finance    |
|      1 | Alice    |  50000 | IT         |
|      3 | Charlie  |  55000 | IT         |

### 📝 Explanation

* Employees are sorted from **lowest salary to highest**
* `ASC` is optional (default behavior)

---

## 🔹 12.3 Sort Employees by Salary (Descending Order)

### MySQL & PostgreSQL

```sql
SELECT emp_id, emp_name, salary, department
FROM employees
ORDER BY salary DESC;
```

### 📊 **After Sorting (Descending Salary)**

| emp_id | emp_name | salary | department |
| -----: | -------- | -----: | ---------- |
|      3 | Charlie  |  55000 | IT         |
|      1 | Alice    |  50000 | IT         |
|      2 | Bob      |  45000 | Finance    |

### 📝 Explanation

* Employees are sorted from **highest salary to lowest**
* Commonly used for **top earners, rankings**

---

## 🔹 12.4 Sort by Multiple Columns

### Example: Sort by department first, then salary

### MySQL & PostgreSQL

```sql
SELECT emp_id, emp_name, salary, department
FROM employees
ORDER BY department ASC, salary DESC;
```

### 📊 **After Sorting**

| emp_id | emp_name | salary | department |
| -----: | -------- | -----: | ---------- |
|      2 | Bob      |  45000 | Finance    |
|      3 | Charlie  |  55000 | IT         |
|      1 | Alice    |  50000 | IT         |

### 📝 Explanation

* First sorted by **department (A–Z)**
* Then sorted by **salary (high to low)** within each department

---

## 🔹 12.5 Sorting with WHERE Condition

### Example: Sort only IT employees by salary

```sql
SELECT emp_name, salary
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC;
```

### 📊 **Result**

| emp_name | salary |
| -------- | ------ |
| Charlie  | 55000  |
| Alice    | 50000  |

---

## 🔹 12.6 MySQL vs PostgreSQL — ORDER BY Comparison

| Feature          | MySQL               | PostgreSQL           |
| ---------------- | ------------------- | -------------------- |
| ORDER BY syntax  | Same                | Same                 |
| ASC / DESC       | Supported           | Supported            |
| Multiple columns | Supported           | Supported            |
| NULL sorting     | NULL last (default) | NULL first (default) |

---

## 🔹 12.7 Key Notes (Interview Important)

* `ORDER BY` is executed **after WHERE**
* Sorting affects **result set only**
* Indexes can improve sorting performance
* Use `LIMIT` with `ORDER BY` for top-N results

```sql
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 1;
```
---

## 🏁 Final Note

This section completes your README by covering **data sorting operations**, making the guide **100% practical and interview-ready** for both **MySQL and PostgreSQL**.

---
