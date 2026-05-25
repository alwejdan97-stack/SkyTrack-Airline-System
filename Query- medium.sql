USE SKYTRACK
-- Part 3: Data Queries
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