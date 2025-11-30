# 📘 SQL Keywords & Syntax Explanation (MySQL vs PostgreSQL)

---

# ------------------------------------------------------------

# 🟥 Difference Between: CREATE DATABASE vs CREATE SCHEMA

# ------------------------------------------------------------

## 🔹 CREATE DATABASE

* **CREATE** → SQL command used to create new objects (Database, Schema, Table, etc.)
* **DATABASE** → Top-level container that stores schemas, tables, views, procedures, etc.
* **company** → Name of the new database.

MySQL:

```sql
CREATE DATABASE company;
```

PostgreSQL:

```sql
CREATE DATABASE company_db;
```

### What it means:

A brand-new database named `company` (MySQL) or `company_db` (PostgreSQL) is created.

---

## 🔹 CREATE SCHEMA

* **SCHEMA** → A namespace used to organize tables inside a database.
* **company / hr** → Schema name.

MySQL:

```sql
CREATE SCHEMA company;
```

(PostgreSQL treats schema differently but command is same)

```sql
CREATE SCHEMA hr;
```

### Keyword Breakdown:

| Keyword | Meaning                          |
| ------- | -------------------------------- |
| CREATE  | Create a new SQL object          |
| SCHEMA  | Logical folder inside a database |
| hr      | Schema name                      |

---

# ------------------------------------------------------------

# 🟥 Using a Database / Schema

# ------------------------------------------------------------

## 🔹 MySQL: USE command

```sql
USE company;
```

### Explanation:

* **USE** → Switches the active database for the current connection.
* **company** → Name of the database to switch to.

---

## 🔹 PostgreSQL: search_path

PostgreSQL does NOT support the `USE` command.

Instead:

```sql
SET search_path TO hr;
```

### Keyword Breakdown:

| Keyword     | Meaning                       |
| ----------- | ----------------------------- |
| SET         | Change session-level setting  |
| search_path | Default schema search order   |
| TO          | Assignment operator           |
| hr          | Schema name to set as default |

### Meaning:

PostgreSQL will now search tables inside schema **hr** by default.

---

# ------------------------------------------------------------

# 🟥 Creating Tables

# ------------------------------------------------------------

## 🔹 MySQL Table Example

```sql
CREATE TABLE company.employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
```

### Keyword & Datatype Breakdown:

| Element           | Explanation                                              |
| ----------------- | -------------------------------------------------------- |
| CREATE TABLE      | Creates a new table                                      |
| company.employees | Schema/database + table name                             |
| id                | Column name                                              |
| INT               | Integer datatype                                         |
| PRIMARY KEY       | Uniquely identifies each row                             |
| name              | Column name                                              |
| VARCHAR(100)      | Variable-length string up to 100 chars                   |
| NOT NULL          | Value cannot be NULL                                     |
| hire_date         | Column name                                              |
| DATE              | Stores date in YYYY-MM-DD format                         |
| salary            | Column name                                              |
| NUMERIC(10,2)     | Precise numeric value (10 digits total, 2 after decimal) |

---

## 🔹 PostgreSQL Table Example

```sql
CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE,
    salary NUMERIC(10, 2)
);
```

### Keyword Differences (PostgreSQL):

| Keyword / Datatype | Meaning                                      |
| ------------------ | -------------------------------------------- |
| SERIAL             | Auto-increment integer (PostgreSQL-specific) |

PostgreSQL automatically creates a sequence for `SERIAL`.

---

# ------------------------------------------------------------

# 🟥 Selecting Data From Tables

# ------------------------------------------------------------

## 🔹 MySQL

```sql
SELECT * FROM company.employees;
```

## 🔹 PostgreSQL

```sql
SELECT * FROM hr.employees;
```

### Keyword Breakdown:

| Keyword                          | Explanation            |
| -------------------------------- | ---------------------- |
| SELECT                           | Retrieve data          |
| *                                | All columns            |
| FROM                             | Source table           |
| company.employees / hr.employees | Schema/table reference |

---

# ------------------------------------------------------------

# 🟦 Summary of All Important SQL Keywords

# ------------------------------------------------------------

| Keyword                    | Meaning                   |
| -------------------------- | ------------------------- |
| CREATE                     | Create SQL object         |
| DATABASE                   | Entire database container |
| SCHEMA                     | Namespace inside database |
| TABLE                      | Create a table            |
| USE (MySQL)                | Switch database           |
| SET search_path (Postgres) | Set default schema        |
| PRIMARY KEY                | Uniquely identifies rows  |
| NOT NULL                   | Cannot be null            |
| SERIAL (Postgres)          | Auto-increment integer    |
| INT                        | Integer datatype          |
| VARCHAR(n)                 | String of max length n    |
| DATE                       | Stores calendar date      |
| NUMERIC(10,2)              | Precise decimal values    |
| SELECT                     | Fetch data                |
| FROM                       | Specify table             |

---

# ✔ Final Notes

* MySQL: **DATABASE = SCHEMA**
* PostgreSQL: **DATABASE ≠ SCHEMA**
* MySQL allows switching DB using `USE`.
* PostgreSQL requires reconnecting & uses `search_path` for schemas.

---
