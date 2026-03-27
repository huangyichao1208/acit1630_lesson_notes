-- database: ./viewsdatabase.db

SELECT * FROM students;
INSERT INTO students VALUES (1,'Alice',19,'Computer Science');
INSERT INTO students VALUES (2,'Bob',17,'Business');
INSERT INTO students VALUES (3,'Charlie',21,'Computer Science');

-- see only cs students
create view cs_students as 
select id, name, age
from students
where program = 'Computer Science';

select * from cs_student;
CREATE TABLE courses (
    course_id INTEGER,
    course_name TEXT,
    credits INTEGER
);
INSERT INTO courses VALUES (1,'Databases',3);
INSERT INTO courses VALUES (2,'Networking',4);
INSERT INTO courses VALUES (3,'Programming',5);

CREATE TABLE departments (
    dept_id INTEGER,
    dept_name TEXT
);

CREATE TABLE employees (
    emp_id INTEGER,
    emp_name TEXT,
    dept_id INTEGER
);
INSERT INTO departments VALUES (1,'HR');
INSERT INTO departments VALUES (2,'IT');

INSERT INTO employees VALUES (101,'John',1);
INSERT INTO employees VALUES (102,'Sarah',2);
INSERT INTO employees VALUES (103,'Mike',2);

create table course_cost
(
    credits integer, 
    tuition_fee integer
);

insert into course_cost VALUES 
(1,600), 
(2,800),
(3,1200);

create view employee_department AS
SELECT
    emp_name, dept_name
from employees e
join departments d
on e.dept_id = d.dept_id;

select * from employee_department;

-- does not work for view table
insert into cs_students
values (4,'David', 20);

-- show the names of the viewed table
select name 
from sqlite_master
where type = 'view';
