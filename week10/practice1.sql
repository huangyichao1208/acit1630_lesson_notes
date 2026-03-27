-- database: ./mm.db

SELECT * FROM students;

-- create a trigger to prevent inserting
-- students younger than 16
create trigger check_age
before insert on students
for each row
when new.age < 16
BEGIN
    SELECT raise (abort, 'student must be at least
    16 years old');
end;

INSERT INTO students (name, age)
values ('John', 14);

-- an after insert trigger runs
-- after a row has been inserted
create table student_log (
    log_id integer PRIMARY KEY,
    student_id integer,
    action text,
    log_time text
);
create trigger log_student_insert
after insert on students
for each row
BEGIN
    insert into student_log
    (student_id, action, log_time)
    VALUES
    (new.id, 'Student Inserted',
    datetime('now'));
end;

insert into students (name, age)
VALUES
('Alice',19),
('Bob',20);

insert into students (name, age)
VALUES
('Alice1',19);

delete from students;

-- update trigger
create trigger prevent_age_reduction
before update on students
for each row 
when new.age < old.age
begin 
    select raise (ABORT, 'age cannot be reduced');
end;

update students set age = 12
where id = 1;

-- after update 
create table delete_log (
    delete_log_id integer PRIMARY KEY,
    student_id integer,
    student_name text,
    deleted_time datetime
);
create trigger log_student_delete
after delete on students
for each row
BEGIN
    INSERT INTO delete_log(
        student_id, student_name, deleted_time
    )
    VALUES
    (old.id, old.name, datetime('now'));
end;

delete from students where id = 1;
