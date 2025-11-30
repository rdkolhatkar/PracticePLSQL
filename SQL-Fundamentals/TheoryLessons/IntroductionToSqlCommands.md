
---

# ✅ **What is SQL?**

**SQL (Structured Query Language)** is a standard language used to store, manipulate, and retrieve data from relational databases such as MySQL, PostgreSQL, Oracle, SQL Server, etc.

SQL helps you:

* Create and manage database structures
* Insert, update, delete data
* Control user access
* Perform transactions safely
* Query (search) data efficiently

---

# 📌 **Basic Concepts of SQL**

## 1️⃣ **Database**

A **database** is a collection of organized data stored electronically.

## 2️⃣ **Table**

A **table** is a structured format storing data in **rows** and **columns**.

### 📐 **Diagram: Table Structure**

```
+----------+--------------+--------------------------+
| emp_id   | name         | email                   |
+----------+--------------+--------------------------+
| 101      | Rahul        | rahul@gmail.com         |
| 102      | Priya        | priya@yahoo.com         |
+----------+--------------+--------------------------+
```

* **Columns** = fields (structure)
* **Rows** = records (data)

## 3️⃣ **Row**

A row represents a **single data record**.

## 4️⃣ **Column**

A column represents an **attribute** of the data.

---

# 🧱 **Types of SQL Commands**

SQL commands are grouped into **five major categories**:

1. **DDL** – Data Definition Language
2. **DML** – Data Manipulation Language
3. **DQL** – Data Query Language
4. **TCL** – Transaction Control Language
5. **DCL** – Data Control Language

Let’s explain each one in detail.

---

# 1️⃣ **DDL — Data Definition Language**

DDL commands **define and manage database structure** such as tables, schemas, indexes, etc.

## ✔️ Keywords / Commands:

* **CREATE**
* **ALTER**
* **DROP**
* **TRUNCATE**
* **RENAME**

### 👉 Importance:

* Used to **create database structures**.
* Changes the **schema**.
* Auto-committed (changes cannot be rolled back).

---

## ✔️ **Examples**

### **1. CREATE – Create a table**

```sql
CREATE TABLE Employees (
   emp_id INT PRIMARY KEY,
   name VARCHAR(50),
   salary DECIMAL(10,2),
   email VARCHAR(100)
);
```

### **2. ALTER – Add/modify column**

```sql
ALTER TABLE Employees ADD phone VARCHAR(20);
```

### **3. DROP – Delete a table**

```sql
DROP TABLE Employees;
```

### **4. TRUNCATE – Delete all rows (structure remains)**

```sql
TRUNCATE TABLE Employees;
```

---

# 2️⃣ **DML — Data Manipulation Language**

DML commands **work with data** inside tables.

## ✔️ Keywords / Commands:

* **INSERT**
* **UPDATE**
* **DELETE**

### 👉 Importance:

* Used to **change data** in tables.
* Changes **can be rolled back** using TCL.

---

## ✔️ **Examples**

### **1. INSERT – Insert data**

```sql
INSERT INTO Employees VALUES (101, 'Rahul', 45000, 'rahul@gmail.com');
```

### **2. UPDATE – Update existing data**

```sql
UPDATE Employees SET salary = 50000 WHERE emp_id = 101;
```

### **3. DELETE – Remove data**

```sql
DELETE FROM Employees WHERE emp_id = 101;
```

---

# 3️⃣ **DQL — Data Query Language**

Used only for **querying (retrieving)** data.

## ✔️ Keyword:

* **SELECT**

### 👉 Importance:

* Retrieves data from one or more tables.
* Most frequently used command in SQL.

---

## ✔️ **Example**

### **SELECT – Get data**

```sql
SELECT name, salary FROM Employees WHERE salary > 40000;
```

### 🔍 Diagram: Query Flow

```
CLIENT ---- SELECT query ----> DATABASE ---- returns result ----> CLIENT
```

---

# 4️⃣ **TCL — Transaction Control Language**

TCL commands help manage **transactions** (a group of SQL statements executed as a unit).

## ✔️ Keywords / Commands:

* **COMMIT**
* **ROLLBACK**
* **SAVEPOINT**

### 👉 Importance:

* Ensures **data integrity**
* Allows **safe undoing** of operations
* Used with DML commands

---

## ✔️ **Examples**

### 1. COMMIT – Save changes permanently

```sql
COMMIT;
```

### 2. ROLLBACK – Undo changes

```sql
ROLLBACK;
```

### 3. SAVEPOINT – Create a checkpoint

```sql
SAVEPOINT s1;
```

Example transaction:

```sql
BEGIN;

UPDATE Employees SET salary=50000 WHERE emp_id=102;
SAVEPOINT s1;

UPDATE Employees SET salary=55000 WHERE emp_id=103;

ROLLBACK TO s1;   -- Undo second update only

COMMIT;           -- Final save
```

---

# 5️⃣ **DCL — Data Control Language**

DCL commands **control access** to the database.

## ✔️ Keywords / Commands:

* **GRANT**
* **REVOKE**

### 👉 Importance:

* Used in security
* Controls **permissions** for users

---

## ✔️ **Examples**

### 1. GRANT – Give permission

```sql
GRANT SELECT, INSERT ON Employees TO user1;
```

### 2. REVOKE – Remove permission

```sql
REVOKE INSERT ON Employees FROM user1;
```

---

# 🎯 Summary Table

| Command Type | Purpose             | Keywords                      |
| ------------ | ------------------- | ----------------------------- |
| **DDL**      | Define structure    | CREATE, ALTER, DROP, TRUNCATE |
| **DML**      | Modify data         | INSERT, UPDATE, DELETE        |
| **DQL**      | Retrieve data       | SELECT                        |
| **TCL**      | Manage transactions | COMMIT, ROLLBACK, SAVEPOINT   |
| **DCL**      | Manage permissions  | GRANT, REVOKE                 |

---

# 🧠 Final Concept Diagram (Mind Map)

```
                            SQL
                             |
     ------------------------------------------------------
     |           |             |             |             |
    DDL         DML           DQL           TCL           DCL
  (Structure) (Data)      (Query Data)   (Transactions) (Security)
     |           |             |             |             |
 CREATE      INSERT          SELECT       COMMIT        GRANT
 ALTER       UPDATE                         ROLLBACK    REVOKE
 DROP        DELETE                         SAVEPOINT
 TRUNCATE
```

---
