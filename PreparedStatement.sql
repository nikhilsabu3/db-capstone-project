PREPARE GetOrderDetail FROM 'SELECT OrderID, SaleQuantity AS Quantity, TotalCost AS Cost 
FROM Orders JOIN Bookings ON Orders.BookingID = Bookings.BookingID
WHERE Bookings.CustomerID = ?';

SET @id = '65-353-0657';
EXECUTE GetOrderDetail USING @id; 