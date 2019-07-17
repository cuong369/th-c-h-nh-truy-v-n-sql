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