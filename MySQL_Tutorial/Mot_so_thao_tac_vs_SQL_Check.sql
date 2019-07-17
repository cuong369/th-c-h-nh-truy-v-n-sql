create table x(
id int not null,
lastname varchar(10),
firstname varchar(33) check(length(firstname)>20),
age int,
check(age >18)
);

alter table x add constraint new_check check(length(lastname) >7);

alter table x drop new_check;