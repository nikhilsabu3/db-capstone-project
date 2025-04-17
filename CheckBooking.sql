DELIMITER //
CREATE PROCEDURE CheckBooking (IN BookDate DATE, IN TableNumber INT)
BEGIN
DECLARE BookingCheck INT;

SELECT COUNT(BookingID) INTO BookingCheck FROM Bookings WHERE BookingDate = BookDate AND TableNo = TableNumber;

IF BookingCheck = 0 THEN
SELECT CONCAT('Table ', TableNumber, ' is available for booking.')AS "Booking Status";
ELSE
SELECT CONCAT('Table ', TableNumber, ' is already booked.')AS "Booking Status";
END IF;

END//
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);