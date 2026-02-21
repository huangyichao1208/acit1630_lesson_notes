-- database: ./schema.db

DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS passengers;

create table Passengers
(
    passenger_id integer primary key,
    name text not null,
    Email text not null unique,
    country text not null
);

create table Flights
(
    flights_id integer primary key,
    airline_name text not null,
    origin text not null,
    destination text not null,
    departure_time text not null, -- store as ISO-8601 text: 'YYYY-MM-DD HH:MM'
    price REAL not null check (price > 0)
);

create table Tickets
(
    tickets_id integer primary key,
    passenger_id integer not null,
    flights_id integer not null,
    purchase_date text not null default (CURRENT_TIMESTAMP),
    FOREIGN KEY (passenger_id) REFERENCES Passengers (passenger_id)
    on update CASCADE
    on delete CASCADE,
    FOREIGN KEY (flights_id) REFERENCES Flights (flights_id)
    on update CASCADE
    on delete CASCADE
);
insert into Passengers 
(name,email,country) VALUES
('Michael Carter','michael.carter@example.com','Canada');

insert into Flights
(airline_name,origin,destination, departure_time,price) VALUES
(
    'SkyJet Airways','Toronto (YYZ)',
    'Los Angeles (LAX)','2025-06-20 14:30', 450.00
);
-- task 4
-- 4-1 Find all flights operated by "SkyJet Airways".
select * from Flights
where airline_name = 'SkyJet Airways';

-- 4-2 Find all passengers who purchased tickets for a flight departing from "Toronto (YYZ)".
select p.name from Passengers p
join Tickets t
ON p.passenger_id = t.passenger_id
join Flights f
on t.flights_id = f.flights_id
where f.origin = 'Toronto (YYZ)';

-- 4-3 Count the total number of tickets 
-- sold for flights operated by "SkyJet Airways".
select count(*) as 'total number of tickets' 
from Tickets t
join Flights f
on t.flights_id = f.flights_id
where f.airline_name = 'SkyJet Airways';

-- 4-4 Find the most popular flight (the one 
-- with the most ticket purchases).

--非常注意！！！，where不能和聚合函数合用！！！！
SELECT a1.flights_id
from (select count(*) as total, flights_id from Tickets
group by flights_id) a1
where a1.total = max (a1.total);
-- 上面错错错！！！❌

select f.airline_name
from (select count(*) as total, flights_id from Tickets
group by flights_id) a1 join Flights f
on a1.flights_id = f.flights_id
order by a1.total desc 
LIMIT 1;

-- 另一种解法,更加清爽。
SELECT f.flights_id, f.airline_name, f.origin, f.destination, f.departure_time,
COUNT(t.tickets_id) AS tickets_sold
FROM flights f
LEFT JOIN tickets t ON t.flights_id = f.flights_id
GROUP BY f.flights_id
ORDER BY tickets_sold DESC
LIMIT 1;

-- 4-5 Find the total revenue generated from ticket sales.
select sum(price) as 'total revenue' from Flights f
join Tickets t
on f.flights_id = t.flights_id;

-- ⚠️COALESCE 让null变成了0
SELECT COALESCE(SUM(f.price), 0) AS total_revenue
FROM tickets t
JOIN flights f ON f.flights_id = t.flights_id;
