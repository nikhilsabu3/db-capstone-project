DELIMITER //
CREATE PROCEDURE CancelBooking (IN BookID INT)
BEGIN
DECLARE BookingCheck INT;

SELECT COUNT(BookingID) INTO BookingCheck FROM Bookings 
WHERE BookingID = BookID;

IF BookingCheck = 1 THEN
DELETE FROM Bookings WHERE BookingID = BookID;
SELECT CONCAT('Booking ', BookID, ' cancelled.') AS "Confirmation";
COMMIT;
ELSEIF BookingCheck = 0 THEN
SELECT CONCAT('Unable to find Booking ', BookID, '.')  AS "Confirmation";
ELSE
SELECT CONCAT('Booking ', BookID, 'already cancelled.') AS "Confirmation";
END IF;

END//
DELIMITER ;

CALL CancelBooking(9);
