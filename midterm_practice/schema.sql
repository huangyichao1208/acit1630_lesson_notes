-- database: ./schema.db
PRAGMA foreign_keys = ON; 
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

-- ⚠️Cascade！！！
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


