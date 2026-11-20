USE AdventureWorks2022;
GO

SELECT 'Sales.Customer' AS Table_Name, COUNT(*) AS Row_Count
FROM Sales.Customer

UNION ALL

SELECT 'Sales.SalesOrderHeader', COUNT(*)
FROM Sales.SalesOrderHeader

UNION ALL

SELECT 'Sales.SalesOrderDetail', COUNT(*)
FROM Sales.SalesOrderDetail

UNION ALL

SELECT 'Production.Product', COUNT(*)
FROM Production.Product

UNION ALL

SELECT 'Production.ProductSubcategory', COUNT(*)
FROM Production.ProductSubcategory

UNION ALL

SELECT 'Production.ProductCategory', COUNT(*)
FROM Production.ProductCategory

UNION ALL

SELECT 'Sales.SalesPerson', COUNT(*)
FROM Sales.SalesPerson

UNION ALL

SELECT 'Sales.SalesTerritory', COUNT(*)
FROM Sales.SalesTerritory;

-- Query 2: NULL / Missing Value Check

SELECT
    'Sales.Customer' AS Table_Name,
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN PersonID IS NULL THEN 1 ELSE 0 END) AS PersonID_NULLs,
    SUM(CASE WHEN StoreID IS NULL THEN 1 ELSE 0 END) AS StoreID_NULLs,
    SUM(CASE WHEN TerritoryID IS NULL THEN 1 ELSE 0 END) AS TerritoryID_NULLs
FROM Sales.Customer

UNION ALL

SELECT
    'Sales.SalesOrderHeader',
    COUNT(*),
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN SalesPersonID IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN TerritoryID IS NULL THEN 1 ELSE 0 END)
FROM Sales.SalesOrderHeader;

-- Query 3: Duplicate / Unique Key Check

USE AdventureWorks2022;
GO

SELECT
    'Sales.Customer' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT CustomerID) AS UniqueCustomerID
FROM Sales.Customer

UNION ALL

SELECT
    'Sales.SalesOrderHeader' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT SalesOrderID) AS UniqueSalesOrderID
FROM Sales.SalesOrderHeader;

-- Query 4: Data Range Validation

USE AdventureWorks2022;
GO

SELECT
    MIN(OrderQty) AS MinOrderQty,
    MAX(OrderQty) AS MaxOrderQty,
    MIN(UnitPrice) AS MinUnitPrice,
    MAX(UnitPrice) AS MaxUnitPrice
FROM Sales.SalesOrderDetail;

-- Query 5: Important Categorical Value Distribution

USE AdventureWorks2022;
GO

SELECT
    OnlineOrderFlag,
    COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY OnlineOrderFlag
ORDER BY OnlineOrderFlag;

-- Query 6: Sales Value Profiling

USE AdventureWorks2022;
GO

SELECT
    COUNT(*) AS TotalOrderLines,
    SUM(OrderQty * UnitPrice) AS TotalSalesAmount,
    AVG(OrderQty * UnitPrice) AS AvgOrderLineValue,
    MIN(OrderQty * UnitPrice) AS MinOrderLineValue,
    MAX(OrderQty * UnitPrice) AS MaxOrderLineValue
FROM Sales.SalesOrderDetail;




























































































































