
--Part 1: Insert Sample Data
INSERT INTO Airport(IATACode, Name, CitY,Country)
VALUES('JFK', 'John F. Kennedy International Airport', 'New York', 'USA'),
	('LHR', 'London Heathrow Airport', 'London', 'United Kingdom'),
	('DXB', 'Dubai International Airport', 'Dubai', 'UAE'),
	('HND', 'Tokyo Haneda Airport', 'Tokyo', 'Japan'),
	('CDG', 'Charles de Gaulle Airport', 'Paris', 'France'),
	('SYD', 'Sydney Kingsford Smith Airport', 'Sydney', 'Australia')

INSERT INTO Aircraft(RegistrationNumber, Model,Manufacturer, Capacity,yearoOfManufacture)
VALUES('N123AB', 'Boeing 737-800', 'Boeing', 189, 2020),
	('N456CD', 'Airbus A320neo', 'Airbus', 195, 2021),
	('N789EF', 'Embraer E175', 'Embraer', 88, 2019),
	('N101GH', 'Bombardier CRJ900', 'Bombardier', 90, 2020),
	('N202IJ', 'Boeing 787-9 Dreamliner', 'Boeing', 290, 2022),
	('N303KL', 'Airbus A380', 'Airbus', 525, 2018)

INSERT INTO Flight(FlightNumber,IATACode,RegistrationNumber,Departure_Datetime,ArrivalDatetime,Status)
VALUES('SK101', 'JFK', 'N123AB', '2026-06-15 08:00:00', '2026-06-15 11:30:00', 'Scheduled'),
	('SK102', 'LHR', 'N456CD', '2026-06-15 10:00:00', '2026-06-15 13:45:00', 'Scheduled'),
	('SK103', 'DXB', 'N789EF', '2026-06-16 14:00:00', '2026-06-16 18:30:00', 'Scheduled'),
	('SK104', 'HND', 'N101GH', '2026-06-14 09:00:00', '2026-06-14 12:00:00', 'Delayed'),
	('SK105', 'CDG', 'N202IJ', '2026-06-13 16:00:00', '2026-06-13 19:00:00', 'Cancelled'),
	('SK106', 'SYD', 'N303KL', '2026-05-20 22:00:00', '2026-05-21 05:30:00', 'Completed'),
	('SK107', 'FRA', 'N404MN', '2026-05-21 07:00:00', '2026-05-21 09:30:00', 'Completed'),
	('SK108', 'YYZ', 'N505OP', '2026-05-22 13:00:00', '2026-05-22 16:00:00', 'Completed')

SET IDENTITY_INSERT Passenger ON;
INSERT INTO Passenger(NationalID,FullName, PhoneNumber,Email, Nationality, DateOfBirth)
VALUES (2002, 'Emma Watson', '+442079460123', 'emma.watson@email.com', 'British', '1990-04-25'),
	(3003, 'Michael Lee', '+14165551234', 'michael.lee@email.com', 'Canadian', '1978-11-08'),
	(4004, 'Olivia Brown', '+61298765432', 'olivia.brown@email.com', 'Australian', '1995-07-12'),
	(5005, 'Rajesh Kumar', '+911123456789', 'rajesh.kumar@email.com', 'Indian', '1982-09-30'),
	(6006, 'Yuki Tanaka', '+81312345678', 'yuki.tanaka@email.com', 'Japanese', '1988-02-18'),
	(7007, 'Sophie Dubois', '+33142256789', 'sophie.dubois@email.com', 'French', '1992-06-22'),
	(8008, 'Hans Weber', '+49301234567', 'hans.weber@email.com', 'German', '1980-12-05'),
	(9009, 'Ahmed Al Mansouri', '+971501234567', 'ahmed.almansouri@email.com', 'Emirati', '1987-04-17'),
	(0010, 'Lucas Silva', '+5511987654321', 'lucas.silva@email.com', 'Brazilian', '1993-08-29')
SET IDENTITY_INSERT Passenger OFF


INSERT INTO Booking(SeatNumber,PassengerID,FlightNumber,Class, Price,BookingDate)
VALUES(14, 1001, 'SK106', 'Economy', 899.99, '2026-04-20'),
	(5, 2002, 'SK106', 'Business', 1899.99, '2026-04-21'),
	(9, 3003, 'SK107', 'Economy', 199.99, '2026-05-01'),
	(6, 4004, 'SK107', 'Business', 449.99, '2026-05-02'),
	(13,5005, 'SK108', 'Economy', 329.99, '2026-05-05'),
	(2, 6006, 'SK108', 'First', 1099.99, '2026-05-06'),
	(15,3003, 'SK102', 'Economy', 349.99, '2026-05-22'),
	(1, 4004, 'SK102', 'First', 1299.99, '2026-05-19'),
	(8, 5005, 'SK103', 'Economy', 279.99, '2026-05-23'),
	(2, 6006, 'SK103', 'Business', 649.99, '2026-05-24'),
	(10, 7007, 'SK104', 'Economy', 399.99, '2026-05-18'),
	(4, 8008, 'SK104', 'Business', 699.99, '2026-05-17'),
	(7, 9009, 'SK105', 'First', 1499.99, '2026-05-15'),
	(12, 1001, 'SK101', 'Economy', 299.99, '2026-05-20'),
	(3, 2002, 'SK101', 'Business', 599.99, '2026-05-21')

INSERT INTO CrewMember(LicenseNumber,FullName,Role)
VALUES ('PIL001', 'James Wilson', 'Pilot'),
	('PIL002', 'Sarah Johnson', 'Pilot'),
	('COP001', 'Michael Brown', 'Co-Pilot'),
	('COP002', 'Emily Davis', 'Co-Pilot'),
	('ATT001', 'David Lee', 'Flight Attendant'),
	('ATT002', 'Maria Garcia', 'Flight Attendant'),
	('ATT003', 'Robert Chen', 'Flight Attendant'),
	('ENG001', 'Thomas Anderson', 'Engineer'),
	('ENG002', 'Patricia Miller', 'Engineer')

INSERT INTO FlightCrew(FlightNumber,LicenseNumber)
VALUES('SK101', 'PIL001'),
	('SK101', 'COP001'),  
	('SK101', 'ATT001'), 
	('SK101', 'ATT002'),
	('SK101', 'ENG001'),
	('SK102', 'PIL002'), 
	('SK102', 'COP002'),
	('SK102', 'ATT003'), 
	('SK102', 'ATT001'),
	('SK102', 'ENG002'),
	('SK103', 'PIL001'), 
	('SK103', 'COP001'), 
	('SK103', 'ATT002'), 
	('SK103', 'ATT003'),
	('SK103', 'ENG001'),
	('SK104', 'PIL002'),  
	('SK104', 'COP002'), 
	('SK104', 'ATT001'), 
	('SK104', 'ENG002'), 
	('SK105', 'PIL001'),
	('SK105', 'COP001'),
	('SK105', 'ATT002'), 
	('SK105', 'ATT003'),
	('SK108', 'PIL002'),
	('SK108', 'COP002'), 
	('SK108', 'ATT001'),  
	('SK108', 'ATT002'),  
	('SK108', 'ATT003'), 
	('SK108', 'ENG002'),
	('SK106', 'PIL002'),
	('SK106', 'COP002'), 
	('SK106', 'ATT001'),
	('SK106', 'ATT002'),
	('SK105', 'ENG001'), 
	('SK106', 'ENG002'), 
	('SK107', 'PIL001'), 
	('SK107', 'COP001'),  
	('SK107', 'ATT003'), 
	('SK107', 'ENG001')
