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
-- cast() function converts ListPrice to decimal number where you can have a decimal number with a maximal total precision of 5 digits(since I put 5), and 2 represents the numbers you see after the decimal
-- REPLACE(number, '.', ',') replaces . to , in a number 
SELECT Top (6) Name, REPLACE(cast(ListPrice as decimal(5,2)), '.',',') AS 'ListPrice'
    FROM Production.Product
    WHERE Name LIKE 'S%' AND ListPrice IN (0.00, 53.9900)
    ORDER BY Name ASC

-- 12) Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
--     products name should start with either 'A' or 'S'
SELECT TOP (5) Name, REPLACE(cast(ListPrice as decimal(5,2)), '.',',') AS 'ListPrice'
    FROM Production.Product
    WHERE Name LIKE '[A|S]%'
    ORDER BY Name ASC

-- 13) Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. 
--     Order the result set by the Name column.
SELECT Name
    FROM Production.Product
    WHERE name LIKE 'SPO[^K]%'
    ORDER BY Name

-- 14) Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
SELECT DISTINCT Color 
    FROM Production.Product
    WHERE Color IS NOT NULL
    ORDER BY Color DESC

-- 15) Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. 
--     Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
SELECT DISTINCT ProductSubcategoryID,  Color
    FROM Production.Product
    WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL
    ORDER BY ProductSubcategoryID ASC
    