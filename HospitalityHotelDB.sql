CREATE DATABASE HospitalityHotelDb
USE HospitalityHotelDb

CREATE TABLE StateMaster (
    StateID INT PRIMARY KEY,
    StateName VARCHAR(50)
);

INSERT INTO StateMaster (StateID, StateName) VALUES
(101, 'Lagos'),
(102, 'Abuja'),
(103, 'Kano'),
(104, 'Delta'),
(105, 'Ido'),
(106, 'Ibadan'),
(107, 'Enugu'),
(108, 'Kaduna'),
(109, 'Ogun'),
(110, 'Anambra');

CREATE TABLE Room (
    RoomID VARCHAR(10) PRIMARY KEY,
    RoomType VARCHAR(50),
    Price DECIMAL(10, 2),
    Status VARCHAR(20)
);

INSERT INTO Room (RoomID, RoomType, Price, Status) VALUES
('R01', 'Single', 100, 'Booked'),
('R02', 'Double', 200, 'Booked'),
('R03', 'Suite', 500, 'Booked'),
('R04', 'Deluxe', 300, 'Booked'),
('R05', 'Single', 100, 'Booked'),
('R06', 'Double', 200, 'Booked'),
('R07', 'Suite', 500, 'Booked'),
('R08', 'Deluxe', 300, 'Booked'),
('R09', 'Single', 100, 'Booked'),
('R10', 'Suite', 500, 'Booked');

CREATE TABLE Booking (
    BookingID VARCHAR(10) PRIMARY KEY,
    GuestID VARCHAR(10),
    RoomID VARCHAR(10),
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10, 2)
);

INSERT INTO Booking (BookingID, GuestID, RoomID, CheckInDate, CheckOutDate, TotalAmount) VALUES
('B01', 'G01', 'R01', '2024-08-01', '2024-08-05', 400),
('B02', 'G02', 'R02', '2024-08-02', '2024-08-07', 1000),
('B03', 'G03', 'R03', '2024-08-03', '2024-08-08', 2500),
('B04', 'G04', 'R04', '2024-08-04', '2024-08-09', 1500),
('B05', 'G05', 'R05', '2024-08-05', '2024-08-10', 500),
('B06', 'G06', 'R06', '2024-08-06', '2024-08-11', 1000),
('B07', 'G07', 'R07', '2024-08-07', '2024-08-12', 2500),
('B08', 'G08', 'R08', '2024-08-08', '2024-08-13', 1500),
('B09', 'G09', 'R09', '2024-08-09', '2024-08-14', 500),
('B10', 'G10', 'R10', '2024-08-10', '2024-08-15', 2500);

------------- (1)
SELECT G1.GuestID, G1.GuestName, G1.CheckInDate, G1.CheckOutDate
FROM GuestMaster G1
JOIN GuestMaster G2 
ON DATEDIFF(DAY, G1.CheckInDate, G1.CheckOutDate) = DATEDIFF(DAY, G2.CheckInDate, G2.CheckOutDate)
AND G1.GuestID != G2.GuestID
ORDER BY G1.CheckInDate;

------------------- (2) 
SELECT B.BookingID, B.TotalAmount, G.GuestName
FROM Booking B
JOIN GuestMaster G ON B.GuestID = G.GuestID
ORDER BY B.TotalAmount DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROW ONLY;

----------------------- (3)
SELECT R.RoomType, MAX(R.Price) AS MaxPrice, G.GuestName
FROM Room R
JOIN GuestMaster G ON R.RoomID = G.RoomID
GROUP BY R.RoomType, G.GuestName;

------------------- (4) 
SELECT R.RoomType, COUNT(G.GuestID) AS GuestCount
FROM Room R
JOIN GuestMaster G ON R.RoomID = G.RoomID
GROUP BY R.RoomType
ORDER BY GuestCount DESC;

------------------- (5)
SELECT LEFT(G.GuestName, CHARINDEX(' ', G.GuestName) - 1) AS FirstName, 
       SUM(B.TotalAmount) AS TotalAmountSpent
FROM GuestMaster G
JOIN Booking B ON G.GuestID = B.GuestID
GROUP BY LEFT(G.GuestName, CHARINDEX(' ', G.GuestName) - 1);

-------------------- (6)
SELECT * 
FROM Booking 
WHERE TotalAmount % 2 != 0;

------------------- (7)
CREATE VIEW ExpensiveBookings AS
SELECT B.BookingID, B.GuestID, B.RoomID, B.CheckInDate, B.CheckOutDate, B.TotalAmount
FROM Booking B
WHERE B.TotalAmount > 1000;

SELECT * FROM ExpensiveBookings

--------------------- (8)
CREATE PROCEDURE UpdateRoomPrices
AS
BEGIN
    UPDATE R
    SET R.Price = R.Price * 1.10
    FROM Room R
    JOIN GuestMaster G ON R.RoomID = G.RoomID
    JOIN StateMaster S ON G.StateID = S.StateID
    WHERE R.RoomType = 'Suite' AND S.StateName != 'Lagos';
END;

------------------------- (9)
CREATE PROCEDURE FetchBookingDetails
AS
BEGIN
    BEGIN TRY
        SELECT B.BookingID, G.GuestName, R.RoomType, R.Price, S.StateName, B.CheckInDate, B.CheckOutDate, B.TotalAmount
        FROM Booking B
        JOIN GuestMaster G ON B.GuestID = G.GuestID
        JOIN Room R ON B.RoomID = R.RoomID
        JOIN StateMaster S ON G.StateID = S.StateID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;

EXEC FetchBookingDetails







