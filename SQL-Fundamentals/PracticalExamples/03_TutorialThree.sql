-- MySQL example of creating table inside database/schema:
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2)
);
-- PosgreSQL example of creating table inside schema:
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary NUMERIC(10,2)
);
-- MySQL example of Inserting data into table inside database/schema:
INSERT INTO employees (employee_name, position, department, hire_date, salary) VALUES
('John Doe', 'Software Engineer', 'IT', '2022-01-15', 65000.00),
('Priya Sharma', 'QA Analyst', 'Quality Assurance', '2021-03-10', 52000.00),
('Michael Brown', 'Project Manager', 'Management', '2020-11-01', 85000.00),
('Anita Desai', 'HR Executive', 'Human Resources', '2023-06-18', 45000.00),
('Rakesh Kumar', 'Data Analyst', 'Analytics', '2022-09-25', 60000.00);
-- PosgreSQL example of Inserting data into table inside schema:
INSERT INTO employees (employee_name, position, department, hire_date, salary) VALUES
('John Doe', 'Software Engineer', 'IT', '2022-01-15', 65000.00),
('Priya Sharma', 'QA Analyst', 'Quality Assurance', '2021-03-10', 52000.00),
('Michael Brown', 'Project Manager', 'Management', '2020-11-01', 85000.00),
('Anita Desai', 'HR Executive', 'Human Resources', '2023-06-18', 45000.00),
('Rakesh Kumar', 'Data Analyst', 'Analytics', '2022-09-25', 60000.00);

-- MySQL example of deleting data from table inside database/schema:
DELETE FROM employees WHERE employee_id = 3;
-- PosgreSQL example of deleting data from table inside schema: 
DELETE FROM employees WHERE employee_id = 3;
-- MySQL example of updating data in table inside database/schema:
UPDATE employees SET salary = 70000.00 WHERE employee_id = 1;
-- PosgreSQL example of updating data in table inside schema:
UPDATE employees SET salary = 70000.00 WHERE employee_id = 1;

--MySQL example of deleting a specific column from table inside database/schema:
ALTER TABLE employees DROP COLUMN department;
--PosgreSQL example of deleting a specific column from table inside schema:
ALTER TABLE employees DROP COLUMN department;

--MySQL example of deleting the entire table from database/schema:
DROP TABLE employees;
--PosgreSQL example of deleting the entire table from schema:
DROP TABLE employees;

