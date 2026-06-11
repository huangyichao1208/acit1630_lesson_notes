
-- string functions

-- length
-- returns the total number of the strings

select length ('Database');
select length ('Hello world!');

-- returns the number of bytes in a string
select octet_length('Hello');

select length('café');
select octet_length('café')

-- database: /Users/roger/Documents/1630/acit1630_lesson_notes/week12/test.db

SELECT * FROM students;

select length ('Database');
select length ('Hello world!');

-- returns the number of bytes in a string
select octet_length('Hello');

select length('café');
select octet_length('café');

SELECT trim('***hello***', '*');

select replace('  na me ', ' ', '');

SELECT concat_ws('-', 'SQLite', 'Views', 'Triggers');

SELECT abs(-44);
SELECT ceil(7.11);
SELECT round(98.7644, 2);
SELECT trunc(12.99);
SELECT sign(-0.5);
SELECT pi();
SELECT sqrt(144);
SELECT pow(3, 4);
SELECT exp(1);
SELECT ln(20);
SELECT log(100);

SELECT printf('Student: %s, Mark: %d', 'Raj', 95);

select unicode ('A');
select hex ('ABC');

SELECT unhex('414243');

select char (65,66,67);

SELECT like('l%', 'hello');

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);

INSERT INTO students (name, email) VALUES
('  Alice Johnson  ', 'ALICE@EXAMPLE.COM'),
('Bob Smith', 'bob.smith@example.com');

SELECT trim(name) FROM students;
SELECT lower(email) FROM students;
SELECT substr(name, 1, 3) FROM students;
SELECT instr(email, '@') FROM students;
SELECT replace(email, 'example.com', 'bcit.ca') FROM students;
SELECT upper(name) FROM students;
SELECT length(name), octet_length(name) FROM students;