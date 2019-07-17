/*
Assigning variables
Once you declared a variable, you can start using it. To assign a variable another value, you use the SET 
statement, for example:

DECLARE total_count INT DEFAULT 0;
SET total_count = 10;

The value of the total_count variable is 10  after the assignment.
Besides the SET statement, you can use the SELECT INTO statement to assign the result of a query, 
which returns a scalar value, to a variable. See the following example:

DECLARE total_products INT DEFAULT 0;
SELECT 
   COUNT(*) INTO total_products
FROM 
   products;
*/

/*
Như vậy để gán giá trị cho một biến thì ta còn có thể dùng câu lệnh select into để gán giá trị cho một biến
==> Hiểu sâu hơn về select into: thì (select x into y) được dùng để gán giá trị x cho y: hay y = x;
x ở đây có thể là 1 database cần được backup hoặc có thể là giá trị cụ thể nào đó 
xin đọc ở đây để hiểu thêm: https://www.w3schools.com/sql/sql_select_into.asp 
và ở đây: http://www.mysqltutorial.org/variables-in-stored-procedures.aspx
*/