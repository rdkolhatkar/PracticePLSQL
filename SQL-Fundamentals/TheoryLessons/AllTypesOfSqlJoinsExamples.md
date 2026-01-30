# 📘 SQL JOINS – COMPLETE GUIDE (MySQL & PostgreSQL)

> **Audience**: Freshers → Advanced SQL users
> **Databases Covered**: **MySQL** & **PostgreSQL**
> **Goal**: Learn **ALL kinds of SQL JOINs** from **basic to advanced**, with **clear explanations**, **before & after table data**, **ASCII diagrams**, and **syntax differences** between MySQL and PostgreSQL.

---

## 📌 WHAT IS A JOIN IN SQL?

A **JOIN** is used to **combine rows from two or more tables** based on a **related column** between them.

### Why JOINs are Important?

* Data is normalized across tables
* JOINs allow meaningful data retrieval
* Core concept for real-world SQL queries
* Extremely important for **interviews** & **projects**

---

## 📂 TYPES OF SQL JOINS

1. INNER JOIN
2. LEFT JOIN (LEFT OUTER JOIN)
3. RIGHT JOIN (RIGHT OUTER JOIN)
4. FULL JOIN (FULL OUTER JOIN)
5. CROSS JOIN
6. SELF JOIN
7. NATURAL JOIN
8. USING Clause (Variation)
9. NON-EQUI JOIN
10. SEMI JOIN (Conceptual)
11. ANTI JOIN (Conceptual)

---

## 🧱 SAMPLE TABLES USED THROUGHOUT

### `employees` (Before Data)

| emp_id | emp_name | dept_id | manager_id |
| ------ | -------- | ------- | ---------- |
| 1      | John     | 10      | NULL       |
| 2      | Alice    | 20      | 1          |
| 3      | Bob      | 10      | 1          |
| 4      | Carol    | 30      | 2          |
| 5      | David    | NULL    | 2          |

### `departments` (Before Data)

| dept_id | dept_name |
| ------- | --------- |
| 10      | IT        |
| 20      | HR        |
| 40      | Finance   |

---

# 1️⃣ INNER JOIN

## 🔹 What is INNER JOIN?

Returns **only matching rows** from both tables.

### Diagram

```
Employees      Departments
   ●───────●   (Matching only)
```

### Syntax (Same in MySQL & PostgreSQL)

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;
```

### Result

| emp_name | dept_name |
| -------- | --------- |
| John     | IT        |
| Bob      | IT        |
| Alice    | HR        |

### Explanation

* Rows without matching `dept_id` are excluded
* Most commonly used JOIN

---

# 2️⃣ LEFT JOIN (LEFT OUTER JOIN)

## 🔹 What is LEFT JOIN?

Returns **all rows from LEFT table** and matching rows from RIGHT table.

### Diagram

```
Employees ●───────● Departments
Employees ●───────○ (NULL if no match)
```

### Syntax

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
```

### Result

| emp_name | dept_name |
| -------- | --------- |
| John     | IT        |
| Alice    | HR        |
| Bob      | IT        |
| Carol    | NULL      |
| David    | NULL      |

### Explanation

* Keeps all employees
* Missing department → NULL

---

# 3️⃣ RIGHT JOIN (RIGHT OUTER JOIN)

## 🔹 What is RIGHT JOIN?

Returns **all rows from RIGHT table** and matching rows from LEFT table.

### Diagram

```
Employees ○───────● Departments
(NULLs)  ●───────●
```

### Syntax

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;
```

### Result

| emp_name | dept_name |
| -------- | --------- |
| John     | IT        |
| Bob      | IT        |
| Alice    | HR        |
| NULL     | Finance   |

### Note

* **PostgreSQL supports RIGHT JOIN**
* Often replaced using LEFT JOIN by swapping tables

---

# 4️⃣ FULL JOIN (FULL OUTER JOIN)

## 🔹 What is FULL JOIN?

Returns **all rows from both tables**.

### Diagram

```
Employees ●───────● Departments
Employees ●───────○
Employees ○───────●
```

### PostgreSQL (Supported)

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
FULL JOIN departments d
ON e.dept_id = d.dept_id;
```

### MySQL (Not Supported Directly)

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;
```

### Result

| emp_name | dept_name |
| -------- | --------- |
| John     | IT        |
| Bob      | IT        |
| Alice    | HR        |
| Carol    | NULL      |
| David    | NULL      |
| NULL     | Finance   |

---

# 5️⃣ CROSS JOIN

## 🔹 What is CROSS JOIN?

Returns **Cartesian product** (all combinations).

### Diagram

```
Employees ●●●
Departments ●●
Result = 3 x 2 rows
```

### Syntax

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
CROSS JOIN departments d;
```

### Result

If 5 employees & 3 departments → 15 rows

### Use Case

* Generating combinations
* Rare in real projects

---

# 6️⃣ SELF JOIN

## 🔹 What is SELF JOIN?

A table joined with **itself**.

### Use Case

Employee → Manager relationship

### Syntax

```sql
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;
```

### Result

| employee | manager |
| -------- | ------- |
| Alice    | John    |
| Bob      | John    |
| Carol    | Alice   |
| David    | Alice   |

---

# 7️⃣ NATURAL JOIN

## 🔹 What is NATURAL JOIN?

Automatically joins tables using **same column names**.

### Syntax

```sql
SELECT emp_name, dept_name
FROM employees
NATURAL JOIN departments;
```

### ⚠ Warning

* Dangerous in production
* Column dependency implicit

---

# 8️⃣ USING CLAUSE (JOIN VARIATION)

## 🔹 Cleaner syntax when column names are same

```sql
SELECT emp_name, dept_name
FROM employees
JOIN departments USING (dept_id);
```

### Advantage

* Avoids table aliases in ON condition

---

# 9️⃣ NON-EQUI JOIN

## 🔹 What is NON-EQUI JOIN?

Uses operators other than `=`.

### Example

`salary_grade`
| grade | min | max |

```sql
SELECT e.emp_name, g.grade
FROM employees e
JOIN salary_grade g
ON e.salary BETWEEN g.min AND g.max;
```

---

# 🔟 SEMI JOIN (Concept)

## 🔹 What is SEMI JOIN?

Returns rows from **first table only**, where match exists.

### Using EXISTS

```sql
SELECT * FROM employees e
WHERE EXISTS (
  SELECT 1 FROM departments d
  WHERE e.dept_id = d.dept_id
);
```

---

# 1️⃣1️⃣ ANTI JOIN (Concept)

## 🔹 What is ANTI JOIN?

Returns rows where **NO match exists**.

### Using NOT EXISTS

```sql
SELECT * FROM employees e
WHERE NOT EXISTS (
  SELECT 1 FROM departments d
  WHERE e.dept_id = d.dept_id
);
```

### Result

Employees without departments

---

# 📊 MYSQL vs POSTGRESQL – JOIN DIFFERENCES

| Feature              | MySQL          | PostgreSQL |
| -------------------- | -------------- | ---------- |
| INNER / LEFT / RIGHT | ✅              | ✅          |
| FULL JOIN            | ❌ (workaround) | ✅          |
| NATURAL JOIN         | ✅              | ✅          |
| USING clause         | ✅              | ✅          |
| RIGHT JOIN usage     | Less common    | Supported  |

---

# ✅ FINAL SUMMARY

✔ Explained **ALL JOIN types** from basic → advanced
✔ Includes **before & after data**
✔ **ASCII diagrams** for easy understanding
✔ Covers **MySQL & PostgreSQL differences**
✔ **100% README – copy paste ready**

---

🎯 **Mastering JOINs means mastering SQL.**
