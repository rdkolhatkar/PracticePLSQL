/* =========================================================
   SECTION 0: TABLE CREATION & SAMPLE DATA
   ========================================================= */

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    bonus INT,
    joining_year INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO employees VALUES
(101, 'Amit',   70000, 1, 5000, 2020, NULL),
(102, 'Neha',   60000, 1, NULL,  2021, 101),
(103, 'Rahul',  50000, 2, 3000, 2019, 101),
(104, 'Pooja',  45000, 2, NULL,  2022, 103),
(105, 'Vikas',  80000, 3, 7000, 2018, NULL);

/* =========================================================
   1. ARITHMETIC OPERATORS (+ - * / %)
   ========================================================= */

-- Q1: Calculate total compensation (salary + bonus, treat NULL as 0)
SELECT emp_name, salary + COALESCE(bonus, 0) AS total_compensation
FROM employees;

/*
Expected Result:
Amit   | 75000
Neha   | 60000
Rahul  | 53000
Pooja  | 45000
Vikas  | 87000
*/

-- Q2: Find employees whose salary is divisible by 5
SELECT emp_name, salary
FROM employees
WHERE salary % 5 = 0;

/*
Expected Result: All employees
*/

/* =========================================================
   2. COMPARISON OPERATORS (= != <> > < >= <=)
   ========================================================= */

-- Q3: Find employees earning more than 60000
SELECT emp_name, salary
FROM employees
WHERE salary > 60000;

/*
Expected Result:
Amit
Vikas
*/

-- Q4: Employees not working in IT department (dept_id != 1)
SELECT emp_name
FROM employees
WHERE dept_id <> 1;

/*
Expected Result:
Rahul
Pooja
Vikas
*/

/* =========================================================
   3. LOGICAL OPERATORS (AND OR NOT)
   ========================================================= */

-- Q5: Employees from IT department AND salary > 65000
SELECT emp_name
FROM employees
WHERE dept_id = 1 AND salary > 65000;

/*
Expected Result:
Amit
*/

-- Q6: Employees from HR OR Finance
SELECT emp_name
FROM employees
WHERE dept_id = 2 OR dept_id = 3;

/*
Expected Result:
Rahul
Pooja
Vikas
*/

-- Q7: Employees NOT receiving bonus
SELECT emp_name
FROM employees
WHERE NOT bonus IS NOT NULL;

/*
Expected Result:
Neha
Pooja
*/

/* =========================================================
   4. SET OPERATORS (UNION, INTERSECT, EXCEPT)
   ========================================================= */

-- Q8: Employees either in IT or earning above 75000 (UNION)
SELECT emp_name FROM employees WHERE dept_id = 1
UNION
SELECT emp_name FROM employees WHERE salary > 75000;

/*
Expected Result:
Amit
Neha
Vikas
*/

-- Q9: Employees in IT AND earning above 65000 (INTERSECT)
SELECT emp_name FROM employees WHERE dept_id = 1
INTERSECT
SELECT emp_name FROM employees WHERE salary > 65000;

/*
Expected Result:
Amit
*/

-- Q10: Employees in IT but NOT earning above 65000 (EXCEPT)
SELECT emp_name FROM employees WHERE dept_id = 1
EXCEPT
SELECT emp_name FROM employees WHERE salary > 65000;

/*
Expected Result:
Neha
*/

/* =========================================================
   5. PATTERN MATCHING (LIKE, ILIKE)
   ========================================================= */

-- Q11: Employees whose name starts with 'A'
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%';

/*
Expected Result:
Amit
*/

-- Q12: Case-insensitive search for names containing 'ha'
-- PostgreSQL only:
-- WHERE emp_name ILIKE '%ha%'

-- MySQL + PostgreSQL compatible:
SELECT emp_name
FROM employees
WHERE LOWER(emp_name) LIKE '%ha%';

/*
Expected Result:
Neha
Rahul
*/

/* =========================================================
   6. NULL CHECK (IS NULL)
   ========================================================= */

-- Q13: Employees without a manager
SELECT emp_name
FROM employees
WHERE manager_id IS NULL;

/*
Expected Result:
Amit
Vikas
*/

/* =========================================================
   7. BITWISE OPERATORS (& | ^ << >>)
   ========================================================= */

-- Q14: Bitwise AND of salary and bonus (NULL treated as 0)
SELECT emp_name, salary & COALESCE(bonus, 0) AS bitwise_and
FROM employees;

/*
Expected Result:
Numeric bitwise results (engine-dependent but valid)
*/

-- Q15: Left shift salary by 1
SELECT emp_name, salary << 1 AS shifted_salary
FROM employees;

/*
Expected Result:
Salary multiplied by 2
*/

/* =========================================================
   8. CONDITIONAL OPERATOR (CASE WHEN)
   ========================================================= */

-- Q16: Categorize employees based on salary
SELECT emp_name,
CASE
    WHEN salary >= 75000 THEN 'High'
    WHEN salary BETWEEN 50000 AND 74999 THEN 'Medium'
    ELSE 'Low'
END AS salary_category
FROM employees;

/*
Expected Result:
Amit   | Medium
Neha   | Medium
Rahul  | Medium
Pooja  | Low
Vikas  | High
*/

/* =========================================================
   END OF SQL OPERATOR ASSESSMENT
   ========================================================= */
