use classicmodels;
/*Do có một số khác biệt khi cài mariadb rồi cài mysql nên xuất hiện một số lỗi nhỏ 
do không tương thích. Vì vậy, dể thực hiện một câu lệnh thì cần refresh và sử dụng lệnh 
USE DATABASE;*/

# Mysql_select
SELECT 
    lastname, firstname, jobtitle
FROM
    employees;

-- example 02
SELECT 
    *
FROM
    employees;
    
# Mysql_Distinct
-- example 03
SELECT DISTINCT
    lastname
FROM
    employees
ORDER BY lastname;

-- example 04
SELECT DISTINCT
    state
FROM
    customers;

-- example 05
SELECT DISTINCT
    state, city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY state , city;

-- example 06
SELECT 
    state, city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY state , city;

-- example 07
SELECT 
    state
FROM
    customers
GROUP BY state;

-- example 08
SELECT DISTINCT
    state
FROM
    customers;

-- example 09
SELECT DISTINCT
    state
FROM
    customers
ORDER BY state;

-- example 10
SELECT 
    COUNT(DISTINCT state) as 'Count about state'
FROM
    customers
WHERE
    country = 'USA';

-- example 11
SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL
LIMIT 5;

# Mysql_Order By
-- example 12
SELECT 
    contactLastName, contactFirstName
FROM
    customers
ORDER BY contactLastName;

-- example 13
SELECT 	
    contactLastName, contactFirstName
FROM
    customers
ORDER BY contactFirstName DESC;

-- example 14
SELECT 
    contactLastName, contactFirstName
FROM
    customers
ORDER BY contactFirstName ASC , contactLastName DESC;

-- example 15
SELECT 
    ordernumber,
    orderlinenumber,
    FORMAT(quantityOrdered * priceEach, 2)
FROM
    orderdetails
ORDER BY orderNumber , orderLineNumber , quantityOrdered * priceEach;

-- example 16
SELECT 
    ordernumber,
    orderlinenumber,
    quantityOrdered * priceEach AS subtotal
FROM
    orderdetails
ORDER BY ordernumber , orderLineNumber , subtotal;

-- example 17: Sắp xếp theo trường status. 
SELECT 
    orderNumber, status
FROM
    orders
ORDER BY FIELD(status,
        'Inprocess',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');

# Mysql_Where
-- example 18
SELECT 
    lastname, firstname, jobtitle
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';

-- example 19
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND 
    officeCode = 1;

-- example 20
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobTitle <> 'Sales Rep';

# Mysql_and_Operator: you will learn how to the MySQL AND operator to combine multiple Boolean 
# expressions to filter data."
-- example 21
SELECT 1 = 0 AND 1 / 0;

-- example 22
SELECT 
    customername, 
    country, 
    state
FROM
    customers
WHERE
    country = 'USA' AND state = 'CA';
    
# MySQL OR Operator: you will learn how to the MySQL AND operator to combine multiple Boolean 
# expressions to filter data.
-- example 23
SELECT 1 = 1 OR 1 / 0;
-- example 24
SELECT true OR false AND false; # true: 1, false: 0
-- example 25
SELECT    
 customername, 
 country, 
 creditLimit
FROM    
 customers
WHERE country = 'USA'
 OR country = 'France'
 AND creditlimit > 100000;
 
 # Mysql_IN:L you will learn how to use MySQL IN operator to determine if a specified value matches 
 # any value in a list or a subquery.
 -- example 26
SELECT 
    officeCode, city, phone, country
FROM
    offices
WHERE
    country IN ('USA' , 'France');
    
-- example 27 (tương đương "example 26")
SELECT 
    officeCode, 
    city, 
    phone
FROM
    offices
WHERE
    country = 'USA' OR country = 'France';
 -- example 28
 SELECT 
    officeCode, 
    city, 
    phone
FROM
    offices
WHERE
    country NOT IN ('USA' , 'France');

-- Using MySQL IN with a subquery
/*find the orders whose total values are greater than 60,000, you use the IN operator as shown in 
the following query:*/
-- example 29
SELECT 
    orderNumber, customerNumber, status, shippedDate
FROM
    orders
WHERE
    orderNumber IN (SELECT 
            orderNumber
        FROM
            orderdetails
        GROUP BY orderNumber
        HAVING SUM(quantityOrdered * priceEach) > 60000);

 # MySQL BETWEEN
 -- example 30
 SELECT 
    productCode, productName, buyPrice
FROM
    products
WHERE
    buyPrice BETWEEN 90 AND 100;

-- example 31 <=> example 30
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice >= 90 AND buyPrice <= 100;

-- example 32
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice NOT BETWEEN 20 AND 100;
 
 -- example 33 <=> example 32
 SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice >= 20 OR buyPrice <= 100;
    
-- example 34
 /*
 Using MySQL BETWEEN with dates example
When you use the BETWEEN operator with date values, to get the best result, you should use the type cast to
explicitly convert the type of column or expression to the DATE type.
 */
 SELECT 
    orderNumber, requiredDate, status
FROM
    orders
WHERE
    requireddate BETWEEN CAST('2003-01-01' AS DATE) AND CAST('2003-01-31' AS DATE);

# MySQL LIKE
-- example 35
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    firstName LIKE 'a%';
    
 -- example 36
 SELECT 
	employeeNumber, 
	lastName, 
	firstName
FROM
	employees
WHERE
	firstname LIKE 'T_m';
    
-- example 37
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    lastName NOT LIKE 'B%';
    
 -- example 38
 SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';

# MySQL LIMIT
/*
Home / Basic MySQL Tutorial / MySQL LIMIT
MySQL LIMIT
Summary: in this tutorial, you will learn how to use MySQL LIMIT clause to constrain the number of rows 
returned by a query.
Introduction to MySQL LIMIT clause
The LIMIT clause is used in the SELECT statement to constrain the number of rows in a result set. 
The LIMIT clause accepts one or two arguments. The values of both arguments must be zero or positive 
integers.

The following illustrates the LIMIT clause syntax with two arguments:
SELECT 
    column1,column2,...
FROM
    table
LIMIT offset , count;
Let’s examine the LIMIT clause parameters:
-The offset specifies the offset of the first row to return. The offset of the first row is 0, not 1.
-The count specifies the maximum number of rows to be returned.
*/
-- example 39: this query selects the first 10 customers:
SELECT
 customernumber,
 customername,
 creditlimit
FROM
 customers
LIMIT 10;

-- Using MySQL LIMIT to get the highest and lowest values
-- example 40 -- return 5 customers have creditlimit DESC
SELECT 
    customernumber, customername, creditlimit
FROM
    customers
ORDER BY creditlimit DESC
LIMIT 5;

-- example 41 -- Using MySQL LIMIT to get the nth highest value
SELECT 
	productName, buyprice
FROM
	products
ORDER BY buyprice DESC
LIMIT 1, 1;#trả về hàng thứ 2(offset = 2-1)và số hàng trả về là 1(count = 1)=>trả về 1 hàng bắt đầu chỉ số là 0 
# phân biệt: Limit N; => lúc này sẽ trả về N hàng bắt đầu chỉ số là 0
# => (Limit 0, N;) tương đương với (Limit N;)
# => LIMIT 1, 2; trả về 2 hàng (hàng 2, hàng 3) bắt đầu từ hàng thứ 2(offset = 2 - 1)

# MySQL IS NULL: you will learn how to use the MySQL IS NULL operator to test whether a value is NULL or not.
-- example 42
SELECT 1 IS NOT NULL, -- 1: true
       0 IS NOT NULL, -- 1: true
       NULL IS NOT NULL; -- 0: false

-- example 43
SELECT 
    customerName, country, salesrepemployeenumber
FROM
    customers
WHERE
    salesrepemployeenumber IS NULL
ORDER BY customerName; 

-- example 44
SELECT 
    customerName, 
    country, 
    salesrepemployeenumber
FROM
    customers
WHERE
	salesrepemployeenumber IS NOT NULL
ORDER BY customerName;

-- example 45:
# MySQL IS NULL’s specialized features

# MySQL_ALIAS
-- example 46:
SELECT 
    CONCAT_WS(', ', lastName, firstname) AS 'FullName'
FROM
    employees;

-- example 47:
SELECT 
    CONCAT(lastName, '---', firstName) AS 'hello'
FROM
    employees;

-- example 48:
SELECT 
    orderNumber 'Order No',
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
GROUP BY 'Order No'
HAVING total > 60000;

-- example 49
SELECT 
    customerName, COUNT(o.orderNumber) total
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY customerName
ORDER BY total DESC;

# Mysql_Joins (inner join, cross join, right join, left join, fulljoin, ...)
CREATE TABLE t1 (
    id INT PRIMARY KEY,
    pattern VARCHAR(50) NOT NULL
);
 
CREATE TABLE t2 (
    id VARCHAR(50) PRIMARY KEY,
    pattern VARCHAR(50) NOT NULL
);

INSERT INTO t1(id, pattern)
VALUES(1,'Divot'),
      (2,'Brick'),
      (3,'Grid');
 
INSERT INTO t2(id, pattern)
VALUES('A','Brick'),
      ('B','Grid'),
      ('C','Diamond');
-- example 50: CROSS JOIN
SELECT * FROM t1 CROSS JOIN t2;
SELECT 
    t1.id, t2.id
FROM
    t1
        CROSS JOIN
    t2;

-- example 51: INNER JOIN
SELECT 
    t1.id, t2.id
FROM
    t1
        JOIN
    t2 ON t1.pattern = t2.pattern;

-- example 52: LEFT JOIN
SELECT 
    t1.id, t2.id
FROM
    t1
        LEFT JOIN
    t2 ON t1.pattern = t2.pattern
ORDER BY t1.id;

-- example 53: RIGHT JOIN
SELECT 
    t1.id, t2.id
FROM
    t1
        RIGHT JOIN
    t2 ON t1.pattern = t2.pattern
ORDER BY t1.id;

-- example 54: MySQL INNER JOIN with GROUP BY clause
SELECT 
    T1.orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders AS T1
        INNER JOIN
    orderdetails AS T2 ON T1.orderNumber = T2.orderNumber
GROUP BY orderNumber;

-- example 55: MySQL INNER JOIN using operator other than equal
SELECT 
    orderNumber, 
    productName, 
    msrp, 
    priceEach
FROM
    products p
        INNER JOIN
    orderdetails o ON p.productcode = o.productcode
        AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';	

# MYSQL-LEFT JOIN
-- example 56: Using MySQL LEFT JOIN clause to find "unmatched" rows
SELECT 
    c.customerNumber, c.customerName, orderNumber, o.status
FROM
    customers c
        LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE
    orderNumber is NULL;

-- example 57: Condition in WHERE clause vs. ON clause
SELECT 
    o.orderNumber, o.customerNumber, od.productCode
FROM
    orders o
        LEFT JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
where o.orderNumber = 10123; 
# khi có điều kiện này thì sẽ chỉ lấy những oders nào có (orderNumber = 10123) và những giá trị khác sẽ 
# không được lấy. Lúc này sẽ chỉ show ra những (orderNumber = 10123) còn những hàng khác sẽ ko đk show 

-- example 58: chú ý so sánh với (example 57)
SELECT 
    o.orderNumber, o.customerNumber, od.productCode
FROM
    orders o
        LEFT JOIN
    orderdetails od ON o.orderNumber = od.orderNumber and o.orderNumber = 10123;
# với điều kiện (AND) kèm theo sau thì trả về kết quả khác. Tại sao:
# vì: (LEFT JOIN) sẽ trả về tất cả hàng của bảng order. và những hàng có giá trị như 
# này: (o.orderNumber = od.orderNumber and o.orderNumber = 10123;) thì mới được hiển thị dữ liệu 
# còn những hàng không có điều kiện trên sẽ nhận được giá trị là (NULL)

# MySQL_RightJoin: tương tự như left join

# MySQL_SelfJoin:
-- SelfJoin use InnerJoin
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
        INNER JOIN
    employees m ON m.employeeNumber = e.reportsTo
ORDER BY Manager;

-- SelfJoin use leftJoin
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
        LEFT JOIN
    employees m ON m.employeeNumber = e.reportsTo
ORDER BY Manager;

-- SelfJoin use RightJoin
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
        RIGHT JOIN
    employees m ON m.employeeNumber = e.reportsTo
ORDER BY Manager;

# A Practical Use of MySQL CROSS JOIN Clause
-- exercise 59: xem tại link: http://www.mysqltutorial.org/mysql-cross-join/
-- xem phải "A practices about Cross Join" lưu cùng thư mục. 

# MYSQL_GROUP BY
-- example 60:
SELECT 
    status
FROM
    orders
GROUP BY status;

-- example 61 <=> example 60
SELECT DISTINCT
    status
FROM
    orders;
 -- example 62: Using MySQL GROUP BY with aggregate functions
/*
This example uses the COUNT function with the GROUP BY clause to return the number of products 
in each product line:
*/
 SELECT 
    status, COUNT(*) 'Count' # <=> COUNT(status)
FROM
    orders
GROUP BY status;

-- example 63:
SELECT 
    status, SUM(quantityOrdered * priceEach) AS amount
FROM
    orders
        INNER JOIN
    orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY status;

-- example 64:
SELECT 
    orderNumber, SUM(quantityOrdered * priceEach) AS Total
FROM
    orderdetails
GROUP BY orderNumber;

-- example 65: MySQL GROUP BY with expression example
SELECT 
    YEAR(orderDate) AS Year,
    SUM(quantityOrdered * priceEach) AS Total
FROM
    orders
        INNER JOIN
    orderdetails ON orders.orderNumber = orderdetails.orderNumber
WHERE
    status = 'Shipped'
GROUP BY Year;

-- example 66: Using MySQL GROUP BY with HAVING clause example
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
        INNER JOIN
    orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY year
HAVING year > 2003;

-- example 67: The GROUP BY clause: MySQL vs. standard SQL
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status DESC;

# Mysql-having
-- example 68:
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach * quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING total > 1000;

-- example 69:
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach * quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING total > 1000 AND itemsCount > 600;

SELECT 
    productline, SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY productline;

-- example 70:
SELECT 
    a.ordernumber,
    status,
    SUM(priceeach * quantityOrdered) total
FROM
    orderdetails a
        INNER JOIN
    orders b ON b.ordernumber = a.ordernumber
GROUP BY ordernumber , status
HAVING status = 'Shipped' AND total > 1500;

# MySQL_ROLLUP: you will learn how to use the MySQL ROLLUP clause to generate subtotals and grand totals.
-- example 71: xem ở file mình đã thực hành roll up nhé!!!
 
 # Mysql_subquery:
 -- example 72:
SELECT 
    lastname, firstname
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');

-- example 73: MySQL subquery in WHERE clause
# 1) MySQL subquery with comparison operators
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount = (SELECT 
            MAX(amount)
        FROM
            payments);

SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            payments);

# 2) MySQL subquery with IN and NOT IN operators
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);

# 3) MySQL subquery in the FROM clause
-- Note that the FLOOR() is used to remove decimal places from the average values of items.
SELECT 
    MAX(items), MIN(items), FLOOR(AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        orderdetails
    GROUP BY orderNumber) AS lineitems;

# 4) Mysql correlated subquery
SELECT 
    orderNumber, 
    COUNT(orderNumber) AS items
FROM
    orderdetails
GROUP BY orderNumber;

SELECT 
    productname, buyprice
FROM
    products p1
WHERE
    buyprice > (SELECT 
            AVG(buyprice)
        FROM
            products
        WHERE
            productline = p1.productline);

# 5) MySQL subquery with EXISTS and NOT EXISTS
/*
SELECT 
    *
FROM
    table_name
WHERE
    EXISTS( subquery );
*/
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000; # HAVING total > 60000;

--
/*
You can use the query above as a correlated subquery to find customers who placed at least one 
sales order with the total value greater than 60K by using the EXISTS operator:
*/
SELECT 
    customerNumber, customerName
FROM
    customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
                INNER JOIN
            orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000);

# An Essential Guide to MySQL Derived Table. Hay phết, đọc theo link dưới đây:
-- http://www.mysqltutorial.org/mysql-derived-table/
/*
The following query gets the top 5 products by sales revenue in 2003 from the orders 
and orderdetails tables in the sample database:
*/
SELECT 
    p.productName, p.productCode, SUM(quantityOrdered * priceEach) AS price
FROM
    products p
        JOIN
    orderdetails od ON p.productCode = od.productCode
        JOIN
    orders o ON o.orderNumber = od.orderNumber
WHERE
    YEAR(shippedDate) = 2003
GROUP BY od.productCode
ORDER BY price DESC
LIMIT 5;

-- cách khác khá hay:
SELECT 
    productName, sales
FROM
    (SELECT 
        productCode, 
        ROUND(SUM(quantityOrdered * priceEach)) sales
    FROM
        orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE
        YEAR(shippedDate) = 2003
    GROUP BY productCode
    ORDER BY sales DESC
    LIMIT 5) top5products2003
INNER JOIN
    products USING (productCode);

-- bài tập hay:
/*
A more complex MySQL derived table example
Suppose you have to classify the customers in the year of 2003 into 
3 groups: platinum, gold, and silver. In addition, you need to know the number of customers 
in each group with the following conditions:

Platinum customers who have orders with the volume greater than 100K
Gold customers who have orders with the volume between 10K and 100K
Silver customers who have orders with the volume less than 10K

To construct this query, first, you need to put each customer into the respective group using 
CASE expression and GROUP BY clause as follows:
*/
SELECT 
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
    END) customerGroup
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY customerNumber;

SELECT 
    customerGroup, 
    COUNT(cg.customerGroup) AS groupCount
FROM
    (SELECT 
        customerNumber,
            ROUND(SUM(quantityOrdered * priceEach)) sales,
            (CASE
                WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
                WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
                WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
            END) customerGroup
    FROM
        orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE
        YEAR(shippedDate) = 2003
    GROUP BY customerNumber) cg
GROUP BY cg.customerGroup;    

# MySQL EXIST
/*
The EXISTS operator is used to test for the existence of any record in a subquery.
The EXISTS operator returns true if the subquery returns one or more records.
--
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);
--
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products 
WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);
*/
-- example 74:
/*
Suppose you want to find the customer who has placed at least one sales order
*/
SELECT 
    customerNumber, customerName
FROM
    customers
WHERE
    EXISTS( SELECT  # => u can use "NOT EXISTS"
            1
        FROM
            orders
        WHERE
            orders.customerNumber = customers.customerNumber);

-- example 75: MySQL UPDATE EXISTS example
SELECT 
    employeeNumber, lastName, firstName, extension
FROM
    employees
WHERE
    EXISTS( SELECT 
            1
        FROM
            offices
        WHERE
            employees.officeCode = offices.officeCode);

-- lệnh update này chưa được
UPDATE employees 
SET 
    extension = concat(extension, '5')
WHERE
    EXISTS( SELECT 
            1
        FROM
            offices
        WHERE
            city = 'San Francisco'
                AND offices.officeCode = employees.officeCode);

-- insert table
CREATE TABLE customers_archive LIKE customers;

INSERT INTO customers_archive
SELECT * FROM customers
WHERE NOT EXISTS( SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customernumber);

SELECT 
    *
FROM
    customers_archive;

-- delete table
DELETE FROM customers 
WHERE
    EXISTS( SELECT 
        1
    FROM
        customers_archive a
    
    WHERE
        a.customernumber = customers.customerNumber);

-- MySQL EXISTS vs. IN
-- To find the customer who has placed at least one sales order, you can use the IN operator as follows:
SELECT 
    customerNumber, customerName
FROM
    customers
WHERE
    customerNumber IN (SELECT 
            customerNumber
        FROM
            orders);

/* So sánh việc dùng toán tử (exists vs in)
-The query that uses the EXISTS operator is much faster than the one that uses the IN operator.
-The reason is that the EXISTS operator works based on the “at least found” principle. It returns true 
and stops scanning table once at least one matching row found.
-On the other hands, when the IN operator is combined with a subquery, MySQL must process the subquery
first and then uses the result of the subquery to process the whole query.
-The general rule of thumb is that if the subquery contains a large volume of data, the EXISTS operator 
provides better performance.
-However, the query that uses the IN operator will perform faster if the result set returned from 
the subquery is very small.

# MySQL UNION => tạm dừng ở đây, khi nào học tiếp. để thời gian ôn tập tư duy java vs frontend, oop, cấu trúc dữ liệu và giải thuật



