# 📘 SQL FUNCTIONS – COMPLETE GUIDE (MySQL & PostgreSQL)

> **Audience**: Freshers to experienced developers
> **Databases Covered**: **MySQL** and **PostgreSQL**
> **Goal**: Explain **all kinds of SQL functions** from **basic to advanced**, with **clear examples**, **before & after table data**, and **syntax differences** between MySQL and PostgreSQL.

---

## 📌 WHAT ARE SQL FUNCTIONS?

An **SQL function** is a **predefined operation** that takes **input values**, performs a **specific task**, and returns a **result**.

### Why Functions Are Important?

* Reduce complex logic
* Reusable & readable queries
* Perform calculations, transformations, conditions
* Essential for reporting & analytics

---

## 📂 TYPES OF SQL FUNCTIONS

1. **String Functions**
2. **Numeric Functions**
3. **Date & Time Functions**
4. **Aggregate Functions**
5. **Conditional Functions**
6. **CASE Expression (Assignments & Logic)**
7. **NULL Handling Functions (COALESCE, NULLIF)**
8. **Conversion Functions**
9. **Window (Analytical) Functions**
10. **Advanced Functions**

---

# 1️⃣ STRING FUNCTIONS

## Sample Table: `employees`

### Before Data

| id | name     | email                                           | dept    |
| -- | -------- | ----------------------------------------------- | ------- |
| 1  | John Doe | [John@Email.Com](mailto:John@Email.Com)         | it      |
| 2  | alice    | [alice@test.com](mailto:alice@test.com)         | hr      |
| 3  | ROBERT   | [robert@company.COM](mailto:robert@company.COM) | finance |

---

## 🔹 UPPER()

### Purpose

Converts text to **uppercase**

### MySQL & PostgreSQL

```sql
SELECT UPPER(name) FROM employees;
```

### Result

| upper    |
| -------- |
| JOHN DOE |
| ALICE    |
| ROBERT   |

---

## 🔹 LOWER()

```sql
SELECT LOWER(email) FROM employees;
```

### Result

All emails become lowercase

---

## 🔹 LENGTH() vs CHAR_LENGTH()

| DB         | Function                |
| ---------- | ----------------------- |
| MySQL      | LENGTH(), CHAR_LENGTH() |
| PostgreSQL | LENGTH()                |

```sql
SELECT LENGTH(name) FROM employees;
```

---

## 🔹 CONCAT()

### MySQL

```sql
SELECT CONCAT(name, ' - ', dept) FROM employees;
```

### PostgreSQL

```sql
SELECT name || ' - ' || dept FROM employees;
```

---

## 🔹 SUBSTRING()

```sql
SELECT SUBSTRING(name, 1, 4) FROM employees;
```

Extracts first 4 characters

---

## 🔹 TRIM(), LTRIM(), RTRIM()

```sql
SELECT TRIM('   hello   ');
```

Removes spaces

---

## 🔹 REPLACE()

```sql
SELECT REPLACE(email, 'Email', 'email') FROM employees;
```

---

# 2️⃣ NUMERIC FUNCTIONS

## Sample Table: `salary`

### Before Data

| emp_id | amount   |
| ------ | -------- |
| 1      | 50000.75 |
| 2      | 42000.40 |
| 3      | 60000.90 |

---

## 🔹 ROUND()

```sql
SELECT ROUND(amount) FROM salary;
```

---

## 🔹 CEIL() / FLOOR()

```sql
SELECT CEIL(amount), FLOOR(amount) FROM salary;
```

---

## 🔹 ABS()

```sql
SELECT ABS(-100);
```

---

## 🔹 MOD()

```sql
SELECT MOD(10, 3);
```

---

# 3️⃣ DATE & TIME FUNCTIONS

## Sample Table: `orders`

### Before Data

| order_id | order_date |
| -------- | ---------- |
| 1        | 2024-01-10 |
| 2        | 2024-05-18 |

---

## 🔹 CURRENT_DATE

| DB         | Syntax       |
| ---------- | ------------ |
| MySQL      | CURDATE()    |
| PostgreSQL | CURRENT_DATE |

---

## 🔹 CURRENT_TIMESTAMP

```sql
SELECT CURRENT_TIMESTAMP;
```

---

## 🔹 EXTRACT()

```sql
SELECT EXTRACT(YEAR FROM order_date) FROM orders;
```

---

## 🔹 DATE_ADD vs INTERVAL

### MySQL

```sql
SELECT DATE_ADD(order_date, INTERVAL 7 DAY) FROM orders;
```

### PostgreSQL

```sql
SELECT order_date + INTERVAL '7 days' FROM orders;
```

---

# 4️⃣ AGGREGATE FUNCTIONS

## Sample Table: `marks`

### Before Data

| student | score |
| ------- | ----- |
| A       | 80    |
| B       | 90    |
| C       | 70    |

---

## 🔹 COUNT()

```sql
SELECT COUNT(*) FROM marks;
```

---

## 🔹 SUM()

```sql
SELECT SUM(score) FROM marks;
```

---

## 🔹 AVG(), MIN(), MAX()

```sql
SELECT AVG(score), MIN(score), MAX(score) FROM marks;
```

---

# 5️⃣ CONDITIONAL FUNCTIONS

## 🔹 IF() – MySQL Only

```sql
SELECT IF(score >= 75, 'PASS', 'FAIL') FROM marks;
```

---

## 🔹 CASE – Universal

```sql
SELECT
CASE
  WHEN score >= 75 THEN 'PASS'
  ELSE 'FAIL'
END
FROM marks;
```

---

# 6️⃣ CASE EXPRESSIONS (ASSIGNMENT LOGIC)

```sql
SELECT score,
CASE
  WHEN score >= 90 THEN 'A'
  WHEN score >= 75 THEN 'B'
  ELSE 'C'
END AS grade
FROM marks;
```

---

# 7️⃣ NULL HANDLING FUNCTIONS

## Sample Table: `users`

| id | phone      |
| -- | ---------- |
| 1  | NULL       |
| 2  | 9876543210 |

---

## 🔹 COALESCE()

```sql
SELECT COALESCE(phone, 'NOT AVAILABLE') FROM users;
```

Returns first non-null value

---

## 🔹 NULLIF()

```sql
SELECT NULLIF(10, 10);
```

Returns NULL if values match

---

# 8️⃣ CONVERSION FUNCTIONS

## 🔹 CAST()

```sql
SELECT CAST('2024-01-01' AS DATE);
```

---

## 🔹 TO_CHAR (PostgreSQL)

```sql
SELECT TO_CHAR(order_date, 'YYYY-MM');
```

---

# 9️⃣ WINDOW FUNCTIONS (ADVANCED)

## Sample Table: `sales`

| emp | amount |
| --- | ------ |
| A   | 1000   |
| B   | 2000   |
| C   | 1500   |

---

## 🔹 ROW_NUMBER()

```sql
SELECT emp, amount,
ROW_NUMBER() OVER (ORDER BY amount DESC) AS rank
FROM sales;
```

---

## 🔹 RANK() vs DENSE_RANK()

```sql
SELECT emp, amount,
RANK() OVER (ORDER BY amount DESC),
DENSE_RANK() OVER (ORDER BY amount DESC)
FROM sales;
```

---

## 🔹 SUM() OVER()

```sql
SELECT emp, amount,
SUM(amount) OVER() AS total_sales
FROM sales;
```

---

## 🔹 PARTITION BY

```sql
SELECT emp, dept, amount,
SUM(amount) OVER(PARTITION BY dept)
FROM sales;
```

---

# 🔟 ADVANCED FUNCTIONS

## 🔹 LEAD() / LAG()

```sql
SELECT emp, amount,
LAG(amount) OVER(ORDER BY amount)
FROM sales;
```

---

## 🔹 NTILE()

```sql
SELECT emp, amount,
NTILE(2) OVER(ORDER BY amount)
FROM sales;
```

---

# 📌 MYSQL vs POSTGRESQL SUMMARY

| Feature  | MySQL    | PostgreSQL |   |   |
| -------- | -------- | ---------- | - | - |
| IF()     | ✅        | ❌          |   |   |
| CASE     | ✅        | ✅          |   |   |
| CONCAT   | CONCAT() |            |   |   |
| DATE_ADD | DATE_ADD | + INTERVAL |   |   |
| TO_CHAR  | ❌        | ✅          |   |   |

---

# ✅ FINAL NOTES

✔ All examples are **production-style**
✔ Covers **basic → advanced**
✔ Perfect for **interviews & real projects**
✔ Fully **copy-paste ready README**

---

🎯 **You now have one of the most complete SQL Functions references for MySQL & PostgreSQL.**
