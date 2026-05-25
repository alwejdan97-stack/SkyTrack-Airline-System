CREATE DATABASE SKYTRACK
USE SKYTRACK

--  Implement the physical schemas

CREATE TABLE Airport(
IATACode VARCHAR(50) PRIMARY KEY, 
Name VARCHAR(50) NOT NULL, 
City VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL
)

CREATE TABLE Aircraft(
RegistrationNumber VARCHAR(50) PRIMARY KEY, 
Model VARCHAR(50) NOT NULL,
Manufacturer VARCHAR(50) NOT NULL, 
Capacity INT NOT NULL CHECK (Capacity>0),
yearoOfManufacture INT
)

CREATE TABLE Flight(
FlightNumber VARCHAR(50) PRIMARY KEY, 
IATACode VARCHAR(50) NOT NULL,
RegistrationNumber VARCHAR(50) NOT NULL,
--SeatNumber VARCHAR(50) NOT NULL,
Departure_Datetime DATETIME NOT NULL,
ArrivalDatetime DATETIME NOT NULL,
Status VARCHAR(50) NOT NULL DEFAULT 'Scheduled' CHECK (Status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),
CONSTRAINT CHK_Flight_Time CHECK (ArrivalDatetime > Departure_Datetime),
FOREIGN KEY(IATACode) REFERENCES Airport(IATACode) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(RegistrationNumber) REFERENCES Aircraft(RegistrationNumber) ON DELETE CASCADE ON UPDATE CASCADE
--FOREIGN KEY(SeatNumber) REFERENCES Booking(SeatNumber) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Passenger(
NationalID INT PRIMARY KEY IDENTITY,
FullName VARCHAR(50) NOT NULL, 
PhoneNumber VARCHAR(50),
Email VARCHAR(50) NOT NULL UNIQUE, 
Nationality VARCHAR(50) NOT NULL, 
DateOfBirth DATETIME NOT NULL
)

CREATE TABLE Booking(
SeatNumber INT IDENTITY(1,1) PRIMARY KEY,
PassengerID INT NOT NULL UNIQUE,
FlightNumber VARCHAR(50) NOT NULL UNIQUE,
Class VARCHAR(50) NOT NULL CHECK (Class IN('Economy', 'Business', 'First')), 
Price DECIMAL NOT NULL CHECK (Price>0),
BookingDate DATETIME NOT NULL,
FOREIGN KEY(PassengerID) REFERENCES Passenger(NationalID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(FlightNumber) REFERENCES Flight(FlightNumber) ON DELETE CASCADE ON UPDATE CASCADE,
)

CREATE TABLE CrewMember(
LicenseNumber VARCHAR(50) PRIMARY KEY,
FullName VARCHAR(50) NOT NULL,
Role VARCHAR(50) NOT NULL CHECK(Role IN( 'Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer'))
)

CREATE TABLE FlightCrew(
FlightNumber VARCHAR(50) NOT NULL UNIQUE,
LicenseNumber VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(FlightNumber,LicenseNumber),
FOREIGN KEY(FlightNumber) REFERENCES Flight(FlightNumber) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(LicenseNumber) REFERENCES CrewMember(LicenseNumber) ON DELETE CASCADE ON UPDATE CASCADE,
)

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

-- Part 2: UPDATE and DELETE
UPDATE Flight
SET Status='Completed'
WHERE FlightNumber='SK107' AND Status='Scheduled'

UPDATE Flight
SET Status='Cancelled'
WHERE FlightNumber='SK104' AND Status='Delayed'

UPDATE Booking
SET Price = Price * 1.10
WHERE CLASS='Economy'

UPDATE Passenger
SET PhoneNumber='+61298775432'
WHERE NationalID=4004

UPDATE CrewMember
SET Role='Co-Pilot'
WHERE LicenseNumber='PIL002' AND FullName='Sarah Johnson'

--1:
SELECT FlightNumber,Departure_Datetime,ArrivalDatetime,Status
FROM Flight
WHERE Status='Cancelled'

SELECT FlightNumber
FROM FlightCrew
WHERE FlightNumber='SK105'
DELETE FROM FlightCrew WHERE FlightNumber='SK105'

SELECT SeatNumber
FROM Booking
WHERE FlightNumber='SK105'
DELETE FROM Booking WHERE FlightNumber='SK105'

DELETE FROM Flight
WHERE FlightNumber='SK105' AND Status='Cancelled'

-- 2:
SELECT SeatNumber
FROM Booking
WHERE FlightNumber IN (SELECT Status FROM Flight WHERE Status='Cancelled')

DELETE FROM Booking WHERE FlightNumber IN (SELECT Status FROM Flight WHERE Status='Cancelled')

-- 3:
SELECT * FROM Passenger

DELETE FROM Passenger
WHERE NationalID=2002

SELECT SeatNumber
FROM Booking
WHERE PassengerID=2002
DELETE FROM Booking WHERE PassengerID=2002

DELETE FROM Passenger
WHERE NationalID=2002
-- NOTE: can't delete the passenger immediatley, because national id is foreign key in booking table, so first need to delete it from booking tables and then delete it from passenger table

-- Part 3: Data Queries
-- Basic Level
SELECT FlightNumber, Status, Departure_Datetime 
FROM Flight 
ORDER BY Departure_Datetime ASC

SELECT NationalID, FullName, Email, Nationality 
FROM Passenger 
ORDER BY FullName ASC

SELECT RegistrationNumber, Model, Capacity 
FROM Aircraft 
ORDER BY Capacity DESC;

SELECT DISTINCT Class 
FROM Booking;

SELECT FlightNumber, Status, Departure_Datetime, ArrivalDatetime 
FROM Flight 
WHERE Status IN ('Delayed', 'Cancelled')

SELECT NationalID, FullName, Email, Nationality, DateOfBirth 
FROM Passenger 
WHERE Nationality = 'Omani'

SELECT IATACode, Name, City, Country 
FROM Airport 
ORDER BY Country ASC

-- Medium Level
SELECT FlightNumber, ORIGIN.Name AS OriginAirport, DESTINATION.Name AS DestinationAirport 
FROM Flight F JOIN Airport ORIGIN 
ON F.IATACode = ORIGIN.IATACode 
JOIN Airport DESTINATION
ON F.IATACode = DESTINATION.IATACode

SELECT SeatNumber, FullName, FlightNumber 
FROM Booking B , Passenger P
WHERE B.PassengerID = P.NationalID

SELECT FullName, Role 
FROM FlightCrew F JOIN CrewMember C
ON F.LicenseNumber = C.LicenseNumber 
WHERE F.FlightNumber = 'SK101'

SELECT FlightNumber, Status, Model 
FROM Flight F JOIN Aircraft A 
ON F.RegistrationNumber = A.RegistrationNumber 
WHERE F.Status = 'Completed'

SELECT P.FullName, COUNT(B.SeatNumber) AS TotalBookings 
FROM Passenger P LEFT OUTER JOIN Booking B 
ON P.NationalID = B.PassengerID 
GROUP BY P.FullName 
ORDER BY TotalBookings DESC


SELECT Class, SUM(Price) AS TotalRevenue 
FROM Booking 
GROUP BY Class

SELECT A.RegistrationNumber, A.Model, COUNT(F.FlightNumber) AS FlightCount 
FROM Aircraft A LEFT OUTER JOIN Flight F
ON A.RegistrationNumber = F.RegistrationNumber
GROUP BY A.RegistrationNumber, A.Model

SELECT FlightNumber, COUNT(SeatNumber) AS BookingCount 
FROM Booking 
GROUP BY FlightNumber
HAVING COUNT(SeatNumber) > 1

SELECT P.FullName, B.FlightNumber, ORIGIN.Name AS OriginAirport, DESTINATION.Name AS DestinationAirport, B.Class, B.Price 
FROM Booking B 
JOIN Passenger P 
ON B.PassengerID = P.NationalID 
JOIN Flight F 
ON B.FlightNumber = F.FlightNumber 
JOIN Airport ORIGIN 
ON F.IATACode = ORIGIN.IATACode 
JOIN Airport DESTINATION 
ON F.IATACode = DESTINATION.IATACode

-- Advanced Level
SELECT F.FlightNumber, ORIGIN.Name AS OriginAirport, DESTINATION.Name AS DestinationAirport, A.Model, COUNT(B.SeatNumber) AS TotalPassengers 
FROM Flight F 
JOIN Airport ORIGIN 
ON F.IATACode = ORIGIN.IATACode 
JOIN Airport DESTINATION 
ON F.IATACode = DESTINATION.IATACode 
JOIN Aircraft A
ON F.RegistrationNumber = A.RegistrationNumber 
LEFT JOIN Booking B 
ON F.FlightNumber = B.FlightNumber 
GROUP BY F.FlightNumber, ORIGIN.Name, DESTINATION.Name, A.Model

SELECT NationalID, FullName, Email, Nationality 
FROM Passenger P LEFT OUTER JOIN Booking B 
ON P.NationalID = B.PassengerID 
WHERE B.SeatNumber IS NULL

SELECT F.FlightNumber, SUM(B.Price) AS TotalRevenue 
FROM Flight F JOIN Booking B 
ON F.FlightNumber = b.FlightNumber 
GROUP BY F.FlightNumber 
HAVING SUM(B.Price) > 500 
ORDER BY TotalRevenue DESC

SELECT C.FullName, COUNT(F.FlightNumber) AS TotalFlights 
FROM CrewMember C JOIN FlightCrew F 
ON C.LicenseNumber = F.LicenseNumber 
GROUP BY C.FullName 
HAVING COUNT(F.FlightNumber) > 1

SELECT f.FlightNumber, AVG(b.Price) AS AvgPrice 
FROM Flight f JOIN Booking b 
ON f.FlightNumber = b.FlightNumber 
GROUP BY f.FlightNumber 
HAVING AVG(b.Price) > (SELECT AVG(Price) FROM Booking);

SELECT TOP 1 F.FlightNumber, ORIGIN.Name AS ORIGIN, Destination.Name AS Destination, COUNT(B.SeatNumber) AS TotalBookings 
FROM Flight F 
JOIN Airport ORIGIN 
ON F.IATACode = ORIGIN.IATACode 
JOIN Airport Destination
ON F.IATACode = Destination.IATACode 
JOIN Booking B 
ON F.FlightNumber = B.FlightNumber 
GROUP BY F.FlightNumber, ORIGIN.Name, Destination.Name 
ORDER BY TotalBookings DESC

SELECT Class, SUM(Price) AS TotalRevenue, COUNT(SeatNumber) AS NumberOfBookings, AVG(Price) AS AveragePrice, MAX(Price) AS HighestPrice, MIN(Price) AS LowestPrice 
FROM Booking 
GROUP BY Class

SELECT P.FullName, B.FlightNumber, B.BookingDate 
FROM Passenger P JOIN Booking B 
ON P.NationalID = B.PassengerID 
WHERE B.FlightNumber IN (SELECT FlightNumber FROM Flight WHERE Status = 'Cancelled')

SELECT F.FlightNumber, COUNT(DISTINCT FC.LicenseNumber) AS TotalCrew, F.Departure_Datetime 
FROM Flight F 
JOIN FlightCrew FC ON F.FlightNumber =FC.FlightNumber 
JOIN CrewMember C ON FC.LicenseNumber = C.LicenseNumber 
WHERE C.Role = 'Pilot' AND EXISTS (SELECT 1 FROM FlightCrew FC1 JOIN CrewMember C1 
									ON FC1.LicenseNumber = C1.LicenseNumber 
									WHERE FC1.FlightNumber = F.FlightNumber AND C1.Role = 'Flight Attendant') 
GROUP BY F.FlightNumber, F.Departure_Datetime

SELECT F.FlightNumber, ORIGIN.City AS OriginCity, Destination.City AS DestinationCity, A.Model, A.Manufacturer, COUNT(DISTINCT B.SeatNumber) AS TotalPassengers, COUNT(DISTINCT FC.LicenseNumber) AS TotalCrew, SUM(B.Price) AS TotalRevenue 
FROM Flight F 
JOIN Airport ORIGIN ON F.IATACode = ORIGIN.IATACode 
JOIN Airport Destination ON F.IATACode = Destination.IATACode 
JOIN Aircraft A ON F.RegistrationNumber = A.RegistrationNumber 
LEFT JOIN Booking B ON F.FlightNumber = B.FlightNumber 
LEFT JOIN FlightCrew FC ON F.FlightNumber = FC.FlightNumber 
GROUP BY F.FlightNumber, ORIGIN.City, Destination.City, A.Model, A.Manufacturer 
ORDER BY TotalRevenue DESC