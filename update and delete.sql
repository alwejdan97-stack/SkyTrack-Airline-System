USE SKYTRACK

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
