DELIMITER //
CREATE PROCEDURE AddValidBooking (IN BookDate DATE, IN TableNumber INT)
BEGIN
DECLARE BookingCheck INT;
DECLARE NewCustomerID INT;

START TRANSACTION;
SELECT MAX(CustomerID) INTO NewCustomerID FROM Customers;

INSERT INTO Bookings (BookingDate, TableNo, CustomerID) VALUES(BookDate, TableNumber, NewCustomerID);

SELECT COUNT(BookingID) INTO BookingCheck FROM Bookings WHERE BookingDate = BookDate AND TableNo = TableNumber;

IF BookingCheck = 1 THEN
SELECT CONCAT('Table ', TableNumber, ' is available for booking - booking confirmed.')AS "Booking Status";
COMMIT;
ELSE
SELECT CONCAT('Table ', TableNumber, ' is already booked - booking cancelled.')AS "Booking Status";
ROLLBACK;
END IF;

END//
DELIMITER ;

CALL AddValidBooking('2022-11-12', 3);


