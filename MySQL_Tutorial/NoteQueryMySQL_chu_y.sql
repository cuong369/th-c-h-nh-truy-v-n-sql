# Một số câu truy vấn hay cần lưu ý.
use classicmodels;

-- example 10
SELECT 
    COUNT(DISTINCT state) as 'Count about state'
FROM
    customers
WHERE
    country = 'USA';

# Some A WebPage Good. You need note is: http://www.mysqltutorial.org/mysql-copy-table-data.aspx
/* Phím tắt được sử dụng trong mysql: https://dev.mysql.com/doc/workbench/en/wb-keys.html 
(Ctrl + B: Format Code) <=> Modifier + B 
(Ctrl + Enter: Complie Code) <=> Modifier + Enter
*/

# Các thao tác cơ bản với mysql: https://letrantrunghieu.wordpress.com/2016/06/07/cac-thao-tac-co-ban-voi-mysql-workbench/

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

-- example 17: Sắp xếp theo trường status. 

/*The ORDER BY  clause enables you to define your own custom sort order for the values in a column 
using the FIELD()  function.
You can use the FIELD function to map those values to a list of numeric values and use the numbers 
for sorting; See the following query:*/

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

# Sự khác nhau giữa mệnh đề where và having: là 
/*
+)where được sử dụng để so sánh check, ... không được sử dụng các hàm (max, min, avg, ...) trong mệnh đề where
+)Còn having ta có thể sử dụng các hàm (max, min, avg, ...). Nó đi kèm với group by để ràng buộc 1 điều kiện 
nào đấy lên một nhóm tập hợp của 1 trường
*/

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

 -- example 36
 /*
Using MySQL LIKE with underscore( _ ) wildcard examples
To find employees whose first names start with  T , end with m, and contain any single character 
between e.g., Tom , Tim, you use the underscore (_) wildcard to construct the pattern as follows:
 */
 SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstname LIKE 'T_m';
 -- example 37
 /*
 MySQL LIKE operator with ESCAPE clause
Sometimes the pattern, which you want to match, contains wildcard character e.g., 10%, _20, etc. 
In this case, you can use the ESCAPE clause to specify the escape character so that MySQL will 
interpret the wildcard character as a literal character. If you don’t specify the escape character 
explicitly, the backslash character \ is the default escape character.
 */
/*
For example, if you want to find products whose product codes contain string _20 , 
you can use the pattern %\_20% as shown in the following query:
*/
SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';

-- example 40 -- return 5 customers have creditlimit DESC
SELECT 
    customernumber, customername, creditlimit
FROM
    customers
ORDER BY creditlimit DESC
LIMIT 5;

-- example 41 
/*
Using MySQL LIMIT to get the nth highest value
One of the toughest questions in MySQL is to select the nth highest values in a result set e.g., select 
the second (or nth) most expensive product, which you cannot use MAX or MIN functions to answer. 
However, you can use MySQL LIMIT to answer those kinds of questions.

First, sort the result set in descending order.
Second, use the LIMIT clause to get the nth most expensive product.
SELECT 
    select_list
FROM
    table
ORDER BY sort_expression DESC
LIMIT nth-1, count;
*/
SELECT
 productName,
 buyprice
FROM
 products
ORDER BY
 buyprice DESC
LIMIT 1, 1;

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

# MySQL_ALIAS
-- example 46:
SELECT 
    concat_ws(', ', lastName, firstname) as 'FullName'
FROM
    employees;

-- example 47:
select concat(lastName, '---', firstName) as 'hello'
from employees;

-- example 48:
SELECT 
    orderNumber 'Order No',
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
GROUP BY 'Order No'
HAVING total > 60000;

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

# MySql-SelfJoin: là join chính nó. có thể sử dụng inner join, left-right Join ngay chính bảng đó. 
# xem các ví dụ tại địa chỉ sau: http://www.mysqltutorial.org/mysql-cross-join/

# Mysql_group by: this example is return total number rows of status for each group by status
-- example 1:
SELECT 
    status, COUNT(*) 'Count' # <=> COUNT(status)
FROM
    orders
GROUP BY status;

# => chú ý rằng khi ta thực hiện: group by một cái gì đó thì trên biểu thức SELECT, những thành phần đứng 
# sau thành phần được nhóm sẽ tính toán theo, phụ thuộc theo thành phần được nhóm. ví dụ ở đây: khi ta 
# tiến hành gom nhóm (status) thì hàm COUNT(*) sẽ thực hiện phép đếm cho phạm vi từng nhóm (Staus) riêng 
# được nhóm bởi thằng GROUP BY. chứ không thực hiện đếm tất cả những gì có trong bảng (orders). Tương tự hàm 
# SUM, AVG, ... sẽ thực hiện tính toán trong phạm vi thành phần được gom nhóm bởi (GROUP BY). 

-- example 2:
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

-- example 67: The GROUP BY clause: MySQL vs. standard SQL
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status DESC;

-- example 68: Create Table New Way!!! Note, Note, Note
# Dưới đây là cách tạo bảng. câu lệnh select theo sau sẽ là 1 tập hợp các cột được lọc ra từ những bảng 
# khác nhau (orders, products, ...) và đồng thời ta không cần định nghĩa kiểu dữ liệu và giá trị cho nó nữa 
CREATE TABLE sales SELECT productLine,
    YEAR(orderDate) orderyear,
    quantityOrdered * priceEach ordervalue FROM
    orderdetails
        JOIN
    orders ON orderdetails.orderNumber = orders.orderNumber
        JOIN
    products ON orderdetails.productCode = products.productCode
GROUP BY productLine , orderyear;

# Mysql-subquery
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);

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

-- Một cách tạo bảng và chèn dữ liệu mới:
CREATE TABLE customers_archive LIKE customers;

INSERT INTO customers_archive
SELECT * FROM customers
WHERE NOT EXISTS( SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customernumber);

-- một cách xóa dữ liệu mới
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
*/