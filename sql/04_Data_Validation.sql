-- Query 1: CustomerID and SalesOrderID NULL Validation

USE AdventureWorks2022;
GO

SELECT
    'Sales.Customer' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(*) - COUNT(CustomerID) AS NullCustomerID
FROM Sales.Customer

UNION ALL

SELECT
    'Sales.SalesOrderHeader' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(*) - COUNT(SalesOrderID) AS NullSalesOrderID
FROM Sales.SalesOrderHeader;

-- Query 2: Invalid Quantity and Price Validation

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS TotalOrderLines,
    SUM(CASE WHEN OrderQty <= 0 THEN 1 ELSE 0 END) AS InvalidOrderQty,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS InvalidUnitPrice
FROM Sales.SalesOrderDetail;

-- Query 3: Date Logic Validation

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN DueDate < OrderDate THEN 1 ELSE 0 END) AS InvalidDueDate,
    SUM(CASE WHEN ShipDate < OrderDate THEN 1 ELSE 0 END) AS InvalidShipDate
FROM Sales.SalesOrderHeader;

-- Query 4: Orphan Order Detail Validation

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS OrphanOrderLines
FROM Sales.SalesOrderDetail AS D
LEFT JOIN Sales.SalesOrderHeader AS H
    ON D.SalesOrderID = H.SalesOrderID
WHERE H.SalesOrderID IS NULL;

-- Query 5: Customer Relationship Validation

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS OrphanCustomerOrders
FROM Sales.SalesOrderHeader AS H
LEFT JOIN Sales.Customer AS C
    ON H.CustomerID = C.CustomerID
WHERE C.CustomerID IS NULL;

-- Query 6: Overall Data Validation Summary

USE AdventureWorks2022;
GO

SELECT
    'Customer ID NULL Check' AS ValidationCheck,
    COUNT(*) - COUNT(CustomerID) AS IssueCount
FROM Sales.Customer

UNION ALL

SELECT
    'Sales Order ID NULL Check',
    COUNT(*) - COUNT(SalesOrderID)
FROM Sales.SalesOrderHeader

UNION ALL

SELECT
    'Invalid Order Quantity',
    SUM(CASE WHEN OrderQty <= 0 THEN 1 ELSE 0 END)
FROM Sales.SalesOrderDetail

UNION ALL

SELECT
    'Invalid Unit Price',
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END)
FROM Sales.SalesOrderDetail

UNION ALL

SELECT
    'Invalid Due Date',
    SUM(CASE WHEN DueDate < OrderDate THEN 1 ELSE 0 END)
FROM Sales.SalesOrderHeader

UNION ALL

SELECT
    'Invalid Ship Date',
    SUM(CASE WHEN ShipDate < OrderDate THEN 1 ELSE 0 END)
FROM Sales.SalesOrderHeader

UNION ALL

SELECT
    'Orphan Order Details',
    COUNT(*)
FROM Sales.SalesOrderDetail AS D
LEFT JOIN Sales.SalesOrderHeader AS H
    ON D.SalesOrderID = H.SalesOrderID
WHERE H.SalesOrderID IS NULL

UNION ALL

SELECT
    'Orphan Customer Orders',
    COUNT(*)
FROM Sales.SalesOrderHeader AS H
LEFT JOIN Sales.Customer AS C
    ON H.CustomerID = C.CustomerID
WHERE C.CustomerID IS NULL;