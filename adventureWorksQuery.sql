-- 1) Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.
SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product

-- 2) Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE ListPrice <> 0

-- 3) Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE Color IS NULL

-- 4) Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE Color IS NOT NULL

-- 5) Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, 
-- and the column ListPrice has a value greater than zero.
SELECT ProductID, Name, Color, ListPrice
    FROM Production.Product
    WHERE Color IS NOT NULL AND ListPrice > 0

-- 6) Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
-- I added a space in between the Name and Color
SELECT CONCAT(Name, ' ', Color)
    FROM Production.Product
    WHERE Color IS NOT NULL

-- 7) Write a query that generates the following result set  from Production.Product:
--    NAME: LL Crankarm  --  COLOR: Black
--    NAME: ML Crankarm  --  COLOR: Black
--    NAME: HL Crankarm  --  COLOR: Black
--    NAME: Chainring Bolts  --  COLOR: Silver
--    NAME: Chainring Nut  --  COLOR: Silver
--    NAME: Chainring  --  COLOR: Black
SELECT TOP(6) CONCAT('NAME: ', Name, ' -- ', 'COLOR: ', Color)
    From Production.Product
    WHERE Color IN ('Black', 'Silver') 

-- 8) Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
SELECT ProductID, Name
    From Production.Product
    WHERE ProductID BETWEEN 400 AND 500

-- 9) Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
SELECT ProductID, Name, color
    FROM Production.Product
    WHERE Color IN('black','blue')

-- 10) Write a query to get a result set on products that begins with the letter S.
-- since it did not specify any column, using * to get all the column
SELECT * 
    From Production.Product
    WHERE Name Like 'S%'

-- 11) Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
SELECT Top (6) Name, ListPrice
    FROM Production.Product
    WHERE Name Like 'S%' AND ListPrice IN (0, 53.99)
    ORDER BY Name ASC