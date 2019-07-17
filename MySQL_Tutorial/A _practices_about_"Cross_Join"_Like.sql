# A Practical Use of MySQL CROSS JOIN Clause
/*
There are three tables involved:

The products table contains the products master data that includes product id, product name, and sales price.
The stores table contains the stores where the products are sold.
The sales table contains the products that sold in a particular store by quantity and date.
*/
CREATE DATABASE IF NOT EXISTS testdb;
 
USE testdb;
 
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(13 , 2 )
);
 
CREATE TABLE stores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);
 
CREATE TABLE sales (
    product_id INT,
    store_id INT,
    quantity DECIMAL(13 , 2 ) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id , store_id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id)
        REFERENCES stores (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
      ('iPad',599),
      ('Macbook Pro',1299);
 
INSERT INTO stores(store_name)
VALUES('North'),
      ('South');
 
INSERT INTO sales(store_id,product_id,quantity,sales_date)
VALUES(1,1,20,'2017-01-02'),
      (1,2,15,'2017-01-05'),
      (1,3,25,'2017-01-05'),
      (2,1,30,'2017-01-02'),
      (2,2,35,'2017-01-05');

-- exercise 01
/*
To get the total sales for each store and for each product, you calculate the sales and group them 
by store and product as follows:
*/
SELECT 
    store_name, product_name, SUM(quantity * price) AS 'Values'
FROM
    products p
        JOIN
    sales s ON p.id = s.product_id
        JOIN
    stores st ON st.id = s.store_id
GROUP BY store_id , product_id;  # GROUP BY store_name , product_name; 

-- exercise 02
/*
Now, what if you want to know also which store had no sales of a specific product. 
The query above could not answer this question.
*/
SELECT 
    store_name, product_name
FROM
    stores
        CROSS JOIN
    products AS p;

SELECT 
    b.store_name,
    a.product_name,
    IFNULL(c.revenue, 0) AS revenue
FROM
    products AS a
        CROSS JOIN
    stores AS b
        LEFT JOIN
    (SELECT 
        stores.id AS store_id,
        products.id AS product_id,
        store_name,
            product_name,
            ROUND(SUM(quantity * price), 0) AS revenue
    FROM
        sales
    INNER JOIN products ON products.id = sales.product_id
    INNER JOIN stores ON stores.id = sales.store_id
    GROUP BY store_name , product_name) AS c ON c.store_id = b.id
        AND c.product_id= a.id
ORDER BY b.store_name;

# Như vậy: Store có tên: 'South' ghép với products có tên là: 'Macbook Pro' không có trong doanh thu (sales)
# vì vậy doanh thu của nó phải là : 0. 
# Có thể giải thích dễ hiểu hơn là: Sản phẩm 'Macbook Pro' không được phân phối cho cửa hàng miền Nam (South)
# nên nó không được thống kê làm doanh thu. Hay nói cách khác doanh thu của nó = 0 trong tháng 1.
