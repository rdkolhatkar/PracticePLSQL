# 📘 SQL Operators – Complete Practical Guide (MySQL & PostgreSQL)

This README explains **each and every SQL operator** with:

* ✔️ Clear definitions
* ✔️ Practical queries
* ✔️ **Before & After table states**
* ✔️ Query **execution results**
* ✔️ **MySQL vs PostgreSQL syntax differences**
* ✔️ Flow explanation & cheat sheets

---

## 📌 Sample Table Used in All Examples

### `employees` (Before Any Query)

| emp_id | name  | age | salary | dept  | active |
| -----: | ----- | --: | -----: | ----- | ------ |
|      1 | Ravi  |  28 |  50000 | IT    | true   |
|      2 | Anu   |  35 |  70000 | HR    | true   |
|      3 | John  |  40 |  90000 | IT    | false  |
|      4 | Meera |  25 |  45000 | SALES | true   |
|      5 | Sam   |  30 |  60000 | HR    | false  |

---

## 🔢 1. Arithmetic Operators

| Operator | Meaning        |
| -------- | -------------- |
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `%`      | Modulus        |

### Example: Salary Increment (10%)

#### MySQL

```sql
SELECT emp_id, salary, salary + (salary * 0.10) AS updated_salary
FROM employees;
```

#### PostgreSQL

```sql
SELECT emp_id, salary, salary + (salary * 0.10) AS updated_salary
FROM employees;
```

### Result

| emp_id | salary | updated_salary |
| -----: | -----: | -------------: |
|      1 |  50000 |          55000 |
|      2 |  70000 |          77000 |
|      3 |  90000 |          99000 |

📌 **Difference:**

* `/` in **PostgreSQL** returns decimal by default
* `/` in **MySQL** may return integer if both operands are integers

---

## ⚖️ 2. Comparison (Relational) Operators

| Operator    | Meaning          |
| ----------- | ---------------- |
| `=`         | Equal            |
| `!=` / `<>` | Not Equal        |
| `>`         | Greater Than     |
| `<`         | Less Than        |
| `>=`        | Greater or Equal |
| `<=`        | Less or Equal    |

### Example: Employees with Salary > 60000

```sql
SELECT * FROM employees
WHERE salary > 60000;
```

### Result

| emp_id | name | salary |
| -----: | ---- | -----: |
|      2 | Anu  |  70000 |
|      3 | John |  90000 |

✔️ Same in **MySQL & PostgreSQL**

---

## 🔍 3. Logical Operators

| Operator | Meaning   |
| -------- | --------- |
| `AND`    | Both true |
| `OR`     | Any true  |
| `NOT`    | Negation  |

### Example: Active IT Employees

```sql
SELECT * FROM employees
WHERE dept = 'IT' AND active = true;
```

### Result

| emp_id | name | dept | active |
| -----: | ---- | ---- | ------ |
|      1 | Ravi | IT   | true   |

---

## 📚 4. BETWEEN Operator

```sql
SELECT name, salary
FROM employees
WHERE salary BETWEEN 50000 AND 80000;
```

### Result

| name | salary |
| ---- | -----: |
| Ravi |  50000 |
| Anu  |  70000 |
| Sam  |  60000 |

✔️ Inclusive range
✔️ Same in MySQL & PostgreSQL

---

## 🧾 5. IN Operator

```sql
SELECT name, dept
FROM employees
WHERE dept IN ('HR', 'IT');
```

### Result

| name | dept |
| ---- | ---- |
| Ravi | IT   |
| Anu  | HR   |
| John | IT   |
| Sam  | HR   |

---

## 🔎 6. LIKE Operator (Pattern Matching)

| Pattern | Meaning          |
| ------- | ---------------- |
| `%`     | Any characters   |
| `_`     | Single character |

### Names starting with ‘A’

```sql
SELECT name FROM employees
WHERE name LIKE 'A%';
```

### Result

| name |
| ---- |
| Anu  |

📌 PostgreSQL is **case-sensitive** unless `ILIKE` is used

```sql
-- PostgreSQL only
SELECT name FROM employees
WHERE name ILIKE 'a%';
```

---

## ❓ 7. IS NULL / IS NOT NULL

```sql
SELECT * FROM employees
WHERE salary IS NOT NULL;
```

✔️ `= NULL` ❌ **Always wrong**

---

## 🧮 8. Bitwise Operators

| Operator | Meaning     |    |
| -------- | ----------- | -- |
| `&`      | AND         |    |
| `        | `           | OR |
| `^`      | XOR         |    |
| `<<`     | Left Shift  |    |
| `>>`     | Right Shift |    |

```sql
SELECT 5 & 3;
```

Result: `1`

✔️ Supported by both databases

---

## 🔄 9. Assignment Operators (UPDATE)

### Before Update

| emp_id | salary |
| -----: | -----: |
|      4 |  45000 |

### Query

```sql
UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 4;
```

### After Update

| emp_id | salary |
| -----: | -----: |
|      4 |  50000 |

---

## 📊 10. Set Operators

| Operator    | MySQL | PostgreSQL |
| ----------- | ----- | ---------- |
| `UNION`     | ✅     | ✅          |
| `UNION ALL` | ✅     | ✅          |
| `INTERSECT` | ❌     | ✅          |
| `EXCEPT`    | ❌     | ✅          |

### PostgreSQL Only

```sql
SELECT dept FROM employees
INTERSECT
SELECT dept FROM departments;
```

---

## 🔢 11. Aggregate Operators

| Function  | Meaning   |
| --------- | --------- |
| `COUNT()` | Row count |
| `SUM()`   | Total     |
| `AVG()`   | Average   |
| `MIN()`   | Minimum   |
| `MAX()`   | Maximum   |

```sql
SELECT dept, AVG(salary)
FROM employees
GROUP BY dept;
```

---

## 🧠 12. Conditional Operator (CASE)

```sql
SELECT name,
CASE
  WHEN salary > 80000 THEN 'HIGH'
  WHEN salary BETWEEN 50000 AND 80000 THEN 'MEDIUM'
  ELSE 'LOW'
END AS salary_band
FROM employees;
```

---

# ➕ NEWLY ADDED OPERATORS (WITHOUT CHANGING ABOVE CONTENT)

---

## ❗ 13. ISNULL / COALESCE Operator

### Purpose

Used to replace `NULL` values with a default value.

### Syntax Difference

| Database   | Function Used |
| ---------- | ------------- |
| MySQL      | `IFNULL()`    |
| PostgreSQL | `COALESCE()`  |

### Before

| emp_id | name | salary |
| -----: | ---- | -----: |
|      6 | Alex |   NULL |

### MySQL

```sql
SELECT name, IFNULL(salary, 0) AS salary
FROM employees;
```

### PostgreSQL

```sql
SELECT name, COALESCE(salary, 0) AS salary
FROM employees;
```

### Result

| name | salary |
| ---- | -----: |
| Alex |      0 |

---

## 🔃 14. ORDER BY Operator

### Purpose

Sorts result set in **ascending (ASC)** or **descending (DESC)** order.

### Syntax (Same for MySQL & PostgreSQL)

```sql
SELECT name, salary
FROM employees
ORDER BY salary DESC;
```

### Result

| name  | salary |
| ----- | -----: |
| John  |  90000 |
| Anu   |  70000 |
| Sam   |  60000 |
| Ravi  |  50000 |
| Meera |  45000 |

📌 Default order is **ASC**

---

## 🔢 15. LIMIT Operator

### Purpose

Restricts number of rows returned.

### Syntax Difference

| Database   | Syntax  |
| ---------- | ------- |
| MySQL      | `LIMIT` |
| PostgreSQL | `LIMIT` |

### Example: Top 2 Highest Paid Employees

```sql
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 2;
```

### Result

| name | salary |
| ---- | -----: |
| John |  90000 |
| Anu  |  70000 |

📌 PostgreSQL also supports `OFFSET`

```sql
SELECT * FROM employees LIMIT 2 OFFSET 1;
```

---

## 🎯 16. DISTINCT Operator

### Purpose

Removes **duplicate values** from result set.

### Before

| dept  |
| ----- |
| IT    |
| HR    |
| IT    |
| SALES |
| HR    |

### Query

```sql
SELECT DISTINCT dept
FROM employees;
```

### Result

| dept  |
| ----- |
| IT    |
| HR    |
| SALES |

✔️ Same in MySQL & PostgreSQL

---

## 🔄 SQL Execution Flow (Conceptual)

```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

---

## 📌 MySQL vs PostgreSQL – Key Differences

| Feature          | MySQL            | PostgreSQL      |
| ---------------- | ---------------- | --------------- |
| Case Sensitivity | ❌                | ✅               |
| ILIKE            | ❌                | ✅               |
| INTERSECT        | ❌                | ✅               |
| EXCEPT           | ❌                | ✅               |
| Division         | Integer possible | Decimal default |
| NULL Handling    | IFNULL()         | COALESCE()      |

---

## 🧾 SQL Operators – Cheat Sheet

| Category    | Operators / Keywords         |
| ----------- | ---------------------------- |
| Arithmetic  | `+ - * / %`                  |
| Comparison  | `= != <> > < >= <=`          |
| Logical     | `AND OR NOT`                 |
| Pattern     | `LIKE ILIKE`                 |
| Null        | `IS NULL IS NOT NULL IFNULL` |
| Sorting     | `ORDER BY`                   |
| Limiting    | `LIMIT OFFSET`               |
| Set         | `UNION INTERSECT EXCEPT`     |
| Conditional | `CASE WHEN`                  |
| Distinct    | `DISTINCT`                   |

---

## ✅ Final Notes

* All queries shown are **production-valid**
* Use **PostgreSQL** for advanced set operations
* Prefer **explicit operators** over shortcuts
* Always verify **data types** before arithmetic operations

---
