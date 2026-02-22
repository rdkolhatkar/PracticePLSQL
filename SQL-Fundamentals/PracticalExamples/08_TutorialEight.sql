CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2), 
    published_date DATE,
    category VARCHAR(100),
    in_stock INT
);

INSERT INTO books (book_id, title, author, price, published_date, category, in_stock) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 10.99, '1925-04-10', 'Classic', 5),
(2, 'To Kill a Mockingbird', 'Harper Lee', 7.99, '1960-07-11', 'Classic', 3),
(3, '1984', 'George Orwell', 8.99, '1949-06-08', 'Dystopian', 4),
(4, 'The Catcher in the Rye', 'J.D. Salinger', 6.99, '1951-07-16', 'Classic', 2),
(5, 'The Hobbit', 'J.R.R. Tolkien', 12.99, '1937-09-21', 'Fantasy', 6);

/*
================ ORIGINAL FULL TABLE =================

+---------+----------------------------+-----------------------+-------+---------------+-----------+----------+
| book_id | title                      | author                | price | published_date| category  | in_stock |
+---------+----------------------------+-----------------------+-------+---------------+-----------+----------+
| 1       | The Great Gatsby           | F. Scott Fitzgerald   | 10.99 | 1925-04-10    | Classic   | 5        |
| 2       | To Kill a Mockingbird      | Harper Lee            | 7.99  | 1960-07-11    | Classic   | 3        |
| 3       | 1984                       | George Orwell         | 8.99  | 1949-06-08    | Dystopian | 4        |
| 4       | The Catcher in the Rye     | J.D. Salinger         | 6.99  | 1951-07-16    | Classic   | 2        |
| 5       | The Hobbit                 | J.R.R. Tolkien        | 12.99 | 1937-09-21    | Fantasy   | 6        |
+---------+----------------------------+-----------------------+-------+---------------+-----------+----------+

=======================================================
*/

SELECT * FROM books;

/*
Output:
(Same as Original Full Table Above)
*/

SELECT title, author FROM books WHERE price < 10.00;

/*
Output:
+----------------------------+------------------+
| title                      | author           |
+----------------------------+------------------+
| To Kill a Mockingbird      | Harper Lee       |
| 1984                       | George Orwell    |
| The Catcher in the Rye     | J.D. Salinger    |
+----------------------------+------------------+
*/

-- Date comparison example
SELECT title, published_date FROM books WHERE published_date < '1950-01-01';

/*
Output:
+-------------------+---------------+
| title             | published_date|
+-------------------+---------------+
| The Great Gatsby  | 1925-04-10    |
| 1984              | 1949-06-08    |
| The Hobbit        | 1937-09-21    |
+-------------------+---------------+
*/

-- LIKE operator example
SELECT title, author FROM books WHERE title LIKE '%the%';

/*
Output (MySQL default case-insensitive):
+----------------------------+-----------------------+
| title                      | author                |
+----------------------------+-----------------------+
| The Great Gatsby           | F. Scott Fitzgerald   |
| The Catcher in the Rye     | J.D. Salinger         |
| The Hobbit                 | J.R.R. Tolkien        |
+----------------------------+-----------------------+
*/

-- OR operator example
SELECT title, author FROM books WHERE category = 'Classic' OR category = 'Fantasy';

/*
Output:
The Great Gatsby
To Kill a Mockingbird
The Catcher in the Rye
The Hobbit
*/

-- NOT operator example
SELECT title, author FROM books WHERE NOT category = 'Dystopian';

/*
Output:
All except 1984
*/

-- IN operator example
SELECT title, author FROM books WHERE category IN ('Classic', 'Fantasy');

/*
Output:
The Great Gatsby
To Kill a Mockingbird
The Catcher in the Rye
The Hobbit
*/

-- AND operator example
SELECT title, price FROM books WHERE category = 'Classic' AND in_stock > 2;

/*
Output:
+-------------------------+-------+
| title                   | price |
+-------------------------+-------+
| The Great Gatsby        | 10.99 |
| To Kill a Mockingbird   | 7.99  |
+-------------------------+-------+
*/

-- BETWEEN operator example
SELECT title, price FROM books WHERE price BETWEEN 7.00 AND 10.00;

/*
Output:
To Kill a Mockingbird
1984
*/

-- IS NULL operator example
SELECT title, author FROM books WHERE published_date IS NULL;

/*
Output:
Empty set (0 rows)
*/

-- IS NOT NULL operator example
SELECT title, author FROM books WHERE published_date IS NOT NULL;

/*
Output:
All 5 books
*/

-- Combining multiple operators
-- Combining OR, AND, and date comparison
SELECT title, author FROM books 
WHERE (category = 'Classic' OR category = 'Fantasy')    
AND price < 10.00
AND published_date < '1950-01-01';

/*
Output:
No rows
*/

-- Combining NOT, IN, and date comparison
SELECT title, author FROM books 
WHERE NOT category IN ('Dystopian', 'Fantasy')
AND published_date < '1950-01-01';

/*
Output:
The Great Gatsby
*/

-- Finding null values with IS NULL and IS NOT NULL
SELECT title, author FROM books WHERE published_date IS NULL;

/*
Output:
Empty set (0 rows)
*/

-- != operator example
SELECT title, author FROM books WHERE category != 'Dystopian';

/*
Output:
All except 1984
*/

-- <> operator example
SELECT title, author FROM books WHERE category <> 'Dystopian';

/*
Output:
All except 1984
*/

-- Pattern matching
SELECT title, author FROM books WHERE title LIKE 'The%'; 

/*
Output:
The Great Gatsby
The Catcher in the Rye
The Hobbit
*/

SELECT title, author FROM books WHERE title LIKE '%the'; 

/*
Output:
No rows
*/

SELECT title, author FROM books WHERE title LIKE '%the%'; 

/*
Output:
The Great Gatsby
The Catcher in the Rye
The Hobbit
*/

SELECT title, author FROM books WHERE title LIKE '_he%'; 

/*
Output:
The Great Gatsby
The Catcher in the Rye
The Hobbit
*/

SELECT title, author FROM books WHERE title LIKE 'T%h%'; 

/*
Output:
The Great Gatsby
The Catcher in the Rye
The Hobbit
*/

-- case sensitivity in pattern matching
SELECT title, author FROM books WHERE title LIKE 'the%'; 

/*
Output (MySQL default collation):
The Great Gatsby
The Catcher in the Rye
The Hobbit
*/

SELECT title, author FROM books WHERE title ILIKE 'the%'; 

/*
Output:
ERROR (Not supported in MySQL)
*/

SELECT title, author FROM books WHERE title LIKE BINARY '%SQL%'; 

/*
Output:
Empty set (0 rows)
*/

-- Price between a range and date comparison
SELECT title, price FROM books WHERE price BETWEEN 5.00 AND 10.00 AND published_date < '1950-01-01';

/*
Output:
1984
*/

-- Price is greater than average price
SELECT title, price FROM books WHERE price > (SELECT AVG(price) FROM books);

/*
Average price = 9.59

Output:
The Great Gatsby
The Hobbit
*/

-- Find all books that belong to categories where there are more than 3 books in stock.
SELECT * FROM books WHERE category IN (SELECT category FROM books WHERE in_stock > 3);

/*
Categories returned by subquery:
Classic, Dystopian, Fantasy

Output:
All 5 books
*/