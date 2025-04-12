CREATE VIEW OrdersView AS
SELECT OrderID, SaleQuantity AS Quantity, TotalCost AS Cost FROM Orders WHERE SaleQuantity > 2;

SELECT * FROM OrdersView;