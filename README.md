# SkyTrack Airline System – README

## 1. Project Description

The SkyTrack Airline System is a relational database designed to manage the operations of a regional airline. The system stores and manages information related to airports, aircraft, flights, passengers, bookings, and crew members. It allows the airline to schedule flights, assign aircraft and crew, manage passenger reservations, and maintain accurate operational records.

The main objective of the system is to ensure data consistency, reduce redundancy, and support efficient airline management through a well-structured database design.

---

## 2. ERD Summary

### Entities

1. Airport

   * IATACode (PK)
   * AirportName
   * City
   * Country

2. Aircraft

   * RegistrationNumber (PK)
   * Model
   * Manufacturer
   * SeatingCapacity
   * YearOfManufacture

3. Flight

   * FlightNumber (PK)
   * DepartureDateTime
   * ArrivalDateTime
   * Status
   * RegistrationNumber (FK)
   * OriginAirportCode (FK)
   * DestinationAirportCode (FK)

4. Passenger

   * NationalID (PK)
   * FullName
   * Email
   * Phone
   * Nationality
   * DateOfBirth

5. Booking

   * BookingID (PK)
   * NationalID (FK)
   * FlightNumber (FK)
   * SeatNumber
   * Class
   * PricePaid
   * BookingDate

6. CrewMember

   * LicenseNumber (PK)
   * FullName
   * Role

7. FlightCrew

   * FlightNumber (FK)
   * LicenseNumber (FK)
   * Composite Primary Key (FlightNumber, LicenseNumber)

### Key Relationships

* One Aircraft can operate many Flights.
* One Airport can be the origin of many Flights.
* One Airport can be the destination of many Flights.
* One Passenger can have many Bookings.
* One Flight can have many Bookings.
* One Flight can have many Crew Members.
* One Crew Member can serve on many Flights.

### Design Decisions

* A separate FlightCrew table was created to resolve the many-to-many relationship between Flight and CrewMember.
* Booking was implemented as an associative entity between Passenger and Flight because it stores additional attributes such as seat number, class, price paid, and booking date.
* Origin and destination airports were stored as two separate foreign keys in the Flight table because they represent different roles of the Airport entity.

---

## 3. Mapping Decisions

### Foreign Keys Placement

1. Flight → Aircraft

   * RegistrationNumber was placed in Flight as a foreign key because each flight uses exactly one aircraft, while one aircraft can serve many flights.

2. Flight → Airport

   * OriginAirportCode and DestinationAirportCode were added as foreign keys in Flight.
   * This design clearly distinguishes departure and arrival airports.

3. Booking → Passenger

   * NationalID was added as a foreign key in Booking because one passenger may create multiple bookings.

4. Booking → Flight

   * FlightNumber was added as a foreign key in Booking because multiple passengers can book seats on the same flight.

5. FlightCrew

   * FlightNumber and LicenseNumber were added as foreign keys.
   * Together they form a composite primary key to prevent duplicate crew assignments.

---

## 4. Errors Faced During INSERT and DELETE Operations

### INSERT Errors

**Foreign Key Constraint Violation**

Example:
Attempting to insert a booking for a passenger or flight that did not exist.

Error Cause:
The referenced parent record was missing.

Solution:
Inserted parent records first (Passenger and Flight) before inserting Booking records.

---

**Duplicate Primary Key Error**

Example:
Attempting to insert an aircraft with an existing registration number.

Error Cause:
Primary key values must be unique.

Solution:
Verified existing records and generated unique identifiers before insertion.

---

### DELETE Errors

**Cannot Delete Parent Row**

Example:
Trying to delete a Flight that still had related Booking records.

Error Cause:
Foreign key dependencies existed.

Solution:
Deleted related Booking and FlightCrew records first, then deleted the Flight record.

---

## 5. Difference Between WHERE and HAVING

The WHERE clause filters rows before grouping takes place. It is used to select records that satisfy a condition before any aggregate calculations are performed.

The HAVING clause filters groups after the GROUP BY operation has been completed. It is commonly used with aggregate functions such as COUNT(), SUM(), AVG(), MIN(), and MAX().

Example:

WHERE:

```sql
SELECT *
FROM Flight
WHERE Status = 'Scheduled';
```

HAVING:

```sql
SELECT FlightNumber, COUNT(*)
FROM Booking
GROUP BY FlightNumber
HAVING COUNT(*) > 10;
```

---

## 6. Most Useful Query

The most useful query in this project was the flight occupancy report:

```sql
SELECT F.FlightNumber,
       COUNT(B.BookingID) AS TotalBookings,
       A.SeatingCapacity,
       (COUNT(B.BookingID) * 100.0 / A.SeatingCapacity) AS OccupancyRate
FROM Flight F
JOIN Aircraft A
    ON F.RegistrationNumber = A.RegistrationNumber
LEFT JOIN Booking B
    ON F.FlightNumber = B.FlightNumber
GROUP BY F.FlightNumber, A.SeatingCapacity;
```

### Why It Is Useful

This query helps airline management monitor seat utilization for each flight. It identifies underbooked and fully booked flights, which supports scheduling decisions, revenue management, and operational planning.

---

## 7. BONUS – Indexes Added and Justification

### Index on Flight(DepartureDateTime)

```sql
CREATE INDEX IX_Flight_DepartureDateTime
ON Flight(DepartureDateTime);
```

Justification:
Flights are frequently searched by departure date and time. This index improves search performance and scheduling reports.

---

### Index on Booking(FlightNumber)

```sql
CREATE INDEX IX_Booking_FlightNumber
ON Booking(FlightNumber);
```

Justification:
Booking records are commonly retrieved by flight number. This index speeds up passenger manifests and occupancy calculations.

---

### Index on Booking(NationalID)

```sql
CREATE INDEX IX_Booking_NationalID
ON Booking(NationalID);
```

Justification:
Improves performance when retrieving booking history for a specific passenger.

---

### Index on FlightCrew(FlightNumber)

```sql
CREATE INDEX IX_FlightCrew_FlightNumber
ON FlightCrew(FlightNumber);
```

Justification:
Crew assignments are frequently queried by flight number. The index improves crew scheduling and reporting performance.

---

## Conclusion

The SkyTrack Airline System successfully models the key operations of a regional airline using a normalized relational database structure. The design minimizes redundancy, enforces referential integrity through primary and foreign keys, and supports efficient querying through carefully selected indexes.
