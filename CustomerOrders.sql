SELECT Customers.CustomerID, Customers.CustomerName AS FullName, 
Orders.OrderID, Orders.TotalCost AS Cost, Menus.MenuName, MenuItems.CourseName, MenuItems.StarterName
FROM Customers JOIN Bookings ON Customers.CustomerID = Bookings.CustomerID
JOIN Orders ON Orders.BookingID = Bookings.BookingID
JOIN Menus ON Menus.MenuID = Orders.MenuID
JOIN MenuItems ON MenuItems.MenuItemID = Menus.MenuItemsID
WHERE Orders.TotalCost > 150
ORDER BY Cost;