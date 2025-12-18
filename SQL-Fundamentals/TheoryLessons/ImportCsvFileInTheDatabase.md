
# 📘 README: Import & Export CSV Files in MySQL and PostgreSQL (SQL + Workbench)

---

## 📌 Overview

This document explains **how to import and export CSV files** into:

* ✅ **MySQL**
* ✅ **PostgreSQL**

using:

* **Pure SQL queries**
* **GUI tools (Workbench / pgAdmin)**

It covers:

* Large CSV files (millions of records)
* CSV with headers
* CSV **without headers**
* Import using **local system**
* Exporting database tables back to CSV
* Performance & best practices

---

## 🧠 Basic Terminology

| Term      | Meaning                           |
| --------- | --------------------------------- |
| CSV       | Comma Separated Values            |
| Header    | First row containing column names |
| Bulk Load | Importing large data efficiently  |
| Workbench | GUI client for DB operations      |
| pgAdmin   | PostgreSQL GUI tool               |

---

# 🟦 PART 1: MYSQL

---

## ✅ Option 1: Import CSV into MySQL Using SQL Query

### 📌 Prerequisites

* MySQL Server running
* CSV file available on **local system**
* Proper table structure exists

---

### 🔹 Step 1: Create Table

```sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    email VARCHAR(150),
    salary DECIMAL(10,2)
);
```

---

### 🔹 Step 2: Import CSV Using `LOAD DATA`

```sql
LOAD DATA LOCAL INFILE 'C:/data/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### 🔍 Explanation

```sql
LOAD DATA LOCAL INFILE  -- Reads file from local machine
FIELDS TERMINATED BY ',' -- CSV separator
ENCLOSED BY '"'         -- Handles quoted values
IGNORE 1 ROWS           -- Skips header row
```

---

### 📌 CSV WITHOUT HEADERS (MySQL)

```sql
LOAD DATA LOCAL INFILE 'C:/data/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
```

---

## ⚡ Import Huge CSV Files (Performance Tips – MySQL)

```sql
SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;
```

After import:

```sql
COMMIT;
SET autocommit=1;
```

✔ Use **InnoDB**
✔ Disable indexes before import
✔ Prefer `LOAD DATA` over `INSERT`

---

## 🧰 Option 2: Import CSV Using MySQL Workbench (GUI)

![Image](https://dev.mysql.com/doc/workbench/en/images/wb-table-data-wizard-menu.png?utm_source=chatgpt.com)

![Image](https://dev.mysql.com/doc/workbench/en/images/wb-navigator-data-export-object.png?utm_source=chatgpt.com)

### 🔹 Step-by-Step (Workbench)

1. Open **MySQL Workbench**
2. Connect to Database
3. Select **Schema**
4. Right-click → **Table Data Import Wizard**
5. Choose **CSV File**
6. Select **Destination Table**
7. Map Columns
8. Click **Next → Import**

📍 **Highlighted Buttons**

* *Table Data Import Wizard*
* *Next*
* *Import*

---

## 📤 Export CSV from MySQL (SQL)

```sql
SELECT * 
INTO OUTFILE 'C:/data/export_employees.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM employees;
```

📌 Add Header Manually:

```sql
SELECT 'id','name','email','salary'
UNION ALL
SELECT id,name,email,salary FROM employees;
```

---

# 🟩 PART 2: POSTGRESQL

---

## ✅ Option 1: Import CSV Using SQL (`COPY`)

### 🔹 Step 1: Create Table

```sql
CREATE TABLE employees (
    id INT,
    name TEXT,
    email TEXT,
    salary NUMERIC
);
```

---

### 🔹 Step 2: Import CSV (WITH HEADER)

```sql
COPY employees
FROM '/data/employees.csv'
DELIMITER ','
CSV HEADER;
```

---

### 📌 CSV WITHOUT HEADER (PostgreSQL)

```sql
COPY employees
FROM '/data/employees.csv'
DELIMITER ','
CSV;
```

---

### 📌 Import from Local Machine (Client Side)

```sql
\copy employees
FROM 'C:/data/employees.csv'
DELIMITER ','
CSV HEADER;
```

🔹 Use `\copy` when file is on **your PC**, not server.

---

## ⚡ Import Huge CSV Files (PostgreSQL Best Practices)

✔ Use `COPY` instead of `INSERT`
✔ Disable indexes temporarily
✔ Increase `work_mem`
✔ Use `UNLOGGED` tables for faster loads

```sql
CREATE UNLOGGED TABLE employees (...);
```

---

## 🧰 Option 2: Import CSV Using pgAdmin (GUI)

![Image](https://i.ytimg.com/vi/Ikd2xSb00UI/maxresdefault.jpg?utm_source=chatgpt.com)

![Image](https://www.pgadmin.org/static/docs/pgadmin4-9.11-docs/_images/import_export_columns.png?utm_source=chatgpt.com)

![Image](https://www.commandprompt.com/media/images/image_FF41kIp.width-1200.format-webp.webp?utm_source=chatgpt.com)

### 🔹 Step-by-Step (pgAdmin)

1. Open **pgAdmin**
2. Expand Database → Schema → Tables
3. Right-click Table → **Import/Export Data**
4. Choose **Import**
5. Select CSV file
6. Enable **Header** (if present)
7. Choose delimiter `,`
8. Click **OK**

📍 **Highlighted Options**

* Import/Export Data
* Header checkbox
* Delimiter field

---

## 📤 Export CSV from PostgreSQL

### 🔹 SQL Export

```sql
COPY employees
TO '/data/export_employees.csv'
DELIMITER ','
CSV HEADER;
```

---

### 🔹 Client Side Export

```sql
\copy employees
TO 'C:/data/export_employees.csv'
CSV HEADER;
```

---

## 📊 CSV Import Workflow Diagram

![Image](https://d2slcw3kip6qmk.cloudfront.net/marketing/blog/2017Q3/CSV-Import/Swim-Lane-Process-Map.png?utm_source=chatgpt.com)

![Image](https://docs.tibco.com/pub/fsi/1.0.0/doc/html/GUID-43F87C14-C34F-4519-B5BA-5D5E03484F6F-display.png?utm_source=chatgpt.com)

---

## 🧪 Handling Errors & Edge Cases

| Issue                | Solution                    |
| -------------------- | --------------------------- |
| NULL values          | Use `NULL AS ''`            |
| Date format mismatch | Pre-format CSV              |
| Encoding issues      | Save CSV as UTF-8           |
| Huge file fails      | Split CSV / increase memory |

---

## 📝 Summary Table

| DB         | Best Import Method | Best Export Method  |
| ---------- | ------------------ | ------------------- |
| MySQL      | LOAD DATA INFILE   | SELECT INTO OUTFILE |
| PostgreSQL | COPY / \copy       | COPY TO             |

---

## ✅ Key Takeaways

✔ Use **SQL bulk loaders** for large data
✔ GUI tools are good for **small/medium files**
✔ Handle **headers explicitly**
✔ Avoid row-by-row inserts
✔ Always validate data after import

---