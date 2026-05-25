USE SKYTRACK
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
FROM Booking

SELECT FlightNumber, Status, Departure_Datetime, ArrivalDatetime 
FROM Flight 
WHERE Status IN ('Delayed', 'Cancelled')

SELECT NationalID, FullName, Email, Nationality, DateOfBirth 
FROM Passenger 
WHERE Nationality = 'Omani'

SELECT IATACode, Name, City, Country 
FROM Airport 
ORDER BY Country ASC