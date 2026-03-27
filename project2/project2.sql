-- database: ./project_2.db

PRAGMA foreign_keys = ON; 

-- create db file
-- sqlite3 project_2.db

-- create table, 9 tables in total
drop table if exists photo; 

create table if not exists photo (
    photo_id integer PRIMARY KEY,
    file_name varchar(250) not null,
    created_date datetime DEFAULT (datetime('now','localtime')),
    caption varchar(500)
);

drop table if exists person; 

create table person (
    person_id integer PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(150),
    password_hash varbinary(75) not null,
    profile_photo_id integer,
    FOREIGN KEY (profile_photo_id) REFERENCES photo (photo_id)
    on delete CASCADE
    on update cascade
);

drop table if exists post; 

create table if not exists post (
    post_id integer PRIMARY KEY,
    title varchar(250),
    descript text,
    created_date datetime DEFAULT (datetime('now','localtime')),
    last_modified_date datetime DEFAULT (datetime('now','localtime')),
    person_id integer,
    FOREIGN KEY (person_id) REFERENCES person (person_id)
    on delete CASCADE
    on update cascade
);

drop table if exists tag; 

create table if not exists tag (
    tag_id integer PRIMARY KEY,
    tag_name varchar(50) not null
);

drop table if exists post_tag; 

create table if not exists post_tag (
    post_tag_id integer PRIMARY KEY,
    post_id integer not null,
    tag_id integer,
    FOREIGN KEY (post_id) REFERENCES post (post_id)
    on delete CASCADE
    on update cascade,
    FOREIGN KEY (tag_id) REFERENCES tag (tag_id)
    on delete CASCADE
    on update cascade
);

drop table if exists post_photo; 

CREATE table if not exists post_photo (
    post_photo_id INTEGER PRIMARY KEY,
    photo_id integer,
    post_id integer not null,
    FOREIGN KEY (photo_id) REFERENCES photo (photo_id)
    on delete CASCADE
    on update cascade,
    FOREIGN KEY (post_id) REFERENCES post (post_id)
    on delete CASCADE
    on update cascade
);

drop table if exists post_like; 

create table if not exists post_like (
    post_like_id integer PRIMARY KEY,
    post_id integer not null,
    person_id integer,
    FOREIGN KEY (post_id) REFERENCES post (post_id)
    on delete CASCADE
    on update cascade,
    foreign key (person_id) REFERENCES person (person_id)
    on delete CASCADE
    on update cascade
);

drop table if exists read_post; 

create table if not exists read_post (
    read_post_id integer PRIMARY KEY,
    post_id integer not null,
    person_id integer,
    created_date datetime DEFAULT (datetime('now','localtime')),
    FOREIGN KEY (post_id) REFERENCES post (post_id)
    on delete CASCADE
    on update cascade,
    foreign key (person_id) REFERENCES person (person_id)
    on delete CASCADE
    on update cascade
);

drop table if exists post_comment; 

create table if not exists post_comment (
    post_comment_id integer PRIMARY KEY,
    comment text,
    created_date datetime DEFAULT (datetime('now','localtime')),
    post_id integer not null,
    person_id integer,
    FOREIGN KEY (post_id) REFERENCES post (post_id)
    on delete CASCADE
    on update cascade,
    foreign key (person_id) REFERENCES person (person_id)
    on delete CASCADE
    on update cascade
);

-- insert the data to these 9 tables
-- .mode csv
-- .import photo.csv photo
-- .import person.csv person
-- .import post.csv post
-- .import tag.csv tag
-- .import post_tag.csv post_tag
-- .import post_photo.csv post_photo
-- .import post_like.csv post_like
-- .import read_post.csv read_post
-- .import post_comment.csv post_comment

-- insert 'null' value to person table
insert into person
(person_id,first_name,last_name,email,password_hash)
values
(3,'Natalie','Wilhite','bestest.forever@example.com',
'$2a$12$u6UeDFpFgnBlcg2rLJN 6a.v95JU.MPCm/1RAWO1e5bV');

-- insert 'null' value to post_tag table
insert into post_tag 
(post_tag_id,post_id)
values
(6,3),
(14,8);

-- insert 'null' value to post_photo table
insert into post_photo
(post_photo_id,post_id)
values
(9,7),
(14,10),
(15,11);

-- insert 'null' value to post_like table
insert into post_like
(post_like_id,post_id)
values
(7,4),
(9,6),
(10,7),
(11,8),
(13,10),
(14,11);

-- read_post and post_comment need extra effort to insert the right data,
-- especially for the default time data.

insert into read_post 
(read_post_id,post_id)
values
(1,8);

create table read_post_temp
(
    read_post_id integer,
    post_id integer,
    person_id integer
);
-- .import read_post.csv read_post_temp

INSERT INTO read_post 
(read_post_id,post_id,person_id)
select * from read_post_temp;

insert into post_comment
(post_comment_id,post_id)
values
(1,2),
(2,5),
(3,7),
(4,8),
(5,10),
(6,11);

insert into post_comment
(post_comment_id,comment,post_id,person_id)
values
(12,'What colour are you going to paint your shed?',6,1);

create table post_comment_temp
(
    post_comment_id integer,
    comment text,
    post_id integer,
    person_id integer
);
-- .import post_comment.csv post_comment_temp

insert into post_comment
(post_comment_id,comment,post_id,person_id)
select * from post_comment_temp;

drop table post_comment_temp;
drop table read_post_temp;
-- As shown above, all the tables and data have been created and inserted.
-- Including the 'null' value as well as the default datetime value
-- Perfectly done!


-- Next is the 14 queries:
-- 1.Find all posts with tag 'DIY'.
select p.title, t.tag_name from tag t
join post_tag pt 
on pt.tag_id = t.tag_id
join post p
on p.post_id = pt.post_id
where t.tag_name = 'DIY';

-- 2.List all post tags for a certain post (the 
-- post with 'Mickey Mouse Cookies').
select p.title, t.tag_name from tag t
join post_tag pt 
on pt.tag_id = t.tag_id
join post p
on p.post_id = pt.post_id
where p.title = 'Mickey Mouse Cookies';

-- 3.Which post has the most tags? List all posts with the count 
-- of tags (sorted largest to smallest). 
select p.title, count(pt.tag_id) as 'Number of Tags'
from post_tag pt
join post p
on pt.post_id = p.post_id
group by (pt.post_id)
order by count(pt.tag_id) desc;

-- 4.Which posts have no tags?
select p.title, count(pt.tag_id) as 'Number of Tags'
from post_tag pt
join post p
on pt.post_id = p.post_id
group by (pt.post_id)
having count(pt.tag_id) = 0;

-- 5.Which tag has the most posts? Get a count of how many posts 
-- per tag (sorted largest to smallest).
select t.tag_name, count(pt.post_id) as 'Number of posts'
from post_tag pt
right join tag t
on pt.tag_id = t.tag_id
group by (t.tag_name)
order by count(pt.post_id) desc; 

-- 6.Find all the posts that have been read.
select pp.post_id, p.title, pe.first_name FROM
(select distinct(r.post_id) from 
read_post r
where person_id is not null) as pp
join post p
on pp.post_id = p.post_id
join person pe
on p.person_id = pe.person_id;

-- 7.Find all the posts that have not been read.
select rp.post_id, p.title, pe.first_name 
from read_post rp
join post p
on rp.post_id = p.post_id
join person pe
on p.person_id = pe.person_id
where rp.person_id is null;

-- 8.Find all the posts that have been edited 
-- after they were created.
select p.post_id, p.title, pe.first_name,
p.created_date,p.last_modified_date
from post p
join person pe
on p.person_id = pe.person_id
where p.last_modified_date > p.created_date;

-- 9.Find all the posts that don't have photos.
select pph.post_id, p.title, pe.first_name
from post_photo pph
join post p
on pph.post_id = p.post_id
join person pe
on p.person_id = pe.person_id
where pph.photo_id is null;

-- 10.Find the most popular posts (with the most likes). 
select p.title,count(pl.person_id) as 'Number of likes'
from post_like pl
join post p
on pl.post_id = p.post_id
group by (p.title)
order by count(pl.person_id) desc;

-- 11.Who has the most posts? Least?
select pe.first_name, pe.last_name,
count(p.post_id) as 'Number of posts'
from post p
right join person pe
on p.person_id = pe.person_id
group by (pe.first_name) 
order by count(p.post_id) desc limit 1;

select pe.first_name, pe.last_name,
count(p.post_id) as 'Number of posts'
from post p
right join person pe
on p.person_id = pe.person_id
group by (pe.first_name) 
order by count(p.post_id) limit 1;

-- 12.List all posts that have photos and 
-- all of their comments (if they have comments).
SELECT DISTINCT 
    p.post_id,
    p.title,
    author.first_name AS 'author',
    pc.comment,
    commenter.first_name AS 'commenter'
from post_photo pph
join post_comment pc
on pph.post_id = pc.post_id
JOIN post p 
     ON pc.post_id = p.post_id
left JOIN person commenter 
     ON pc.person_id = commenter.person_id
JOIN person author 
     ON p.person_id = author.person_id
where pph.photo_id is not null;

-- 13.List all posts. Include a count of the number of reads, 
-- number of likes and number of comments for each post. If a post 
-- doesn't have any reads, likes or comments, the value for this count 
-- should be zero.
select p.post_id, p.title,
(select count (rp.person_id) from read_post rp
where rp.post_id = p.post_id) as reads,
(select count (pl.person_id) from post_like pl
where pl.post_id = p.post_id) as likes,
(select count (pc.person_id) from post_comment pc
where pc.post_id = p.post_id) as comments
from post p;

-- 14.List photos as either profile photos or post photos.
select p.photo_id, p.caption, p.file_name,
(select ('Profile Photo') from person pe
where p.photo_id = pe.profile_photo_id) as type
from photo p
where type is not null
union 
select p.photo_id, p.caption, p.file_name, 
(select ('Post Photo') from person pe
where p.photo_id not in (SELECT profile_photo_id FROM person WHERE profile_photo_id IS NOT NULL)) as type
from photo p
where type is not null
order by type desc;

