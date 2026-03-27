-- database: ./midterm.db

-- q1:
-- -- DEPARTMENT
-- CREATE TABLE department (
--   dept_code     INTEGER PRIMARY KEY,
--   dept_name     TEXT NOT NULL,
--   dept_budget   REAL NOT NULL,
--   dept_location TEXT NOT NULL
-- );

-- -- STAFF
-- CREATE TABLE staff (
--   staff_id            INTEGER PRIMARY KEY,
--   last_name           TEXT NOT NULL,
--   first_name          TEXT NOT NULL,
--   hire_date           TEXT NOT NULL,   -- store as 'YYYY-MM-DD'
--   dept_code           INTEGER NOT NULL,
--   years_of_experience INTEGER NOT NULL,
--   FOREIGN KEY (dept_code) REFERENCES department(dept_code)
-- );

-- -- PROJECT
-- CREATE TABLE project (
--   project_id      INTEGER PRIMARY KEY,
--   project_name    TEXT NOT NULL,
--   project_budget  REAL NOT NULL,
--   project_balance REAL NOT NULL,
--   staff_id        INTEGER NOT NULL,
--   FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
-- );

-- -- TASK ASSIGNMENT
-- CREATE TABLE task_assignment (
--   task_id            INTEGER PRIMARY KEY,
--   task_date          TEXT NOT NULL,  -- 'YYYY-MM-DD'
--   project_id         INTEGER NOT NULL,
--   staff_id           INTEGER NOT NULL,
--   task_description   TEXT NOT NULL,
--   task_cost_per_hour REAL NOT NULL,
--   task_hours         INTEGER NOT NULL,
--   total_charge       REAL NOT NULL,
--   FOREIGN KEY (project_id) REFERENCES project(project_id),
--   FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
-- );

-- q2:
-- .mode csv
-- .import department.csv department
-- .import project.csv project
-- .import staff.csv staff
-- .import task.csv task_assignment

SELECT * FROM task_assignment;
PRAGMA foreign_keys = ON;

-- q3
select staff_id,last_name,first_name 
from staff
where last_name like 'Smith%'
order by staff_id;

-- q4
select s.staff_id, s.last_name, s.first_name, p.project_id,
p.project_name, p.project_budget,p.project_balance
from staff s
join project p
on s.staff_id = p.staff_id
order by p.project_budget desc;

-- q5
select staff_id, 
sum(task_hours) as 'Total_Hours_Worked', 
sum(total_charge) as 'Total_Charges'
from task_assignment
group by staff_id
order by staff_id;

-- q6
select count(*) as 'total_tasks',
min(task_cost_per_hour) as 'smallest_task_cost_per_hour',
max(task_cost_per_hour) as 'largest_task_cost_per_hour',
avg(task_cost_per_hour) as 'average_task_cost_per_hour'
from task_assignment;

-- q7
update task_assignment
set task_cost_per_hour = task_cost_per_hour+10
where project_id in (201,202,205,208)
and task_cost_per_hour <60;

-- q8
delete from task_assignment
where task_hours < 10;

-- q9
select staff_id,task_date,
julianday('now') - julianday(task_date) as "days_since_assigned"
from task_assignment
order by task_date desc;

-- q10
-- 10a
select staff_id, last_name,first_name,years_of_experience
from staff
where years_of_experience > 
(select avg(years_of_experience) 
from staff
);

-- 10b
select s.staff_id, s.last_name, s.first_name
from staff s
where EXISTS
(
    select 1
    from task_assignment t where 
    s.staff_id = t.staff_id
    and t.task_hours >= 40
);

-- 10c
select s1.staff_id, s1.last_name, s1.first_name,
s1.dept_code, s1.years_of_experience
from staff s1
where s1.dept_code in 
(
    
    select max (s2.years_of_experience)
    from staff s2
    where s2.dept_code = s1.dept_code
);

-- this is the right answer!!
SELECT s1.staff_id, s1.last_name, s1.first_name,
       s1.dept_code, s1.years_of_experience
FROM staff s1
WHERE s1.years_of_experience = (
    SELECT MAX(s2.years_of_experience)
    FROM staff s2
    WHERE s2.dept_code = s1.dept_code
);

-- 11a
select t.staff_id 
from task_assignment t
intersect select p.staff_id
from project p;


-- 11b
select t.staff_id
from task_assignment t where t.task_hours >=30
intersect select p.staff_id
from project p;