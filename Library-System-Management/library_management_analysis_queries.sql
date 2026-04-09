

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;
SELECT 
    column_name
FROM information_schema.columns
WHERE table_name = 'books';


---------------------PROJECT TASKS --------------------------

------------------ 1. CRUD Operations -------------------
DELETE FROM books
WHERE isbn = '978-1-60129-456-2';

-- Task 1. Create a New Book Record 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '987 Main st'
WHERE member_id = 'C101';
SELECT * FROM members;

-- Task 3: Delete a Record from the Issued Status Table
DELETE FROM issued_status
WHERE   issued_id =   'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee
SELECT * FROM issued_status
WHERE issued_emp_id = 'E104';

-- Task 5: List Members Who Have Issued More Than One Book
SELECT 
	issued_emp_id,
	COUNT(*) as  total_issued_book
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1;

----------------- 2. CTAS (Create Table As Select) ---------------------


-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results 
-- each book and total book_issued_cnt**
CREATE TABLE book_cnts
AS
SELECT 
	b.isbn,
	b.book_title,
	COUNT(ist.issued_id) as no_issued
FROM books as b
JOIN issued_status as ist
ON b.isbn = ist.issued_book_isbn
GROUP BY 1, 2;

SELECT * FROM book_cnts


----------------- 3.  Data Analysis & Findings ---------------------


-- Task 7. Retrieve All Books in a Specific Category:
SELECT * FROM books
WHERE category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
SELECT 
	b.category,
	SUM(b.rental_price) as rental_income,
	COUNT(*) as total_issued_cnt
FROM books as b
JOIN issued_status as ist
ON b.isbn = ist.issued_book_isbn
GROUP BY 1
ORDER BY 2 DESC;

-- Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180';

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT  
	e1.*,
	b.manager_id,
	e2.emp_name as manager
FROM employees as e1
JOIN branch as b
ON e1.branch_id = b.branch_id
JOIN employees as e2
ON b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE book_rental_greater_7
AS
SELECT * FROM books
WHERE rental_price >7;

SELECT * FROM book_rental_greater_7;

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT 
	DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;


------------------ 4. Advanced SQL Operations ------------------------


























