USE SKYTRACK
-- Part 3: Data Queries
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