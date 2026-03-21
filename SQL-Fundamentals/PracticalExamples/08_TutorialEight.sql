CREATE DATABASE bookstore;
USE bookstore;
/*
Output:
Query OK, 1 row affected
Database changed
*/
-- How it works: Creates a new database named bookstore and switches the active context to it.
--               All subsequent tables and queries target this database.

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2), 
    published_date DATE,
    category VARCHAR(100),
    in_stock INT
);
/*
Output:
Query OK, 0 rows affected
*/
-- How it works: Creates the books table with 7 columns.
--               book_id is the PRIMARY KEY — must be unique and non-NULL for every row.
--               DECIMAL(10,2) stores price with up to 10 total digits and exactly 2 decimal places.
--               published_date uses the DATE type (YYYY-MM-DD), storing no time component.

INSERT INTO books (book_id, title, author, price, published_date, category, in_stock) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 10.99, '1925-04-10', 'Classic', 5),
(2, 'To Kill a Mockingbird', 'Harper Lee', 7.99, '1960-07-11', 'Classic', 3),
(3, '1984', 'George Orwell', 8.99, '1949-06-08', 'Dystopian', 4),
(4, 'The Catcher in the Rye', 'J.D. Salinger', 6.99, '1951-07-16', 'Classic', 2),
(5, 'The Hobbit', 'J.R.R. Tolkien', 12.99, '1937-09-21', 'Fantasy', 6);
/*
Output:
Query OK, 5 rows affected
*/

-- How it works: SELECT * retrieves all columns and all rows from the books table.
--               No WHERE clause means no filtering — every inserted row is returned.
SELECT * FROM books;
/*
Output:
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
| book_id | title                  | author              | price | published_date | category  | in_stock |
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
|       1 | The Great Gatsby       | F. Scott Fitzgerald | 10.99 | 1925-04-10     | Classic   |        5 |
|       2 | To Kill a Mockingbird  | Harper Lee          |  7.99 | 1960-07-11     | Classic   |        3 |
|       3 | 1984                   | George Orwell       |  8.99 | 1949-06-08     | Dystopian |        4 |
|       4 | The Catcher in the Rye | J.D. Salinger       |  6.99 | 1951-07-16     | Classic   |        2 |
|       5 | The Hobbit             | J.R.R. Tolkien      | 12.99 | 1937-09-21     | Fantasy   |        6 |
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
5 rows in set
*/

-- How it works: SELECT title, author retrieves only those two columns (not all columns).
--               WHERE price < 10.00 filters to books whose price is strictly below 10.00.
--               The Great Gatsby (10.99) and The Hobbit (12.99) exceed 10.00 and are excluded.
--               3 books qualify: To Kill a Mockingbird (7.99), 1984 (8.99), The Catcher in the Rye (6.99).
SELECT title, author FROM books WHERE price < 10.00;
/*
Output:
+------------------------+---------------+
| title                  | author        |
+------------------------+---------------+
| To Kill a Mockingbird  | Harper Lee    |
| 1984                   | George Orwell |
| The Catcher in the Rye | J.D. Salinger |
+------------------------+---------------+
3 rows in set
*/

-- Date comparison example
-- How it works: MySQL compares DATE values chronologically (earlier = smaller).
--               WHERE published_date < '1950-01-01' returns books published strictly before 1950.
--               The Great Gatsby (1925), The Hobbit (1937), and 1984 (1949) qualify.
--               To Kill a Mockingbird (1960) and The Catcher in the Rye (1951) do not.
SELECT title, published_date FROM books WHERE published_date < '1950-01-01';
/*
Output:
+------------------+----------------+
| title            | published_date |
+------------------+----------------+
| The Great Gatsby | 1925-04-10     |
| 1984             | 1949-06-08     |
| The Hobbit       | 1937-09-21     |
+------------------+----------------+
3 rows in set
Note: Rows are returned in insertion order (primary-key order) since no ORDER BY is specified.
*/

-- LIKE operator example
-- How it works: LIKE is used for pattern matching on strings.
--               The % wildcard matches any sequence of zero or more characters.
--               '%the%' matches any title containing 'the' anywhere (at the start, middle, or end).
--               MySQL's default collation (utf8mb4_general_ci) makes LIKE case-INSENSITIVE,
--               so 'the', 'The', 'THE' all match.
--               'The Great Gatsby', 'The Catcher in the Rye', and 'The Hobbit' all contain 'the'.
--               'To Kill a Mockingbird' and '1984' do not contain 'the' — excluded.
SELECT title, author FROM books WHERE title LIKE '%the%';
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- OR operator example
-- How it works: OR returns a row if AT LEAST ONE of the conditions is TRUE.
--               category = 'Classic' matches 3 books (Great Gatsby, To Kill a Mockingbird,
--               The Catcher in the Rye); category = 'Fantasy' matches 1 book (The Hobbit).
--               1984 (Dystopian) satisfies neither condition and is excluded.
SELECT title, author FROM books WHERE category = 'Classic' OR category = 'Fantasy';
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
4 rows in set
*/

-- NOT operator example
-- How it works: NOT negates the condition that follows it.
--               NOT category = 'Dystopian' is equivalent to category != 'Dystopian'.
--               Only 1984 has category = 'Dystopian', so it is excluded.
--               The remaining 4 books are returned.
SELECT title, author FROM books WHERE NOT category = 'Dystopian';
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
4 rows in set
*/

-- IN operator example
-- How it works: IN (value1, value2, ...) is shorthand for multiple OR conditions.
--               WHERE category IN ('Classic', 'Fantasy') is equivalent to
--               WHERE category = 'Classic' OR category = 'Fantasy'.
--               Produces the same 4-row result as the OR query above.
--               IN is preferred over chained OR when checking multiple values for the same column.
SELECT title, author FROM books WHERE category IN ('Classic', 'Fantasy');
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
4 rows in set
*/

-- AND operator example
-- How it works: AND requires BOTH conditions to be TRUE for a row to be included.
--               Condition 1: category = 'Classic' → matches Great Gatsby, To Kill a Mockingbird,
--               The Catcher in the Rye (3 books).
--               Condition 2: in_stock > 2 → stock must be greater than 2.
--               The Catcher in the Rye has in_stock = 2 (not > 2) → excluded.
--               Great Gatsby (5) and To Kill a Mockingbird (3) satisfy both conditions.
SELECT title, price FROM books WHERE category = 'Classic' AND in_stock > 2;
/*
Output:
+-----------------------+-------+
| title                 | price |
+-----------------------+-------+
| The Great Gatsby      | 10.99 |
| To Kill a Mockingbird |  7.99 |
+-----------------------+-------+
2 rows in set
*/

-- BETWEEN operator example
-- How it works: BETWEEN low AND high is inclusive on both ends (equivalent to price >= 7.00 AND price <= 10.00).
--               Books in the 7.00–10.00 range:
--               To Kill a Mockingbird (7.99) ✓, 1984 (8.99) ✓.
--               The Great Gatsby (10.99) exceeds 10.00 → excluded.
--               The Catcher in the Rye (6.99) is below 7.00 → excluded.
--               The Hobbit (12.99) exceeds 10.00 → excluded.
SELECT title, price FROM books WHERE price BETWEEN 7.00 AND 10.00;
/*
Output:
+-----------------------+-------+
| title                 | price |
+-----------------------+-------+
| To Kill a Mockingbird |  7.99 |
| 1984                  |  8.99 |
+-----------------------+-------+
2 rows in set
*/

-- IS NULL operator example
-- How it works: IS NULL checks whether a column value is NULL (missing/unknown).
--               NULL cannot be compared with = (WHERE published_date = NULL always returns FALSE).
--               IS NULL is the correct way to check for NULL.
--               All 5 books have a published_date value, so no rows match.
SELECT title, author FROM books WHERE published_date IS NULL;
/*
Output:
Empty set (0 rows)
*/

-- IS NOT NULL operator example
-- How it works: IS NOT NULL is the inverse of IS NULL — returns rows where the column
--               has a non-NULL value. Since all 5 books have a published_date, all 5 are returned.
SELECT title, author FROM books WHERE published_date IS NOT NULL;
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| 1984                   | George Orwell       |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
5 rows in set
*/

-- Combining multiple operators
-- Combining OR, AND, and date comparison
-- How it works: Conditions evaluated left to right with operator precedence.
--               AND has higher precedence than OR, so the parentheses around the OR matter:
--               Step 1: (category = 'Classic' OR category = 'Fantasy') → Classic & Fantasy books (4 rows).
--               Step 2: AND price < 10.00 → Great Gatsby (10.99) and The Hobbit (12.99) excluded → 2 rows left
--               (To Kill a Mockingbird 7.99, The Catcher in the Rye 6.99).
--               Step 3: AND published_date < '1950-01-01' → both survivors are from 1951 and 1960 → excluded.
--               No rows satisfy all three conditions simultaneously.
SELECT title, author FROM books 
WHERE (category = 'Classic' OR category = 'Fantasy')    
AND price < 10.00
AND published_date < '1950-01-01';
/*
Output:
Empty set (0 rows)
Note: The Catcher in the Rye (Classic, 6.99) was published in 1951 — not before 1950.
      To Kill a Mockingbird (Classic, 7.99) was published in 1960 — not before 1950.
      No Classic/Fantasy book is both cheap (< 10.00) and published before 1950.
*/

-- Combining NOT, IN, and date comparison
-- How it works: NOT category IN ('Dystopian', 'Fantasy') excludes 1984 (Dystopian) and
--               The Hobbit (Fantasy), leaving 3 Classic books.
--               AND published_date < '1950-01-01' further filters to books published before 1950.
--               Of the Classic books: Great Gatsby (1925) ✓, To Kill a Mockingbird (1960) ✗,
--               The Catcher in the Rye (1951) ✗.
--               Only The Great Gatsby satisfies both conditions.
SELECT title, author FROM books 
WHERE NOT category IN ('Dystopian', 'Fantasy')
AND published_date < '1950-01-01';
/*
Output:
+------------------+---------------------+
| title            | author              |
+------------------+---------------------+
| The Great Gatsby | F. Scott Fitzgerald |
+------------------+---------------------+
1 row in set
*/

-- Finding null values with IS NULL and IS NOT NULL
-- How it works: Identical to the IS NULL query above. All books have a published_date,
--               so no rows satisfy the IS NULL condition.
SELECT title, author FROM books WHERE published_date IS NULL;
/*
Output:
Empty set (0 rows)
*/

-- != operator example
-- How it works: != (not equal) excludes rows where category equals 'Dystopian'.
--               Only 1984 has category = 'Dystopian', so it is the only row excluded.
--               The remaining 4 books are returned.
SELECT title, author FROM books WHERE category != 'Dystopian';
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
4 rows in set
*/

-- <> operator example
-- How it works: <> is the standard SQL "not equal" operator — functionally identical to !=.
--               Produces the exact same result as the != query above.
SELECT title, author FROM books WHERE category <> 'Dystopian';
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| To Kill a Mockingbird  | Harper Lee          |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
4 rows in set
*/

-- Pattern matching
-- How it works: 'The%' matches any title that STARTS WITH 'The' (case-insensitive by default).
--               The % wildcard matches any characters after 'The' (including spaces).
--               'To Kill a Mockingbird' starts with 'To', not 'The' → excluded.
--               '1984' starts with '1' → excluded.
SELECT title, author FROM books WHERE title LIKE 'The%'; 
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- How it works: '%the' matches titles that END WITH 'the' (case-insensitive).
--               No book title in this table ends with 'the', so the result is empty.
SELECT title, author FROM books WHERE title LIKE '%the'; 
/*
Output:
Empty set (0 rows)
*/

-- How it works: '%the%' matches any title that CONTAINS 'the' ANYWHERE (case-insensitive).
--               Identical to the first LIKE example above.
--               'The Great Gatsby', 'The Catcher in the Rye', 'The Hobbit' all contain 'the'.
SELECT title, author FROM books WHERE title LIKE '%the%'; 
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- How it works: _ (underscore) matches EXACTLY ONE character.
--               '_he%' means: any single character, then 'he', then anything.
--               'The Great Gatsby'       → 'T' + 'he' + rest → matches ✓
--               'The Catcher in the Rye' → 'T' + 'he' + rest → matches ✓
--               'The Hobbit'             → 'T' + 'he' + rest → matches ✓
--               'To Kill a Mockingbird'  → 'T' + 'o ' → 'o ' ≠ 'he' → no match ✗
--               '1984'                   → '1' + '9' → '9' ≠ 'he' → no match ✗
SELECT title, author FROM books WHERE title LIKE '_he%'; 
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- How it works: 'T%h%' matches titles that start with 'T', then have 'h' somewhere later,
--               then anything after that.
--               'The Great Gatsby'       → starts with T, contains h (in 'The') ✓
--               'The Catcher in the Rye' → starts with T, contains h (in 'the') ✓
--               'The Hobbit'             → starts with T, contains h (in 'The') ✓
--               'To Kill a Mockingbird'  → starts with T, no 'h' anywhere → no match ✗
--               '1984'                   → does not start with T → no match ✗
SELECT title, author FROM books WHERE title LIKE 'T%h%'; 
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- case sensitivity in pattern matching
-- How it works: MySQL's default collation (utf8mb4_general_ci, ci = case insensitive)
--               makes LIKE case-insensitive. So 'the%' and 'The%' produce identical results.
--               All three books starting with 'The' are matched regardless of case.
SELECT title, author FROM books WHERE title LIKE 'the%'; 
/*
Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- ERROR QUERY (ILIKE is not supported in MySQL — kept as-is, correction on next line):
-- How it works: ILIKE is a case-insensitive LIKE operator supported in PostgreSQL but NOT MySQL.
--               MySQL raises a syntax error when ILIKE is encountered.
SELECT title, author FROM books WHERE title ILIKE 'the%'; 
/*
Output:
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds
to your MySQL server version for the right syntax to use near 'ILIKE 'the%'' at line 1
Note: MySQL's LIKE is already case-insensitive by default with the standard collation.
      Use LIKE instead of ILIKE, or use LIKE ... COLLATE utf8mb4_general_ci for explicit
      case-insensitive matching.
*/
-- CORRECTION: In MySQL, simply use LIKE — it is case-insensitive by default.
SELECT title, author FROM books WHERE title LIKE 'the%';
/*
Corrected Output:
+------------------------+---------------------+
| title                  | author              |
+------------------------+---------------------+
| The Great Gatsby       | F. Scott Fitzgerald |
| The Catcher in the Rye | J.D. Salinger       |
| The Hobbit             | J.R.R. Tolkien      |
+------------------------+---------------------+
3 rows in set
*/

-- How it works: LIKE BINARY forces a BINARY (byte-level, case-SENSITIVE) comparison.
--               '%SQL%' looks for the exact uppercase string 'SQL' anywhere in the title.
--               None of the 5 book titles contain the string 'SQL' in any case.
--               Result is an empty set.
--               Note: LIKE BINARY is deprecated in MySQL 8.0.27+. The recommended alternative
--               is LIKE '%SQL%' COLLATE utf8mb4_bin for case-sensitive pattern matching.
SELECT title, author FROM books WHERE title LIKE BINARY '%SQL%'; 
/*
Output:
Empty set (0 rows)
*/

-- Price between a range and date comparison
-- How it works: Two conditions combined with AND.
--               Condition 1: BETWEEN 5.00 AND 10.00 → inclusive range (price >= 5.00 AND price <= 10.00).
--               Qualifying books: To Kill a Mockingbird (7.99), 1984 (8.99), The Catcher in the Rye (6.99).
--               Condition 2: published_date < '1950-01-01' → published before 1950.
--               Of those three: only 1984 (1949-06-08) was published before 1950.
--               To Kill a Mockingbird (1960) and The Catcher in the Rye (1951) fail condition 2.
SELECT title, price FROM books WHERE price BETWEEN 5.00 AND 10.00 AND published_date < '1950-01-01';
/*
Output:
+------+-------+
| title| price |
+------+-------+
| 1984 |  8.99 |
+------+-------+
1 row in set
*/

-- Price is greater than average price
-- How it works: The subquery (SELECT AVG(price) FROM books) runs first and computes the
--               average price across all 5 books:
--               (10.99 + 7.99 + 8.99 + 6.99 + 12.99) / 5 = 47.95 / 5 = 9.59.
--               The outer query then returns books whose price exceeds 9.59:
--               The Great Gatsby (10.99) ✓, The Hobbit (12.99) ✓.
--               To Kill a Mockingbird (7.99), 1984 (8.99), The Catcher in the Rye (6.99)
--               are all below the average and are excluded.
SELECT title, price FROM books WHERE price > (SELECT AVG(price) FROM books);
/*
Average price = 9.59

Output:
+------------------+-------+
| title            | price |
+------------------+-------+
| The Great Gatsby | 10.99 |
| The Hobbit       | 12.99 |
+------------------+-------+
2 rows in set
*/

-- Find all books that belong to categories where there are more than 3 books in stock.
-- How it works: The subquery runs first:
--               SELECT category FROM books WHERE in_stock > 3
--               finds all categories that have at least one book with in_stock > 3.
--               Books with in_stock > 3: Great Gatsby(5,Classic), 1984(4,Dystopian),
--               The Hobbit(6,Fantasy), Wireless Mouse(50) — wait, only the books table here.
--               Great Gatsby → Classic (5 > 3) ✓
--               1984 → Dystopian (4 > 3) ✓
--               The Hobbit → Fantasy (6 > 3) ✓
--               Subquery returns: ('Classic', 'Dystopian', 'Fantasy').
--               The outer query then returns ALL books whose category is IN that list.
--               Classic books: Great Gatsby, To Kill a Mockingbird, The Catcher in the Rye.
--               Dystopian books: 1984.
--               Fantasy books: The Hobbit.
--               All 5 books belong to one of these three categories → all 5 rows returned.
SELECT * FROM books WHERE category IN (SELECT category FROM books WHERE in_stock > 3);
/*
Subquery result: ('Classic', 'Dystopian', 'Fantasy')

Output:
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
| book_id | title                  | author              | price | published_date | category  | in_stock |
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
|       1 | The Great Gatsby       | F. Scott Fitzgerald | 10.99 | 1925-04-10     | Classic   |        5 |
|       2 | To Kill a Mockingbird  | Harper Lee          |  7.99 | 1960-07-11     | Classic   |        3 |
|       3 | 1984                   | George Orwell       |  8.99 | 1949-06-08     | Dystopian |        4 |
|       4 | The Catcher in the Rye | J.D. Salinger       |  6.99 | 1951-07-16     | Classic   |        2 |
|       5 | The Hobbit             | J.R.R. Tolkien      | 12.99 | 1937-09-21     | Fantasy   |        6 |
+---------+------------------------+---------------------+-------+----------------+-----------+----------+
5 rows in set
Note: To Kill a Mockingbird (in_stock=3) and The Catcher in the Rye (in_stock=2) are included
      because their CATEGORY (Classic) qualifies — not because their own stock is > 3.
      The subquery filters by category, not by the individual book's stock.
*/