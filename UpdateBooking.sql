DELIMITER //
CREATE PROCEDURE UpdateBooking (IN BookID INT, IN BookDate DATE)
BEGIN
DECLARE BookingCheck INT;

SELECT COUNT(BookingID) INTO BookingCheck FROM Bookings 
WHERE BookingID = BookID;

IF BookingCheck = 1 THEN
UPDATE Bookings SET BookingDate = BookDate WHERE BookingID = BookID;
SELECT CONCAT('Booking ', BookID, ' updated.') AS "Confirmation";
COMMIT;
ELSE
SELECT CONCAT('Booking ', BookID, ' updation is not successful.')  AS "Confirmation";
END IF;

END//
DELIMITER ;

CALL UpdateBooking(9, '2022-12-17');


