-- database: ./indexdatabase.db

SELECT * FROM students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    age INTEGER
);

INSERT INTO students (name, email, age) VALUES
('Alice', 'alice@example.com', 20),
('Bob', 'bob@example.com', 21),
('Charlie', 'charlie@example.com', 22),
('David', 'david@example.com', 20);

SELECT * FROM students
where email = "bob@example.com";

drop index idx_students;
create index idx_students 
on students (email);

-- whether it is used or not.
explain query plan 
select * from students
where email = 'bob@example.com';
