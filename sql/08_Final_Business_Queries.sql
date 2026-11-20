-- Project 4: Final Business Queries
-- Query 1: Yearly Sales Performance

USE AdventureWorks2022;
GO

SELECT
    YEAR(H.OrderDate) AS Order_Year,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
    AVG(D.OrderQty * D.UnitPrice) AS Avg_Order_Line_Value
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    YEAR(H.OrderDate)
ORDER BY
    Order_Year;

    -- Query 2: Top Product Categories

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

    -- Query 3: Top Customers

USE AdventureWorks2022;
GO

SELECT TOP 10
    H.CustomerID,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    SUM(D.OrderQty) AS Total_Quantity_Sold,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    H.CustomerID
ORDER BY
    Total_Sales DESC;

    -- Query 4: Sales by Territory

USE AdventureWorks2022;
GO

SELECT
    ST.Name AS Sales_Territory,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
INNER JOIN Sales.SalesTerritory AS ST
    ON H.TerritoryID = ST.TerritoryID
GROUP BY
    ST.Name
ORDER BY
    Total_Sales DESC;

    -- Query 5: Online vs Offline Performance

USE AdventureWorks2022;
GO

SELECT
    CASE
        WHEN H.OnlineOrderFlag = 1 THEN 'Online'
        ELSE 'Offline'
    END AS Sales_Channel,
    COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
    COUNT(DISTINCT H.CustomerID) AS Unique_Customers,
    SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
    SUM(D.OrderQty * D.UnitPrice) / COUNT(DISTINCT H.SalesOrderID) AS Avg_Order_Value
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID
GROUP BY
    H.OnlineOrderFlag
ORDER BY
    Total_Sales DESC;

    -- Query 6: Customer Opportunity Analysis

USE AdventureWorks2022;
GO

WITH CustomerMetrics AS
(
    SELECT
        H.CustomerID,
        COUNT(DISTINCT H.SalesOrderID) AS Total_Orders,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        H.CustomerID
),
CustomerClassification AS
(
    SELECT
        CustomerID,
        Total_Orders,
        Total_Sales,
        CASE
            WHEN Total_Orders > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS Customer_Type,
        CASE
            WHEN Total_Sales >= 10000 THEN 'High Value'
            WHEN Total_Sales >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM CustomerMetrics
)
SELECT
    Customer_Type,
    Customer_Segment,
    COUNT(*) AS Customer_Count,
    SUM(Total_Sales) AS Segment_Total_Sales,
    AVG(Total_Sales) AS Avg_Sales_Per_Customer
FROM CustomerClassification
GROUP BY
    Customer_Type,
    Customer_Segment
ORDER BY
    Segment_Total_Sales DESC;