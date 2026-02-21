-- database: ./schema.db

SELECT * FROM Flights;
-- task 5
-- 5-1 List all tickets with passenger name and flight details.
-- Output: ticket_id, passenger_name, airline, origin, destination, departure_time
select t.tickets_id, p.name, f.airline_name,
f.origin, f.destination, f.departure_time
from Tickets t
join Flights f
on t.flights_id = f.flights_id
join Passengers p
on t.passenger_id = p.passenger_id;

-- 5-2 List all passengers and the number of 
-- tickets they have purchased (include passengers with 0 tickets).
-- Output: passenger_id, name, total_tickets
-- Requirement: Must use a LEFT JOIN.
-- group by的个数和select中没有聚合函数的个数相同。
-- ⚠️(确定吗？？)
select p.passenger_id, p.name,count(t.tickets_id) as 'total_tickets'
from Passengers p
left join Tickets t
on p.passenger_id = t.passenger_id
group by p.passenger_id, p.name;

-- 5-3 Show all flights along with the number 
-- of tickets sold for each flight (include flights with 0 tickets).
-- Output: flight_id, airline, origin, destination, tickets_sold
-- Requirement: Must use a LEFT JOIN.
select f.flights_id, f.airline_name, f.origin,
f.destination, count(t.tickets_id) as "tickets_sold"
from Flights f
left join Tickets t
on f.flights_id = t.flights_id
group by f.flights_id;

-- 5-4 List flights that have never been booked.
-- Output: flight_id, airline, origin, destination, departure_time
-- Requirement: Use either LEFT JOIN + IS NULL OR NOT EXISTS.
select f.flights_id, f.airline_name, f.origin,
f.destination, f.departure_time
from Flights f
where not EXISTS
(
    select 1
    from Tickets t 
    where
    t.flights_id = f.flights_id
);

-- 5-5 Show total revenue generated per flight.
-- Output: flight_id, airline, total_revenue
select f.flights_id, f.airline_name, sum(f.price) as "total_revenue"
from Flights f
join Tickets t
on f.flights_id = t.flights_id
GROUP BY f.flights_id;

-- ⚠️COALESCE
SELECT
f.flights_id,
f.airline_name,
COALESCE(COUNT(t.tickets_id) * f.price, 0) AS total_revenue
FROM flights f
LEFT JOIN tickets t ON t.flights_id = f.flights_id
GROUP BY f.flights_id, f.airline_name, f.price
ORDER BY f.flights_id;

-- 5-6 Find flights that are priced above the average flight price.
-- Output: flight_id, airline, origin, destination, price
-- Requirement: Must use a scalar subquery with AVG().
select flights_id, airline_name,
origin, destination, price
from Flights
where price > (
    select avg(price) from Flights
);

-- 5-7 Find passengers who have purchased 
--tickets for more than one flight.
-- Output: passenger_id, name
-- Requirement: Use GROUP BY + HAVING OR a correlated subquery.
select p.passenger_id, p.name from Passengers p
join Tickets t
on p.passenger_id = t.passenger_id
group by p.passenger_id
having p.passenger_id >1;

-- 5-8 Find the most expensive flight(s).
-- Output: flight_id, airline, origin, destination, price
-- Requirement: Must use a subquery with MAX(price).
select flights_id,airline_name,
origin, destination, price
from Flights
where price = (select max(price) from Flights);

-- 5-9 Find passengers who have never purchased a ticket.
-- Output: passenger_id, name, email
-- Requirement: Must use NOT EXISTS.
select passenger_id,name,Email
from Passengers p
where not EXISTS
(
    SELECT 1
    from Tickets t
    where p.passenger_id = t.passenger_id
);