-- database: ../week12/test.db

select length ('Database');
select length ('Hello world!');

-- returns the number of bytes in a string
select octet_length('Hello');

select length('café');
select octet_length('café');

select lower('SQLITE');

select upper('sqlite');

select trim('    hello     ');

select trim ('*******hello******','*');

-- similarly, we have rtrim
select ltrim('       hello');
select ltrim('000123','0');

select substr('Sqlite',1,3);

-- replace (x,y,z)
-- replace all occurences of y in x with z
select replace ('I like cats', 'cats', 'dogs');

-- instr(x,y)
select instr ('Database Systems','base');

select concat('ACIT',' ','1630');

select concat_ws ('~','Sqlite','views','Triggers');

select format ('Student: %s, Grade: %d','Alan',95);

select printf ('Price: %.2f', 12.5);

select printf ('Price: %.2f', 12.56555);

select char (72,101,108,108,111);

select unicode ('A');

select unicode ('Zebra');

select hex('ABC');

select unhex('414243');

select 'Hello' || ' ' || 'World!';

create table students (
    name text,
    email text
);

insert into students (name, email)
values ('Alice Johnson','alice@bcit.ca'),
('Bob Smith','bob@ubc.ca');

select trim (name) from students;

select lower(email) from students;

select substr (name,1,3) from students;

select replace (email, 'ubc.ca', 'bcit.ca')
from students;

select * from students;

select abs(-25);

select ceil (4.2);

select ceiling (7.01);

select floor (4.9);

select round (4.6);

select round(4.2);

select round (4.5);

select round(12.3456,2);
select trunc(8.99);

select sign (-15), sign(0),sign(42);

select mod(17,5);

select pi();

select sqrt(81);

select sqrt(-81);

select pow(2,5);

select power(2,-3);

select exp(1);

select log2(8);

