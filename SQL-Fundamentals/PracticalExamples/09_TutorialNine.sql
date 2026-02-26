CREATE DATABASE storage_db;
-- OUTPUT:
-- Database 'storage_db' gets created (if it does not already exist).
-- WHY?
-- This command creates a new database schema to store tables.

USE storage_db;
-- OUTPUT:
-- Database changed to 'storage_db'.
-- WHY?
-- All further tables and data will be created inside this database.



CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);
-- OUTPUT:
-- Table 'products' created successfully.
-- WHY?
-- AUTO_INCREMENT automatically generates product_id values.
-- DECIMAL(10,2) stores numbers with 2 digits after decimal.



INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop Pro', 'Electronics', 75000.00, 10),
('Wireless Mouse', 'Electronics', 1200.50, 50),
('Office Chair', 'Furniture', 8500.00, 15),
('Water Bottle', 'Kitchen', 350.75, 100),
('Gaming Keyboard', 'Electronics', 4500.00, 25),
('LED TV 42 Inch', 'Electronics', 32000.00, 5),
('Study Table', 'Furniture', 12000.00, 8),
('Mixer Grinder', 'Kitchen', 5500.00, 20),
('Notebook Pack', 'Stationery', 250.00, 200),
('Smart Watch', NULL, 15000.00, 0);
-- OUTPUT:
-- 10 rows inserted successfully.
-- WHY?
-- Data is inserted row by row into the products table.



-- Find the Products with price of exactly 12000
SELECT * FROM products WHERE price = 12000;
-- OUTPUT:
-- Study Table | Furniture | 12000.00 | 8
-- WHY?
-- Only one product has price exactly equal to 12000.



-- Get all products that are not priced at 8500
SELECT * FROM products WHERE price != 8500;
-- OUTPUT:
-- Returns all products EXCEPT 'Office Chair'
-- WHY?
-- '!=' means not equal.
-- Office Chair price = 8500, so it is excluded.



SELECT * FROM products WHERE price <> 12000;
-- OUTPUT:
-- Returns all products EXCEPT 'Study Table'
-- WHY?
-- '<>' also means NOT EQUAL (standard SQL operator).



-- Get all products whose price is below 50000
SELECT * FROM products WHERE price < 50000;
-- OUTPUT:
-- Returns all products except 'Laptop Pro'
-- WHY?
-- Laptop Pro price = 75000 (greater than 50000)
-- All others are below 50000.



-- Get all products whose price is above 50000
SELECT * FROM products WHERE price > 50000;
-- OUTPUT:
-- Laptop Pro
-- WHY?
-- Only Laptop Pro has price greater than 50000.



/*
Important Note: Even though our DataType of 'price' field is decimal and in our SQL query we are passing the DataType as Number / Integral
SQL will automatically convert the DataType of the data Written in SQL query Implicitely
*/



-- Get all products priced at or above 4000
SELECT * FROM products WHERE price >= 4000;
-- OUTPUT:
-- Laptop Pro
-- Office Chair
-- Gaming Keyboard
-- LED TV 42 Inch
-- Study Table
-- Mixer Grinder
-- Smart Watch
-- WHY?
-- All products whose price is 4000 or more.



-- Get all products priced at or below 4000
SELECT * FROM products WHERE price <= 4000;
-- OUTPUT:
-- Wireless Mouse
-- Water Bottle
-- Notebook Pack
-- WHY?
-- These products have price 4000 or less.



-- Get All Products where category is Exactly Electronics
SELECT * FROM products WHERE category = 'Electronics';
-- OUTPUT:
-- Laptop Pro
-- Wireless Mouse
-- Gaming Keyboard
-- LED TV 42 Inch
-- WHY?
-- Only rows where category column exactly matches 'Electronics'.
-- Comparison depends on collation (usually case-insensitive in MySQL).



-- Creating New Table called Orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(50)
);
-- OUTPUT:
-- Table 'orders' created successfully.
-- WHY?
-- order_id auto increments.
-- order_date stores only date (YYYY-MM-DD).



INSERT INTO orders (order_date, customer_name) VALUES
('2026-01-05', 'Amit Sharma'),
('2026-01-10', 'Priya Verma'),
('2026-01-15', 'Rahul Patil'),
('2026-01-20', 'Sneha Joshi'),
('2026-01-25', 'Vikram Singh'),
('2026-02-01', 'Neha Kulkarni'),
('2026-02-05', 'Arjun Mehta'),
('2026-02-10', 'Pooja Deshmukh'),
('2026-02-15', 'Karan Malhotra'),
('2026-02-20', 'Anjali Gupta');
-- OUTPUT:
-- 10 rows inserted successfully into orders table.



-- Find orders which are placed before 10 FEB 2026
SELECT * FROM orders WHERE order_date < '2026-02-10';
-- OUTPUT:
-- Amit Sharma (2026-01-05)
-- Priya Verma (2026-01-10)
-- Rahul Patil (2026-01-15)
-- Sneha Joshi (2026-01-20)
-- Vikram Singh (2026-01-25)
-- Neha Kulkarni (2026-02-01)
-- Arjun Mehta (2026-02-05)
--
-- WHY?
-- Date comparison works chronologically.
-- '2026-02-10' is excluded because condition is strictly less than (<).
/*
If we use the Comparison operators on String then it will be compared Lexicographically. 
Lexicographically means arranging words in dictionary order (alphabetical order) based on their characters.
It compares strings character by character from left to right using their ASCII/Unicode values.
*/

SELECT * FROM products WHERE product_name > 'Water Bottle'; 
-- By default above query is case Insensitive because we are using comparison operators on a String
-- OUTPUT:
-- It will return all rows where product_name comes AFTER 'Water Bottle'
-- in dictionary (alphabetical) order.
-- Example (based on previously inserted data):
-- Wireless Mouse
-- (Any other product_name alphabetically greater than 'Water Bottle')
--
-- WHY?
-- Because string comparison is lexicographical.
-- It compares character by character:
-- 'W' = 'W'
-- Then next letters are compared until difference is found.
-- Any word that comes alphabetically after 'Water Bottle' is returned.
-- Case sensitivity depends on database collation (MySQL default is case-insensitive).



-- Comparison between Strings
SELECT '100' < '2';
-- OUTPUT: 1
-- WHY?
-- Because this is STRING comparison (lexicographical).
-- Compare character by character:
-- '1' < '2'
-- So MySQL returns TRUE (1).
-- It does NOT compare 100 and 2 numerically here.



SELECT '100' < '212';
-- OUTPUT: 1
-- WHY?
-- Compare first characters:
-- '1' < '2'
-- So result is TRUE (1).
-- Again, lexicographical comparison, not numeric.



SELECT '100' < '102';
-- OUTPUT: 1
-- WHY?
-- Compare character by character:
-- '1' = '1'
-- '0' = '0'
-- '0' < '2'
-- Therefore TRUE (1).
-- This behaves like dictionary comparison.



-- To treat it as number we use the below expression
SELECT '100' + 0 < '2' + 0;
-- OUTPUT: 0
-- WHY?
-- '100' + 0 converts string to number 100
-- '2' + 0 converts string to number 2
-- Now numeric comparison:
-- 100 < 2 → FALSE
-- So result is 0.



-- Comparison between String and number 
SELECT 100 < '21abcdefgh';
-- OUTPUT: 0
-- WHY?
-- When comparing number with string,
-- MySQL converts the string to a number.
--
-- '21abcdefgh' becomes 21
-- (Conversion stops when non-numeric characters start)
--
-- So comparison becomes:
-- 100 < 21
-- Which is FALSE (0).
