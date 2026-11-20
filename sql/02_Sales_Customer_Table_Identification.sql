USE AdventureWorks2022;
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
    'Customer',
    'SalesOrderHeader',
    'SalesOrderDetail',
    'Product',
    'ProductSubcategory',
    'ProductCategory',
    'SalesPerson',
    'SalesTerritory'
)
ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME,
    ORDINAL_POSITION;