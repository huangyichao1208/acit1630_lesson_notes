-- database: ./schema.db

insert into Passengers 
(name,email,country) VALUES
('Michael Carter','michael.carter@example.com','Canada');

insert into Flights
(airline_name,origin,destination, departure_time,price) VALUES
(
    'SkyJet Airways','Toronto (YYZ)',
    'Los Angeles (LAX)','2025-06-20 14:30', 450.00
);

delete from Flights
where flights_id = 2;

update Passengers set 
Email = 'emma.brown@newdomain.com.'
where name = 'Emma Brown';

