-- Project 4: Core Sales & Customer Analysis
-- Query 1: Overall Sales Performance

USE AdventureWorks2022;
GO

SELECT
    COUNT(DISTINCT H.SalesOrderID) AS TotalOrders,
    COUNT(DISTINCT H.CustomerID) AS UniqueCustomers,
    SUM(D.OrderQty * D.UnitPrice) AS TotalSalesAmount,
    AVG(D.OrderQty * D.UnitPrice) AS AvgOrderLineValue
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID;

    -- Query 2: Sales by Year

SELECT
    YEAR(soh.OrderDate) AS Sales_Year,
    COUNT(DISTINCT soh.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT soh.CustomerID) AS Unique_Customers,
    SUM(sod.OrderQty * sod.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY
    YEAR(soh.OrderDate)
ORDER BY
    Sales_Year;

    -- Query 3: Sales by Territory

SELECT
    st.Name AS Territory,
    COUNT(DISTINCT soh.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT soh.CustomerID) AS Unique_Customers,
    SUM(sod.OrderQty * sod.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Sales.SalesTerritory AS st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY
    st.Name
ORDER BY
    Total_Sales DESC;

    -- Query 4: Sales by Product Category

USE AdventureWorks2022;
GO

SELECT
    PC.Name AS Product_Category,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
INNER JOIN Production.Product AS P
    ON D.ProductID = P.ProductID
INNER JOIN Production.ProductSubcategory AS PSC
    ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
    ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY
    PC.Name
ORDER BY
    Total_Sales DESC;

    -- Query 5: Top 10 Products by Sales

USE AdventureWorks2022;
GO

SELECT TOP 10
    P.Name AS Product_Name,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
    SUM(D.OrderQty) AS Total_Quantity_Sold,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
INNER JOIN Production.Product AS P
    ON D.ProductID = P.ProductID
GROUP BY
    P.Name
ORDER BY
    Total_Sales DESC;

    -- Query 6: Top 10 Customers by Sales

USE AdventureWorks2022;
GO

SELECT TOP 10
    H.CustomerID,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    SUM(D.OrderQty) AS Total_Quantity_Sold
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    H.CustomerID
ORDER BY
    Total_Sales DESC;

    -- Query 7: Online vs Offline Sales

USE AdventureWorks2022;
GO

SELECT
    CASE
        WHEN H.OnlineOrderFlag = 1 THEN 'Online'
        ELSE 'Offline'
    END AS Sales_Channel,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    H.OnlineOrderFlag
ORDER BY
    Total_Sales DESC;

    -- Query 8: Monthly Sales Trend

USE AdventureWorks2022;
GO

SELECT
    YEAR(H.OrderDate) AS Order_Year,
    MONTH(H.OrderDate) AS Order_Month,
    DATENAME(MONTH, H.OrderDate) AS Month_Name,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    YEAR(H.OrderDate),
    MONTH(H.OrderDate),
    DATENAME(MONTH, H.OrderDate)
ORDER BY
    Order_Year,
    Order_Month;