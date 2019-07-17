# Mysql procedure. Học sơ qua để ôn, sẽ thực hành kỹ chuyên sâu 
# sau.
DELIMITER //
 CREATE PROCEDURE GetAllProducts()
   BEGIN
   SELECT *  FROM products;
   END //
 DELIMITER ;
 
 call GetAllProducts();

DELIMITER //
create procedure hi()
	begin
		DECLARE total_products INT DEFAULT 0; # Do đây là biến cục bộ nên chỉ khai báo trong khối (begin-end) của 1 procedure thôi. 
        # khai báo ngoài nó sẽ báo lỗi 
		SELECT 
		   COUNT(*) INTO total_products
		FROM 
		   products;
	end //
delimiter ; 

-- The IN parameter example
delimiter //
create procedure GetOfficeByCountry(in countryName varchar(255))
begin
select * from offices where country = countryName;
end //
delimiter ;

call GetOfficeByCountry('USA');

-- The OUT parameter example
delimiter $$
create procedure CountOrderByStatus(in orderStatus varchar(255), out total int)
begin
select count(orderNumber) into total from orders where status = orderStatus;
end $$
delimiter ;

CALL CountOrderByStatus('Shipped',@total);
SELECT @total;

-- test with out once
set @x = 2;
delimiter $$
create procedure testWithOut1(in total int)
begin
select * from employees limit total;
end $$
delimiter ;

call testWithOut1(@x);
select @x;

-- test with out second
set @x = 2;
delimiter $$
create procedure testWithOut2(in total int)
begin
set @x = total;
end $$
delimiter ;

call testWithOut2(3);
select @x;

-- inout
DELIMITER $$
CREATE PROCEDURE set_counter(INOUT count INT(4),IN inc INT(4))
BEGIN
 SET count = count + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL set_counter(@counter,1); -- 2
CALL set_counter(@counter,1); -- 3
CALL set_counter(@counter,5); -- 8
CALL set_counter(@counter, @counter); -- 16
SELECT @counter; -- 8

