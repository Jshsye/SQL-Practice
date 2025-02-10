CREATE TABLE employees (
						employee_id int, 
						name varchar(25),
						department varchar(25),
						salary DECIMAL(10, 2),
						hiredate date
						);


-- Inserting more records into employees table 

INSERT INTO EMPLOYEES (EMPLOYEE_ID, NAME, DEPARTMENT, SALARY, HIREDATE)
VALUES
	(1, 'John Doe', 'IT', 50000, '2020-01-15'),
	(2, 'Jane Smith', 'HR', 55000, '2019-08-20'),
	(
		3,
		'Michael Lee',
		'Marketing',
		60000,
		'2020-03-10'
	),
	(4, 'Emily Brown', 'Finance', 65000, '2018-11-05'),
	(5, 'David Wilson', 'IT', 52000, '2021-02-28');


-- creating product table

CREATE TABLE PRODUCTS (
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(100),
	CATEGORY VARCHAR(100),
	PRICE DECIMAL(10, 2),
	QUANTITY_IN_STOCK INT
);


-- inserting records into products table 

INSERT INTO
	PRODUCTS (
		PRODUCT_ID,
		PRODUCT_NAME,
		CATEGORY,
		PRICE,
		QUANTITY_IN_STOCK
	)
VALUES
	(101, 'Laptop', 'Electronics', 1200, 50),
	(102, 'Smartphone', 'Electronics', 800, 100),
	(103, 'Headphones', 'Electronics', 100, 200),
	(104, 'T-shirt', 'Clothing', 20, 300),
	(105, 'Jeans', 'Clothing', 50, 150);


--Creating customers table 

CREATE TABLE CUSTOMERS (
	CUSTOMER_ID INT,
	CUSTOMER_NAME VARCHAR(100),
	EMAIL VARCHAR(100),
	PHONE_NUMBER VARCHAR(20),
	CITY VARCHAR(100)
);


-- inserting data into customers table 

INSERT INTO
	CUSTOMERS (
		CUSTOMER_ID,
		CUSTOMER_NAME,
		EMAIL,
		PHONE_NUMBER,
		CITY
	)
VALUES
	(
		201,
		'Alice Johnson',
		'alice@example.com',
		'1234567890',
		'New York'
	),
	(
		202,
		'Bob Smith',
		'bob@example.com',
		'9876543210',
		'Los Angeles'
	),
	(
		203,
		'Emma Davis',
		'emma@example.com',
		'4567890123',
		'Chicago'
	),
	(
		204,
		'Jack Brown',
		'jack@example.com',
		'7890123456',
		'Houston'
	),
	(
		205,
		'Olivia Wilson',
		'olivia@example.com',
		'2345678901',
		'Miami'
	);

	
-- creating orders table 

CREATE TABLE ORDERS (
	ORDER_ID INT,
	CUSTOMER_ID INT,
	PRODUCT_ID INT,
	ORDER_DATE DATE,
	QUANTITY_ORDERED INT
);


-- inserting data into orders

INSERT INTO
	ORDERS (
		ORDER_ID,
		CUSTOMER_ID,
		PRODUCT_ID,
		ORDER_DATE,
		QUANTITY_ORDERED
	)
VALUES
	(301, 201, 101, '2022-03-15', 2),
	(302, 202, 103, '2022-03-16', 3),
	(303, 203, 104, '2022-03-17', 1),
	(304, 204, 102, '2022-03-18', 2),
	(305, 205, 105, '2022-03-19', 1);
	

-- PRIMARY KEY (t_id cannot be empty, cannot be duplicate, it has be unique)

CREATE TABLE TRANSACTION (
	TRANSACTION_ID INT PRIMARY KEY,
	CUSTOMER_ID INT,
	AMOUNT DECIMAL(10, 2),
	TRANSACTION_DATE DATE,
	PAYMENT_METHOD VARCHAR(50)
);


-- inserting records into transactions

INSERTINTO TRANSACTION (
	TRANSACTION_ID,
	CUSTOMER_ID,
	AMOUNT,
	TRANSACTION_DATE,
	PAYMENT_METHOD
)
VALUES
	(401, 201, 1200, '2022-03-15', 'Credit Card'),
	(402, 202, 1000, '2022-03-16', 'PayPal'),
	(403, 203, 800, '2022-03-17', 'Cash'),
	(404, 204, 1500, '2022-03-18', 'Debit Card'),
	(405, 205, 600, '2022-03-19', 'PayPal');


-- Q.1 Find the employee with the highest salary.

SELECT
	*
FROM
	EMPLOYEES
ORDER BY
	SALARY DESC;


-- Q.2 List employees hired after January 1, 2021.

SELECT
	*
FROM
	EMPLOYEES
WHERE
	HIREDATE < '2021-01-01';


-- Q.3 Calculate the average salary of employees in each department.

SELECT
	DEPARTMENT,
	round(AVG(SALARY),2)
FROM
	EMPLOYEES
GROUP BY
	DEPARTMENT


-- Q.4 Update the salary of employee with ID 3 to 62000.

UPDATE EMPLOYEES
SET
	SALARY = 62000
WHERE
	EMPLOYEE_ID = 3;


-- Q.5 Delete the employee with the lowest salary.

select * from employees

DELETE FROM EMPLOYEES
WHERE
	SALARY < 52000


-- -- Product Queries:
-- Q.6 Find the total value of products in stock for each category.

SELECT
	CATEGORY,
	SUM(PRICE)
FROM
	PRODUCTS
GROUP BY
	CATEGORY;


-- Q.7 Identify products with a quantity in stock less than 50.

SELECT
	*
FROM
	PRODUCTS
WHERE
	QUANTITY_IN_STOCK <= 50;


-- Q.8 Calculate total number of product we have.

SELECT
	COUNT(PRODUCT_NAME)
FROM
	PRODUCTS;


-- Q.9 Update the price of all products in 
--   the 'Clothing' category to 10% higher.

UPDATE PRODUCTS
SET
	PRICE = PRICE * 1.10
WHERE
	CATEGORY = 'Clothing';


-- Q.10 Delete products with a price less than 50.

DELETE FROM PRODUCTS
WHERE
	PRICE < 50;


-- -- Customer Queries:
-- Q.11 Count the number of customers in each city.

SELECT
	CITY,
	COUNT(CUSTOMER_NAME) AS TOTL_CUST
FROM
	CUSTOMERS
GROUP BY
	CITY;


-- Q.12 Identify customers who have made transactions using PayPal.

SELECT
	CUSTOMERS.CUSTOMER_NAME,
	TRANSACTION.PAYMENT_METHOD
FROM
	CUSTOMERS
	JOIN TRANSACTION ON CUSTOMERS.CUSTOMER_ID = TRANSACTION.CUSTOMER_ID
WHERE
	PAYMENT_METHOD = 'PayPal';


-- Q.13 Calculate the total amount spent by each customer.

SELECT
	CUSTOMERS.CUSTOMER_NAME,
	SUM(TRANSACTION.AMOUNT)
FROM
	CUSTOMERS
	JOIN TRANSACTION ON CUSTOMERS.CUSTOMER_ID = TRANSACTION.CUSTOMER_ID
GROUP BY
	CUSTOMERS.CUSTOMER_NAME;


-- Q.14 Update the email of customer with ID 204 to 'new_email@example.com'.

UPDATE CUSTOMERS
SET
	EMAIL = 'new_email@example.com'
WHERE
	CUSTOMER_ID = 204;


-- Q.15 Delete customers who have not made any transactions.

SELECT
	CUSTOMERS.CUSTOMER_NAME,
	TRANSACTION.AMOUNT
FROM
	CUSTOMERS
	JOIN TRANSACTION ON CUSTOMERS.CUSTOMER_ID = TRANSACTION.CUSTOMER_ID
WHERE
	TRANSACTION.AMOUNT = NULL;


-- -- Order Queries:
-- Q.16. Find the total number of orders placed on each date.

SELECT
	ORDER_DATE,
	SUM(QUANTITY_ORDERED)
FROM
	ORDERS
GROUP BY
	ORDER_DATE;


-- Q.17 Identify orders with a quantity_ordered greater than 3.

SELECT
	*
FROM
	ORDERS
WHERE
	QUANTITY_ORDERED >= 3;


-- Q.18 Calculate the total sale amount for each product.

SELECT
	PRODUCTS.PRODUCT_NAME,
	SUM(PRODUCTS.PRICE * ORDERS.QUANTITY_ORDERED) AS TOT_SALES
FROM
	PRODUCTS
	JOIN ORDERS ON PRODUCTS.PRODUCT_ID = ORDERS.PRODUCT_ID
GROUP BY
	PRODUCT_NAME;


-- Q.19 Update the order_date of order with ID 304 to '2022-03-20'.

UPDATE ORDERS
SET
	ORDER_DATE = '2022-03-20'
WHERE
	ORDER_ID = 304;


-- Q.20 Delete orders placed before January 1, 2022.

DELETE FROM ORDERS
WHERE
	ORDER_DATE < '2022-01-01';


-- Q.21. Find the average transaction amount for each payment method.

SELECT
	PAYMENT_METHOD,
	ROUND(AVG(AMOUNT), 2)
FROM
	TRANSACTION
GROUP BY
	PAYMENT_METHOD;


-- Q.22 Identify transactions made on March 15,

SELECT
	*
FROM
	TRANSACTION
WHERE
	TRANSACTION_DATE = '2022-03-15';


--1. Insert a new employee with the following details: EmployeeID = 101, 
--   Name = 'John Doe', Department = 'Marketing', Salary = 60000,
--    HireDate = '2022-04-01'.

INSERT INTO
	EMPLOYEES
VALUES
	(101, 'John Doe', 'Marketing', 60000, '2022-04-01');


--2. Add a new product with the following details: ProductID = 11, 
--   Name = 'Smartphone', Category = 'Electronics', Price = 799.99,
--    Quantity = 100.

INSERT INTO
	PRODUCTS
VALUES
	(11, 'Smartphone', 'Electronics', 799.99, 100);


--1. Increase the salary of all employees in the 'Sales' department by 10%.

UPDATE EMPLOYEES
SET
	SALARY = SALARY * 1.10
WHERE
	DEPARTMENT = 'Sales';


--   2. Update the price of the product with ProductID = 3 to 99.99.

UPDATE PRODUCTS
SET
	PRICE = 99.99
WHERE
	PRODUCT_ID = 3;


-- -- Deletion Tasks:
-- 1. Delete the employee with EmployeeID = 102.

DELETE FROM EMPLOYEES
WHERE
	EMPLOYEE_ID = 102;

	
-- Remove all products with a Quantity less than 10.

DELETE FROM PRODUCTS
WHERE
	QUANTITY_IN_STOCK < 10;


DROP TABLE IF EXISTS walmart_sales;
CREATE TABLE walmart_sales(
                            invoice_id VARCHAR(15),
                            branch	CHAR(1),	
                            city  VARCHAR(25),  
                            customer_type	VARCHAR(15),
                            gender	VARCHAR(15),
                            product_line VARCHAR(55),	
                            unit_price	FLOAT,
                            quantity    INT, 	
                            vat	FLOAT,
                            total	FLOAT,
                            date	date,	
                            time time,
                            payment_method	VARCHAR(15),
                            rating FLOAT
                        );


SELECT * FROM walmart_sales;




-- Employee Queries:

-- Q.1 Find the employee with the highest salary.
-- Q.2 List employees hired after January 1, 2021.
-- Q.3 Calculate the average salary of employees in each department.
-- Q.4 Update the salary of employee with ID 3 to 62000.
-- Q.5 Delete the employee with the lowest salary.

-- -- Product Queries:
-- Q.6 Find the total value of products in stock for each category.
-- Q.7 Identify products with a quantity in stock less than 50.
-- Q.8 Calculate total number of product we have.
-- Q.9 Update the price of all products in the 'Clothing' category to 10% higher.
-- Q.10 Delete products with a price less than 50.


-- -- Customer Queries:
-- Q.11 Count the number of customers in each city.
-- Q.12 Identify customers who have made transactions using PayPal.
-- Q.13 Calculate the total amount spent by each customer.
-- Q.14 Update the email of customer with ID 204 to 'new_email@example.com'.
-- Q.15 Delete customers who have not made any transactions.


-- -- Order Queries:
-- Q.16. Find the total number of orders placed on each date.
-- Q.17 Identify orders with a quantity_ordered greater than 3.
-- Q.18 Calculate the total sale amount for each product.
-- Q.19 Update the order_date of order with ID 304 to '2022-03-20'.
-- Q.20 Delete orders placed before January 1, 2022.



-- Transaction Queries:
-- Q.21. Find the average transaction amount for each payment method.
-- Q.22 Identify transactions made on March 15,


-- Your TASK

-- -- Insertion Tasks:
-- 1. Insert a new employee with the following details: EmployeeID = 101, Name = 'John Doe', Department = 'Marketing', Salary = 60000, HireDate = '2022-04-01'.
-- 2. Add a new product with the following details: ProductID = 11, Name = 'Smartphone', Category = 'Electronics', Price = 799.99, Quantity = 100.

-- -- Update Tasks:
-- 1. Increase the salary of all employees in the 'Sales' department by 10%.
-- Update the price of the product with ProductID = 3 to 99.99.

-- -- Deletion Tasks:
-- 1. Delete the employee with EmployeeID = 102.
-- Remove all products with a Quantity less than 10.




-- -------------------------------------------
-- Business Problems :: Basic Level
-- ---------------------------------------------

-- Q.1 Find the total sales amount for each branch

SELECT
	BRANCH,
	ROUND(SUM(CAST(UNIT_PRICE AS INT) * QUANTITY), 2) AS TOT_SALES
FROM
	WALMART_SALES
GROUP BY
	BRANCH;


-- Q.2 Calculate the average customer rating for each city.

SELECT
	CITY,
	ROUND(AVG(Cast(RATING as int)), 3)
FROM
	WALMART_SALES
GROUP BY CITY;


-- Q.3 Count the number of sales transactions for each customer type.

SELECT
	CUSTOMER_TYPE,
	COUNT(INVOICE_ID) AS TOT_COUNT
FROM
	WALMART_SALES
GROUP BY
	CUSTOMER_TYPE;


-- Q.4 Find the total quantity of products sold for each product line.

SELECT
	PRODUCT_LINE,
	COUNT(QUANTITY)
FROM
	WALMART_SALES
GROUP BY
	PRODUCT_LINE;


-- Q.4 v1 Calculate the total VAT collected for each payment method.

SELECT
	PAYMENT_METHOD,
	ROUND(SUM(CAST(VAT AS INT)), 2)
FROM
	WALMART_SALES
GROUP BY
	PAYMENT_METHOD;


-- -- Business Problems :: Medium Level
-- -- ---------------------------------------------
-- Q.5 Find the total sales amount and average customer rating 
--      for each branch.

SELECT
	BRANCH,
	SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES,
	AVG(RATING) AS AVG_RATING
FROM
	WALMART_SALES
GROUP BY
	BRANCH;


-- Q.6 Calculate the total sales amount for each city 
--     and gender combination.

SELECT
	CITY,
	GENDER,
	SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES
FROM
	WALMART_SALES
GROUP BY
	CITY,
	GENDER;


-- Q.7 Find the average quantity of products sold for 
--      each product line to female customers.

SELECT
	PRODUCT_LINE,
	AVG(QUANTITY) AS AVG_QTY
FROM
	WALMART_SALES
GROUP BY
	PRODUCT_LINE;


-- Q.8 Count the number of sales transactions for members 
--     in each branch.

SELECT
	BRANCH,
	COUNT(INVOICE_ID) AS TOT_TRANSACTION
FROM
	WALMART_SALES
GROUP BY
	BRANCH;


-- Q.9 Find the total sales amount for each day. 
-- (Return day name and their total sales order DESC by amt)

SELECT
	TO_CHAR(DATE, 'Day') AS DAY_,
	SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES
FROM
	WALMART_SALES
GROUP BY
	DAY_
ORDER BY
	TOT_SALES DESC;


-- Q.10 Calculate the total sales amount for each hour of 
--      the day

SELECT
	EXTRACT(
		HOUR
		FROM
			TIME
	) AS HOURS,
	SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES
FROM
	WALMART_SALES
GROUP BY
	HOURS
ORDER BY	TOT_SALES ASC;


-- Q.11 Find the total sales amount for each month. 
 --    (return month name and their sales)

SELECT
	EXTRACT(
		MONTH
		FROM
			DATE
	) AS MONTHS,
	SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES
FROM
	WALMART_SALES
GROUP BY
	1;


-- Q.12 Calculate the total sales amount for each branch
--      where the average customer rating is greater than 8.

SELECT BRANCH,
SUM(CAST(UNIT_PRICE AS INT) * (QUANTITY)) AS TOT_SALES
FROM
	WALMART_SALES
WHERE
	RATING >= 8
GROUP BY
	BRANCH;


-- Q.13 Find the total VAT collected for each product
--  line where the total sales amount is more than 500.

SELECT
	PRODUCT_LINE,
	SUM(VAT) AS T_VAT
FROM
	WALMART_SALES
WHERE
	TOTAL > 500
GROUP BY
	PRODUCT_LINE;


-- Q.14 Calculate the average sales amount for each gender 
--      in each branch.

SELECT
	BRANCH,
	GENDER,
	AVG(TOTAL) AS AV_T
FROM
	WALMART_SALES
GROUP BY
	2,
	1;


-- Q.15 Count the number of sales transactions for each 
--      day of the week.

SELECT
	EXTRACT(
		WEEK
		FROM
			DATE
	) AS WKK,
	COUNT(INVOICE_ID) AS AV_TRANSACTION
FROM
	WALMART_SALES
GROUP BY
	1;
	

--Q.16 Find the total sales amount for each city and customer
--    type combination where the number of sales transactions 
--    is greater than 50.

SELECT
	CITY,
	CUSTOMER_TYPE,
	COUNT(INVOICE_ID) AS Total_Transaction,
	SUM(TOTAL)
FROM
	WALMART_SALES
GROUP BY
	1,
	2
HAVING
	COUNT(INVOICE_ID) > 50;


-- Q.17 Calculate the average unit price for each product 
--      line and payment method combination.

SELECT
	PRODUCT_LINE,
	PAYMENT_METHOD,
	ROUND(AVG(CAST(UNIT_PRICE AS INT)), 2)
FROM
	WALMART_SALES
GROUP BY
	1,
	2;
	

-- Q.18 Find the total sales amount for each branch and 
--      hour of the day combination.

SELECT
	BRANCH,
	EXTRACT(
		HOUR
		FROM
			TIME
	) AS HOUR_OF_DAY,
	SUM(TOTAL) AS TOTAL_SALES
FROM
	WALMART_SALES
GROUP BY
	BRANCH,
	EXTRACT(
		HOUR
		FROM
			TIME
	)
ORDER BY
	BRANCH,
	HOUR_OF_DAY;


-- Q.19 Calculate the total sales amount and average customer
-- rating for each product line where the total sales amount 
--   is greater than 1000.

SELECT
	PRODUCT_LINE,
	AVG(RATING) AS A_R,
	SUM(TOTAL) AS T_SALES
FROM
	WALMART_SALES
WHERE
	TOTAL > 1000
GROUP BY
	1;


-- Q.20 Calculate the total sales amount for morning 
-- (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening 
-- (6 PM to 12 AM) periods using the time condition.

WITH
	NEW_T AS (
		SELECT
			*,
			CASE
				WHEN EXTRACT(
					HOURS
					FROM
						TIME
				) BETWEEN 6 AND 12  THEN 'Morning'
				WHEN EXTRACT(
					HOUR
					FROM
						TIME
				) > 12
				AND EXTRACT(
					HOUR
					FROM
						TIME
				) < 18 THEN 'Afternoon'
				ELSE 'Evening'
			END AS SHIFT
		FROM
			WALMART_SALES
	)
SELECT
	SHIFT,
	SUM(TOTAL)
FROM
	NEW_T
GROUP BY
	SHIFT;















-- -------------------------------------------
-- Business Problems :: Basic Level
-- ---------------------------------------------
-- Q.1 Find the total sales amount for each branch
-- Q.2 Calculate the average customer rating for each city.
-- Q.3 Count the number of sales transactions for each customer type.
-- Q.4 Find the total quantity of products sold for each product line.
-- Q.4 v1 Calculate the total VAT collected for each payment method.


-- -- ---------------------------------------------
-- -- Business Problems :: Medium Level
-- -- ---------------------------------------------
-- Q.5 Find the total sales amount and average customer rating for each branch.
-- Q.6 Calculate the total sales amount for each city and gender combination.
-- Q.7 Find the average quantity of products sold for each product line to female customers.
-- Q.8 Count the number of sales transactions for members in each branch.
-- Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)


-- -- ---------------------------------------------
-- -- Business Problems :: Advanced Level
-- -- ---------------------------------------------
-- Q.10 Calculate the total sales amount for each hour of the day
-- Q.11 Find the total sales amount for each month. (return month name and their sales)
-- Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 8.
-- Q.13 Find the total VAT collected for each product line where the total sales amount is more than 500.
-- Q.14 Calculate the average sales amount for each gender in each branch.
-- Q.15 Count the number of sales transactions for each day of the week.
-- Q.16 Find the total sales amount for each city and customer type combination where the number of sales transactions is greater than 50.
-- Q.17 Calculate the average unit price for each product line and payment method combination.
-- Q.18 Find the total sales amount for each branch and hour of the day combination.
-- Q.19 Calculate the total sales amount and average customer rating for each product line where the total sales amount is greater than 1000.
-- Q.20 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.


