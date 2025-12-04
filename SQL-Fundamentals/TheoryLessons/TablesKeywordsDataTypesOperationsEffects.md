
---

# 📘 **README — Complete SQL Guide (MySQL vs PostgreSQL)**

### *Tables, Keywords, Datatypes, Operations & Effects*

---

# ⚙️ **1. Introduction**

This document explains **every SQL keyword, datatype, clause, and operation** used in the provided queries for **MySQL** and **PostgreSQL**.

It also includes **Before/After** table states to help understand how each operation affects the database.

---

# 🗃️ **2. Table Creation**

---

## ✅ **MySQL Example**

```sql
CREATE TABLE company.employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
```

---

## 📌 **Keyword-by-Keyword Explanation (MySQL)**

| Keyword / Datatype       | Meaning                                         |
| ------------------------ | ----------------------------------------------- |
| **CREATE TABLE**         | Creates a new table in a database/schema.       |
| **company.employees**    | `company` = database, `employees` = table.      |
| **(**…`)`                | Defines table columns.                          |
| **id**                   | Column name.                                    |
| **INT**                  | Integer datatype.                               |
| **PRIMARY KEY**          | Unique identifier for each row.                 |
| **AUTO_INCREMENT**       | Automatically generates increasing numeric IDs. |
| **name VARCHAR(100)**    | Variable-length string up to 100 chars.         |
| **NOT NULL**             | Value cannot be empty.                          |
| **hire_date DATE**       | Stores YYYY-MM-DD format.                       |
| **salary NUMERIC(10,2)** | 10 digits total, 2 decimal places.              |

---

## 🔍 **Before Table Creation**

**company database contains:**

```
(no tables)
```

---

## 📄 **After Table Creation**

```
TABLE: company.employees

+-------------+---------------------+-----------+----------+
| Column Name | Datatype            | Nullable  | Notes    |
+-------------+---------------------+-----------+----------+
| id          | INT                 | No        | PK, AI   |
| name        | VARCHAR(100)        | No        |          |
| hire_date   | DATE                | Yes       |          |
| salary      | NUMERIC(10,2)       | Yes       |          |
+-------------+---------------------+-----------+----------+
```

---

# 🐘 **3. PostgreSQL Table Creation**

```sql
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
```

---

## 📌 **Keyword-by-Keyword Explanation (PostgreSQL)**

| Keyword           | Meaning                                    |
| ----------------- | ------------------------------------------ |
| **hr.employees**  | Schema: `hr`, Table: `employees`           |
| **SERIAL**        | Auto-increment integer (creates sequence). |
| **PRIMARY KEY**   | Unique row identifier.                     |
| **VARCHAR(100)**  | Same as MySQL.                             |
| **NOT NULL**      | Same as MySQL.                             |
| **DATE**          | Same as MySQL.                             |
| **NUMERIC(10,2)** | Same as MySQL.                             |

---

## 🔍 Before Table Creation

```
Schema hr contains:
(no tables)
```

---

## 📄 After Table Creation

```
TABLE: hr.employees

+-------------+---------------------+-----------+----------+
| Column Name | Datatype            | Nullable  | Notes    |
+-------------+---------------------+-----------+----------+
| id          | SERIAL              | No        | PK       |
| name        | VARCHAR(100)        | No        |          |
| hire_date   | DATE                | Yes       |          |
| salary      | NUMERIC(10,2)       | Yes       |          |
+-------------+---------------------+-----------+----------+
```

---

# 📝 **4. Inserting Data**

---

## MySQL

```sql
INSERT INTO company.employees (name, hire_date, salary) VALUES
('Alice Johnson', '2020-01-15', 60000.00),
('Bob Smith', '2019-03-22', 55000.00),
('Charlie Brown', '2021-07-30', 70000.00);
```

---

## Keyword Explanation

| Keyword                                       | Meaning                 |
| --------------------------------------------- | ----------------------- |
| **INSERT INTO**                               | Adds new rows.          |
| **company.employees**                         | Target table.           |
| **(name, hire_date, salary)**                 | Columns receiving data. |
| **VALUES**                                    | List of rows to insert. |
| **('Alice Johnson', '2020-01-15', 60000.00)** | Actual row values.      |

---

## Before Insert

```
employees table is empty.
```

---

## After Insert

| id | name          | hire_date  | salary   |
| -- | ------------- | ---------- | -------- |
| 1  | Alice Johnson | 2020-01-15 | 60000.00 |
| 2  | Bob Smith     | 2019-03-22 | 55000.00 |
| 3  | Charlie Brown | 2021-07-30 | 70000.00 |

---

# 🔧 **5. ALTER TABLE (Rename Column)**

---

## MySQL

```sql
ALTER TABLE company.employees
RENAME COLUMN hire_date TO date_hired;
```

---

### Keywords

| Keyword           | Meaning                             |
| ----------------- | ----------------------------------- |
| **ALTER TABLE**   | Modify structure of existing table. |
| **RENAME COLUMN** | Change column name.                 |
| **hire_date**     | Old name.                           |
| **TO date_hired** | New name.                           |

---

### Before

Columns:

```
id, name, hire_date, salary
```

### After

```
id, name, date_hired, salary
```

---

# ➕ **6. Add Column**

---

```sql
ALTER TABLE company.employees   
ADD COLUMN department VARCHAR(50);
```

### Before

```
id, name, date_hired, salary
```

### After

```
id, name, date_hired, salary, department
```

---

# 🔄 **7. Updating Data**

---

```sql
UPDATE company.employees
SET salary = salary * 1.05
WHERE date_hired < '2020-01-01';
```

---

### Keywords

| Keyword                    | Meaning                       |
| -------------------------- | ----------------------------- |
| **UPDATE**                 | Modify existing rows.         |
| **SET**                    | Assign new values.            |
| **salary = salary * 1.05** | Increase salary by 5%.        |
| **WHERE**                  | Filters which rows to update. |

### Before

```
Bob Smith (2019-03-22, 55000)
```

### After

```
Bob Smith salary = 57750.00
```

---

# ❌ **8. Deleting Rows**

---

```sql
DELETE FROM company.employees
WHERE name = 'Bob Smith';
```

### Before

```
Bob Smith exists
```

### After

```
Bob Smith removed
```

---

# 🗑️ **9. Dropping Table**

```sql
DROP TABLE company.employees;
```

Effect:

* Table removed permanently.

---

# 🧹 **10. Truncate Table**

```sql
TRUNCATE TABLE company.employees;
```

Effect:

* Deletes all rows
* Keeps table structure

---

# 🔁 **11. Truncate With Restart Identity**

```sql
TRUNCATE TABLE company.employees RESTART IDENTITY;
```

Effect:

* Deletes rows
* Resets auto-increment/SERIAL back to 1

---

# 💣 **12. Drop Database / Schema**

---

### MySQL

```sql
DROP DATABASE company;
```

### PostgreSQL

```sql
DROP SCHEMA hr CASCADE;
```

* **CASCADE** = delete schema and all objects inside it

---

# 🎯 **Complete Summary Table: MySQL vs PostgreSQL**

| Feature            | MySQL            | PostgreSQL       |
| ------------------ | ---------------- | ---------------- |
| Database vs Schema | Same             | Different        |
| AUTO_INCREMENT     | AUTO_INCREMENT   | SERIAL           |
| Truncate identity  | RESTART IDENTITY | RESTART IDENTITY |
| USE db             | Supported        | ❌ Not supported  |
| search_path        | ❌                | ✔ Needed         |

---

# ➖ **13. Dropping / Deleting a Column (MySQL & PostgreSQL)**

---

## ✅ **MySQL — Delete a Column**

```sql
ALTER TABLE company.employees
DROP COLUMN department;
```

---

## 🐘 **PostgreSQL — Delete a Column**

```sql
ALTER TABLE hr.employees
DROP COLUMN department;
```

---

# ➖ **14. Dropping Multiple Columns**

---

## MySQL

```sql
ALTER TABLE company.employees
DROP COLUMN department,
DROP COLUMN hire_date;
```

---

## PostgreSQL

```sql
ALTER TABLE hr.employees
DROP COLUMN department,
DROP COLUMN hire_date;
```

---

# 🛡️ **15. Safe Drop Column (IF EXISTS)**

---

## MySQL (Supported)

```sql
ALTER TABLE company.employees
DROP COLUMN IF EXISTS department;
```

---

## PostgreSQL (Supported)

```sql
ALTER TABLE hr.employees
DROP COLUMN IF EXISTS department;
```

---

# 📐 **16. ER Diagram (ASCII Text-Based)**

```
+--------------------------+
|        employees         |
+--------------------------+
| id           (PK)        |
| name                      |
| position                  |
| department                |
| hire_date                 |
| salary                    |
+--------------------------+
```

---