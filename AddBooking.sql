DELIMITER //
CREATE PROCEDURE AddBooking (IN BookID INT, IN CustomID INT, IN TableNumber INT, IN BookDate DATE)
BEGIN
DECLARE BookingCheck INT;

SELECT COUNT(BookingID) INTO BookingCheck FROM Bookings 
WHERE BookingID = BookID AND BookingDate = BookDate AND TableNo = TableNumber AND CustomerID = CustomID;

IF BookingCheck = 0 THEN
INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID) VALUES(BookID, BookDate, TableNumber, CustomID);
SELECT 'New Booking added.' AS "Confirmation";
ELSE
SELECT 'New Booking not successful.' AS "Confirmation";
END IF;

END//
DELIMITER ;

CALL AddBooking(9, 3, 4, '2022-12-30');


