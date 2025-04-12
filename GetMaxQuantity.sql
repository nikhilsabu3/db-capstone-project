DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(SaleQuantity) AS "Max Quantity in Order" FROM Orders;
END//
DELIMITER ;

CALL GetMaxQuantity();