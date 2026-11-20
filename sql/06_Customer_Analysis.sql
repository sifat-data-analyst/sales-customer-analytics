-- Project 4: Customer Analysis
-- Query 1: Customer Sales Performance

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

    -- Query 2: Repeat vs One-Time Customers

USE AdventureWorks2022;
GO

SELECT
    Customer_Type,
    COUNT(*) AS Customer_Count
FROM
(
    SELECT
        H.CustomerID,
        CASE
            WHEN COUNT(DISTINCT H.SalesOrderID) > 1
                THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS Customer_Type
    FROM Sales.SalesOrderHeader AS H
    GROUP BY
        H.CustomerID
) AS CustomerSummary
GROUP BY
    Customer_Type
ORDER BY
    Customer_Count DESC;

    -- Query 3: Customer Purchase Frequency

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS Total_Customers,
    AVG(Total_Orders * 1.0) AS Avg_Orders_Per_Customer,
    MIN(Total_Orders) AS Min_Orders,
    MAX(Total_Orders) AS Max_Orders
FROM
(
    SELECT
        CustomerID,
        COUNT(DISTINCT SalesOrderID) AS Total_Orders
    FROM Sales.SalesOrderHeader
    GROUP BY
        CustomerID
) AS CustomerOrders;

-- Query 4: Customer Sales Ranking

USE AdventureWorks2022;
GO

SELECT
    CustomerID,
    Total_Sales,
    DENSE_RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM
(
    SELECT
        H.CustomerID,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        H.CustomerID
) AS CustomerSales
ORDER BY
    Sales_Rank;

    -- Query 5: Customer Sales Contribution

USE AdventureWorks2022;
GO

WITH CustomerSales AS
(
    SELECT
        H.CustomerID,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        H.CustomerID
),
OverallSales AS
(
    SELECT
        SUM(Total_Sales) AS Overall_Total_Sales
    FROM CustomerSales
)
SELECT TOP 10
    C.CustomerID,
    C.Total_Sales,
    O.Overall_Total_Sales,
    (C.Total_Sales / O.Overall_Total_Sales) * 100 AS Sales_Contribution_Percent
FROM CustomerSales AS C
CROSS JOIN OverallSales AS O
ORDER BY
    C.Total_Sales DESC;

    -- Query 6: Customer Segmentation

USE AdventureWorks2022;
GO

SELECT
    Customer_Segment,
    COUNT(*) AS Customer_Count,
    SUM(Total_Sales) AS Segment_Total_Sales,
    AVG(Total_Sales) AS Avg_Sales_Per_Customer
FROM
(
    SELECT
        H.CustomerID,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales,
        CASE
            WHEN SUM(D.OrderQty * D.UnitPrice) >= 10000
                THEN 'High Value'
            WHEN SUM(D.OrderQty * D.UnitPrice) >= 5000
                THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        H.CustomerID
) AS CustomerSummary
GROUP BY
    Customer_Segment
ORDER BY
    Segment_Total_Sales DESC;