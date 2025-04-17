INSERT INTO Bookings(BookingID, BookingDate, TableNo, CustomerID) VALUES
(1,	'2022-10-10',	5,	1),
(2,	'2022-11-12',	3,	3),
(3,	'2022-10-11',	2,	2),
(4,	'2022-10-13',	2,	1);

SELECT BookingID, BookingDate, TableNo, CustomerID FROM Bookings WHERE BookingID IN (1, 2, 3, 4);