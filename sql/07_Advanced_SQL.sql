-- Project 4: Advanced SQL Analysis
-- Query 1: Monthly Sales with Running Total

USE AdventureWorks2022;
GO

WITH MonthlySales AS
(
    SELECT
        YEAR(H.OrderDate) AS Order_Year,
        MONTH(H.OrderDate) AS Order_Month,
        SUM(D.OrderQty * D.UnitPrice) AS Monthly_Sales
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        YEAR(H.OrderDate),
        MONTH(H.OrderDate)
)
SELECT
    Order_Year,
    Order_Month,
    Monthly_Sales,
    SUM(Monthly_Sales) OVER (
        ORDER BY Order_Year, Order_Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Running_Total_Sales
FROM MonthlySales
ORDER BY
    Order_Year,
    Order_Month;

    -- Query 2: Customer Sales Ranking by Tier

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
CustomerTier AS
(
    SELECT
        CustomerID,
        Total_Sales,
        CASE
            WHEN Total_Sales >= 10000 THEN 'High Value'
            WHEN Total_Sales >= 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Tier
    FROM CustomerSales
)
SELECT
    CustomerID,
    Customer_Tier,
    Total_Sales,
    DENSE_RANK() OVER (
        PARTITION BY Customer_Tier
        ORDER BY Total_Sales DESC
    ) AS Tier_Rank
FROM CustomerTier
ORDER BY
    Customer_Tier,
    Tier_Rank;

    -- Query 3: Product Ranking within Category

USE AdventureWorks2022;
GO

WITH ProductSales AS
(
    SELECT
        PC.Name AS Product_Category,
        P.ProductID,
        P.Name AS Product_Name,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderDetail AS D
    INNER JOIN Production.Product AS P
        ON D.ProductID = P.ProductID
    INNER JOIN Production.ProductSubcategory AS PSC
        ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
    INNER JOIN Production.ProductCategory AS PC
        ON PSC.ProductCategoryID = PC.ProductCategoryID
    GROUP BY
        PC.Name,
        P.ProductID,
        P.Name
)
SELECT
    Product_Category,
    ProductID,
    Product_Name,
    Total_Sales,
    DENSE_RANK() OVER (
        PARTITION BY Product_Category
        ORDER BY Total_Sales DESC
    ) AS Category_Rank
FROM ProductSales
ORDER BY
    Product_Category,
    Category_Rank;

    -- Query 4: Year-over-Year Sales Growth

USE AdventureWorks2022;
GO

WITH YearlySales AS
(
    SELECT
        YEAR(H.OrderDate) AS Order_Year,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderHeader AS H
    INNER JOIN Sales.SalesOrderDetail AS D
        ON H.SalesOrderID = D.SalesOrderID
    GROUP BY
        YEAR(H.OrderDate)
),
YearlyComparison AS
(
    SELECT
        Order_Year,
        Total_Sales,
        LAG(Total_Sales) OVER (
            ORDER BY Order_Year
        ) AS Previous_Year_Sales
    FROM YearlySales
)
SELECT
    Order_Year,
    Total_Sales,
    Previous_Year_Sales,
    Total_Sales - Previous_Year_Sales AS Sales_Change,
    CASE
        WHEN Previous_Year_Sales IS NULL THEN NULL
        ELSE
            ((Total_Sales - Previous_Year_Sales)
            / Previous_Year_Sales) * 100
    END AS YoY_Growth_Percent
FROM YearlyComparison
ORDER BY
    Order_Year;

    -- Query 5: Customer Order Sequence

USE AdventureWorks2022;
GO

SELECT
    H.CustomerID,
    H.SalesOrderID,
    H.OrderDate,
    ROW_NUMBER() OVER (
        PARTITION BY H.CustomerID
        ORDER BY H.OrderDate, H.SalesOrderID
    ) AS Customer_Order_Number
FROM Sales.SalesOrderHeader AS H
ORDER BY
    H.CustomerID,
    Customer_Order_Number;

    -- Query 6: Top Products Contribution

USE AdventureWorks2022;
GO

WITH ProductSales AS
(
    SELECT
        P.ProductID,
        P.Name AS Product_Name,
        SUM(D.OrderQty * D.UnitPrice) AS Total_Sales
    FROM Sales.SalesOrderDetail AS D
    INNER JOIN Production.Product AS P
        ON D.ProductID = P.ProductID
    GROUP BY
        P.ProductID,
        P.Name
),
ProductMetrics AS
(
    SELECT
        ProductID,
        Product_Name,
        Total_Sales,
        DENSE_RANK() OVER (
            ORDER BY Total_Sales DESC
        ) AS Sales_Rank,
        SUM(Total_Sales) OVER () AS Overall_Sales,
        SUM(Total_Sales) OVER (
            ORDER BY Total_Sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Running_Sales
    FROM ProductSales
)
SELECT TOP 20
    ProductID,
    Product_Name,
    Total_Sales,
    Sales_Rank,
    (Total_Sales / Overall_Sales) * 100 AS Sales_Contribution_Percent,
    (Running_Sales / Overall_Sales) * 100 AS Cumulative_Sales_Percent
FROM ProductMetrics
ORDER BY
    Sales_Rank;