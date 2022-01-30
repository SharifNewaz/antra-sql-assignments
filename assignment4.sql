-- 1) Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
CREATE VIEW view_product_order_newaz AS
SELECT p.ProductName, SUM(od.Quantity) AS "Total Quantity"
FROM products p
JOIN [order details] od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName

go
SELECT * FROM view_product_order_newaz;

--2) Create a stored procedure “sp_product_order_quantity_[your_last_name]” 
-- that accept product id as an input and total quantities of order as output parameter.
go

CREATE PROCEDURE sp_product_order_quantity_sharif @ProductId INT 
AS
SELECT p.ProductID AS "ProductID", SUM(od.Quantity) AS "Total Quantity"
FROM products p
join [order details] od
ON p.ProductID = od.ProductID
WHERE p.ProductID = @ProductId
GROUP BY p.ProductID
go

EXEC sp_product_order_quantity_sharif @ProductId = 23

--3) Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities 
--   that ordered most that product combined with the total quantity of that product ordered from that city as output.
GO

CREATE PROCEDURE sp_product_order_city_sharif @ProductName VARCHAR(30)
As
SELECT top 5 o.ShipCity, SUM(od.Quantity) AS "Total Quantity"
FROM Orders o 
JOIN  [Order Details] od
on od.OrderID = o.OrderID
JOIN Products p 
ON p.ProductID = od.ProductID
WHERE ProductName = @ProductName
GROUP BY o.ShipCity
ORDER BY SUM(od.Quantity) DESC
go
EXEC sp_product_order_city_sharif @ProductName = 'chang'
go


-- 3) Create 2 new tables “people_your_last_name” “city_your_last_name”. 
--    City table has two records: 
--     {Id:1, City: Seattle}, 
--     {Id:2, City: Green Bay}. 

--    People has three records: 
--    {id:1, Name: Aaron Rodgers, City: 2}, 
--    {id:2, Name: Russell Wilson, City:1}, 
--    {Id: 3, Name: Jody Nelson, City:2}. 

--    Remove city of Seattle. 

--    If there was anyone from Seattle, put them into a new city “Madison”. 
--    Create a view “Packers_your_name” lists all people from Green Bay. 
--    If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.

GO

CREATE DATABASE TEST
USE TEST

CREATE TABLE city_sharif (
    Id INT PRIMARY KEY , 
    City VARCHAR(50) NOT NULL,
)

CREATE TABLE people_sharif(
    Id INT,
    Name VARCHAR(50) NOT NULL,
    City INT,
    FOREIGN KEY (City) REFERENCES city_sharif(id)   
)

INSERT INTO city_sharif  VALUES 
                    (1,'Seattle'),
                    (2,'Green Bay')

INSERT INTO people_sharif VALUES
                    (1,'Aaron Rodgers', 2),
                    (2,'Russell Wilson', 1),
                    (3,'Jody Nelson', 2)
GO
select * from city_sharif
select * from people_sharif
GO

-- sql won't let you delete 'seattle' as long as 'Russell Wilson' refernces to it
-- so before we delete we need to do the following first:
-- Befoe removing we need to create the new city madison “Madison”
-- so that we can refernce 'Russell Wilson' to Madison

--INSERT NEW CITY MADISON
INSERT INTO city_sharif VALUES(3,'Madison')

-- Update the REFERNCE of Russell Wilson to Madison
UPDATE people_sharif 
SET City = 3 WHERE Name = 'Russell Wilson'

-- now that there isn't anything referncing to the 'seattle' city
-- we may delete it
DELETE FROM city_sharif 
WHERE id = 1

--    Create a view “Packers_your_name” lists all people from Green Bay. 
--    If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.

GO
CREATE VIEW Packers_Sharif_Newaz AS
SELECT p.Name AS "Names", c.City AS "City"
from people_sharif p
JOIN city_sharif c
ON p.City = c.Id
WHERE c.City = 'Green Bay'
GO

SELECT * from Packers_Sharif_Newaz
GO


--4) Create a stored procedure “sp_birthday_employees_[you_last_name]” 
--   that creates a new table “birthday_employees_your_last_name” 
--   and fill it with all employees that have a birthday on Feb.
--   (Make a screen shot) drop the table. Employee table should not be affected.

GO
CREATE PROCEDURE sp_birthday_employees_sharif AS
CREATE TABLE birthday_employees_sharif(
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(40) NOT NULL,
    BirthDay DATETIME
)

INSERT birthday_employees_sharif
SELECT e.firstName, e.LastName, e.birthdate 
FROM employees e
WHERE MONTH(CONVERT(DateTime, e.birthdate)) = 5
GO

select * from birthday_employees_sharif

