/*MySQL ROLLUP
Summary: in this tutorial, you will learn how to use the MySQL ROLLUP clause to generate subtotals and 
grand totals.
Setting up a sample table
The following statement creates a new table named sales that stores the order values summarized 
by product lines and years. The data comes from the products, orders, and orderDetails tables in 
the sample database.
*/
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

SELECT 
    *
FROM
    sales;

SELECT 
    SUM(orderValue) totalOrderValue
FROM
    sales;

/*
If you want to generate two or more grouping sets together in one query, you may use the UNION ALL 
operator as follows:
*/
SELECT 
    productline, SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY productline 
UNION ALL SELECT 
    NULL, SUM(orderValue) totalOrderValue
FROM
    sales;

/*
- Because the UNION ALL requires all queries to have the same number of columns, we added NULL in the 
select list of the second query to fullfil this requirement.

- The NULL in the productLine column identifies the grand total super-aggregate line.

- This query is able to generate the total order values by product lines and also the grand total row. 

- However, it has two problems:
*)The query is quite lengthy.
*)The performance of the query may not be good since the database engine has to internally execute two 
separate queries and combine the result sets into one.

- To solve those issues, you can use the ROLLUP clause.
- The ROLLUP clause is an extension of the GROUP BY clause with the following syntax:
SELECT 
    select_list
FROM 
    table_name
GROUP BY
    c1, c2, c3 WITH ROLLUP; ==> c3 sẽ có giá trị NULL sau mỗi nhóm được nhóm bởi GROUP BY
*/
-- MySQL ROLLUP overview
SELECT 
    productline, SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY productLine WITH ROLLUP; # hàng cuối cùng (productline = NULL, còn cột total sẽ tổng của tất cả 
# (orderValue) trong bảng sales. 

/*
Hiểu như sau: khi ta thực hiện group by theo 1 hoặc nhiều trường ví dụ: (GROUP BY c1, c2, c3 WITH ROLLUP)
ROLLUP giả định rằng có hệ thống phân cấp sau: c1 > c2 > c3. Và nó tạo ra các nhóm như sau:
(c1, c2, c3)-->lúc này (c1, c2 c3) đều khác null và ta thực hiện phép tính sum khi biết (c1,c2,c3) not null => tức là nhóm cả 3 thành phần c1, c2, c3 để thực hiện tính tổng theo đó 
(c1, c2)--> lúc này (c1,c2) khác null, c3=null và ta thực hiện phép tính sum với (c1,c2) khác null,c3=null => tức là chỉ nhóm 2 thành phần c1, c2 để thực hiện tính tổng theo đó 
(c1) --> lúc này c1 != null, (c2, c3) = null và ta thực hiện phép tính sum với c1 != null và (c2, c3) = null => tức là chỉ nhóm 1 thành phần c1 để thực hiện tính tổng theo đó 

() --> lúc này (c1, c2, c3) = null hết và sum = tổng các sum được tính ở trên 
sum(()) = sum((c1, c2, c3)) + sum((c1, c2)) + sum((c1)) => tức là lúc này coi như không có lệnh group by 
mà vẫn thực hiện tính tổng 

đọc tại địa chỉ sau để hiểu sâu hơn: http://www.mysqltutorial.org/mysql-rollup/
*/
-- example 01
SELECT 
    productLine, orderyear, (orderValue) totalOrderValue
FROM
    sales
GROUP BY productLine , orderyear WITH ROLLUP;

-- example 02
SELECT 
    orderYear, productLine, SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY orderYear, productLine WITH ROLLUP; 
# chú ý: thứ tự các trường được nhóm trong (GROUP BY) có ảnh hưởng đến kết quả 
# GROUP BY c1, c2, c3 => thứ tự c1, c2, c3 có ảnh hưởng đến kết quả. 

-- GROUPING() function: tạm thời đẩy nhanh tiến độ hcọ cái khác tìm hiểu sau
/*
To check whether NULL in the result set represents the subtotals or grand totals, 
you use the GROUPING() function.

The GROUPING() function returns 1 when NULL occurs in a supper-aggregate row, otherwise, it returns 0.

The GROUPING() function can be used in the select list, HAVING clause, 
and (as of MySQL 8.0.12 ) ORDER BY clause.
*/

SELECT 
    orderyear,
    productLine,
    SUM(ordervalue) totalOrderValue,
    GROUPING(orderyear),
    GROUPING(productLine)
FROM
    sales
GROUP BY orderyear , productLine WITH ROLLUP;

--
SELECT 
    IF(GROUPING(orderYear),
        'All Years',
        orderYear) orderYear,
    IF(GROUPING(productLine),
        'All Product Lines',
        productLine) productLine,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY orderYear , productline WITH ROLLUP;
