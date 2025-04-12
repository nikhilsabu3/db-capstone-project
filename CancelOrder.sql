DELIMITER //
CREATE PROCEDURE CancelOrder (IN id INT)
BEGIN
DECLARE ConfirmID INT;
IF NOT(id = ANY(SELECT OrderID FROM Orders)) THEN 
SELECT CONCAT('Order ', id, ' is not found') AS Confirmation;
ELSE
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Orders WHERE OrderID = id;
COMMIT;
SELECT OrderID INTO ConfirmID FROM Orders WHERE OrderID = id;
SELECT CASE WHEN ConfirmID IS NULL THEN CONCAT('Order ', id, ' is cancelled')
ELSE CONCAT('Order ', id, ' is not cancelled') END AS Confirmation;
SET SQL_SAFE_UPDATES = 1;
END IF;
END //
DELIMITER ;

INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`, `MenuID`) 
VALUES ('5', '2021-06-23', 5, 222.75, 1, 43.70, 5.5, 1);

CALL CancelOrder(5);



