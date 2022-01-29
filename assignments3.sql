-- List all cities that have both Employees and Customers.
SELECT * FROM Employees --9
SELECT * FROM Customers --91

SELECT e.city from Employees e WHERE e.EmployeeID IS NOT NULL
UNION
SELECT c.city from Customers c WHERE c.CustomerID IS NOT NULL

-- List all cities that have Customers but no Employee.
-- a.      Use sub-query
Select DISTINCT City
From customers c
Where c.City IN (select City from Employees e Where e.City IS NULL)

-- b.      Do not use sub-query
SELECT c.city from Customers c WHERE c.CustomerID IS NOT NULL
UNION
SELECT e.city from Employees e WHERE e.EmployeeID IS NULL


-- List all products and their total order quantities throughout all orders.
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers --91
SELECT * FROM [Order Details]

SELECT p.productName, dt.totalQuantities
FROM
(
    SELEct od.ProductID, sum(od.Quantity)  AS "totalQuantities"
    FROM [Order Details] od
    GROUP BY od.ProductID
) dt 
LEFT JOIN Products p
ON p.ProductID  = dt.ProductID

-- List all Customer Cities and total products ordered by that city.
-- SELECT * FROM Products
SELECT  OrderID, CustomerID FROM Orders
SELECT  OrderID, Quantity FROM [Order Details]
SELECT  CustomerID,City FROM Customers --91

SELECT distinct City FROM Customers --69

SELECT c.city, sum([total product ordered])
FROM
(
    SELECT o.CustomerID, sum(od.Quantity)  AS [total product ordered]
    FROM Orders o
    JOIN [Order Details] od
    ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
) dt 
JOIN Customers c
ON c.CustomerID  = dt.CustomerID
GROUP BY c.city


-- List all Customer Cities that have at least two customers.
SELECT c.CustomerID, c.City FROM Customers c

-- a. Use union
SELECT c.City, sum(1) as "Total Customers"
FROM Customers c
GROUP BY c.City
HAVING sum(1) = 2
UNION 
SELECT c.City, sum(1) as "Total customer"
FROM Customers c
GROUP BY c.City
HAVING sum(1) > 2
ORDER BY c.City

-- b. Use sub-query and no union
SELECT dt.city, sum(dt."Total Customers")
FROM
(
    SELECT c.City, sum(1) as "Total Customers"
    FROM Customers c
    GROUP BY c.City
) dt 
GROUP BY dt.City
HAVING sum(dt."Total Customers") >= 2
ORDER BY dt.City

-- List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.CustomerID, c.City FROM Customers c Where c.CustomerID = 'dracd'
SELECT o.CustomerID, o.ShipCity from orders o Where o.CustomerID = 'dracd' ORDER by o.CustomerID 

SELECT* FROM [Order Details]

SELECT c.CustomerID, c.City FROM Customers c 

-- List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT distinct c.ContactName, c.CustomerID
FROM Customers c
left JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity

-- List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

SELECT top 5 p.ProductName, avg(od.Quantity) AS "avg price"
FROM Products p
JOIN [Order Details] od
on p.ProductID = od.ProductID
GROUP BY p.ProductName

SELECT top 5 c.city, sum([total product ordered]) AS "total product ordered"
FROM
(
    SELECT o.CustomerID, sum(od.Quantity)  AS [total product ordered]
    FROM Orders o
    JOIN [Order Details] od
    ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
) dt 
JOIN Customers c
ON c.CustomerID  = dt.CustomerID
GROUP BY c.city
ORDER BY sum([total product ordered]) desc

-- List all cities that have never ordered something but we have employees there.
-- a.      Use sub-query
-- b.      Do not use sub-query

SELECT distinct  ShipCity  FROM Orders
-- SELECT  * FROM [Order Details]
SELECT * FROM Customers 
SELECT * from orders

SELECT  c.city FROM Customers c WHERE c.City = 'Colchester'

SELECT  o.shipcity FROM orders o WHERE o.shipcity = 'Colchester'


SELECT distinct c.City 
FROM Customers c
WHERE c.City NOT IN(
    SELECT distinct o.shipcity  
    from Orders o 
    WHERE o.EmployeeID IS NOT NULL
)

SELECT distinct c.city 
from Customers c
left JOIN orders o
ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL AND o.EmployeeID is not null

-- List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is,
-- and also the city of most total quantity of products ordered from. (tip: join  sub-query)