-----print menu------

SELECT FirstName,LastName,Email
FROM customers
ORDER BY LastName ASC;

-------created a tables for rsvp's-------
CREATE TABLE anneversary_rsvp(
	"CustomerID" INT,
	"PartySize" INT)

-------------CREATE THREE MENUS----------------------
----ALL ITEMS IN DISHES---
SELECT * FROM Dishes
ORDER BY Price;
---------APPETIZER/BEVERAGE MENU------
SELECT * FROM Dishes
WHERE Type = "Beverage" or Type = "Appetizer"
ORDER BY Type
-------full menu EXCEPT beverages-----
SELECT * FROM Dishes
WHERE Type != "Beverage"
ORDER BY Type


-------Sign a customer up for your loyalty program-------------
INSERT INTO Customers
	(FirstName, LastName, Email, Address, City, State, Phone, Birthday)
	VALUES
	("Anna","Smith","asmith@kinetecoinc.com","479 Lapis Dr.", "Memphis", "TN","(555) 555-1212","1973-07-21");
	
	SELECT * FROM Customers
	ORDER BY CustomerID DESC;

-----------search a customer then added a new address they recently moved too-------
SELECT * FROM Customers
WHERE FirstName = "Talyor" or LastName = "Jenkins";

UPDATE Customers
SET Address = "74 Pine St.", City = "New York", State = "NY"
WHERE CustomerID = 26

-------Remove a customers record------------
SELECT * FROM Customers
WHERE CustomerID = 4;

DELETE FROM Customers
WHERE CustomerID = 4;

------log customers response--------
INSERT INTO anneversary_rsvp 
(CustomerID,PartySize)
VALUES
((SELECT CustomerID FROM Customers
	WHERE Email = "atapley2j@kinetecoinc.com"), 4)

SELECT * FROM anneversary_rsvp

--------look up reservations--------
SELECT TB1.CustomerID, TB2.FirstName, TB2.LastName, TB1.Date, TB1.PartySize
FROM Reservations AS TB1
INNER JOIN Customers AS TB2
ON TB1.CustomerID = TB2.CustomerID
WHERE LastName LIKE 'STE%' AND PartySize = 4;

------take reservation------
SELECT * FROM Reservations

INSERT INTO Customers
(FirstName, LastName, Email, Phone)
VALUES ("Sam","McAdams","smac@rouxacademy.com","(555)555-1212");

INSERT INTO Reservations
(CustomerID,Date,PartySize)
VALUES
((SELECT CustomerID FROM Customers
WHERE Email = "smac@rouxacademy.com"),"2020-07-14 18:00:00", 5);

SELECT * FROM Reservations
WHERE Date = "2020-07-14 18:00:00"

---------take a delivery order------------
SELECT CustomerID 
FROM Customers
WHERE FirstName = "Loretta" AND LastName = "Hundey"

SELECT DishID
FROM Dishes
WHERE NAME = "Mini Cheeseburgers" or Name = "House Salad" or Name = "Tropical Blue Smoothie" 

INSERT INTO Orders
(CustomerID, OrderDate)
VALUES
((SELECT CustomerID 
FROM Customers
WHERE FirstName = "Loretta" AND LastName = "Hundey"), "2021-11-07 13:21:00")

SELECT * 
FROM Orders
WHERE CustomerID="70"
ORDER BY OrderDate DESC;

INSERT INTO OrdersDishes (OrderID, DishID) VALUES
	("1001", (SELECT DishID FROM Dishes 
		WHERE Name="House Salad")),
	("1001", (SELECT DishID FROM Dishes 
		WHERE Name="Mini Cheeseburgers")),
	("1001", (SELECT DishID FROM Dishes 
		WHERE Name="Tropical Blue Smoothie"));

SELECT * FROM  Dishes 
INNER JOIN OrdersDishes
ON Dishes.DishID=OrdersDishes.DishID
WHERE OrdersDishes.OrderID="1001";

SELECT SUM(Dishes.Price) 
FROM Dishes 
JOIN OrdersDishes ON
Dishes.DishID=OrdersDishes.DishID WHERE OrdersDishes.OrderID="1001";

-------track your customer's favorite dish----------
SELECT DishID
FROM Dishes
WHERE  Name = "Quinoa Salmon Salad"

SELECT FavoriteDish
FROM Customers
WHERE LastName = "Goldwater"

UPDATE Customers
SET FavoriteDish = (
SELECT DishID
FROM Dishes
WHERE  Name = "Quinoa Salmon Salad")
WHERE LastName = "Goldwater"

--------Prepare a report of your top five customers--------
SELECT COUNT(CustomerID) AS ordercount ,CustomerID
FROM Orders
GROUP BY CustomerID
ORDER BY ordercount DESC
LIMIT 5;

SELECT
	TB3.FirstName, 
	TB3.LastName, 
	TB3.Email, 
	count(TB4.CustomerID) AS ordercount
FROM Customers AS TB3
INNER JOIN Orders AS TB4
ON TB3.CustomerID = TB4.CustomerID
GROUP BY TB3.CustomerID
ORDER BY ordercount DESC
LIMIT 5;


------------------------------------
