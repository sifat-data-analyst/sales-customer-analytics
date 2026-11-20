# Sales & Customer Analytics



### End-to-End Business Intelligence Project | SQL Server | Power BI | DAX



## Project Overview



This project analyzes sales performance, customer purchasing behavior, product performance, and regional sales trends using the AdventureWorks2022 sample database.



The objective is to transform relational business data into actionable insights that help decision-makers understand revenue performance, identify key products and customers, and evaluate sales trends across territories.



The project combines SQL-based analysis with an interactive Power BI dashboard to demonstrate an end-to-end business analytics workflow.



## Business Objectives



- Evaluate overall sales performance and order trends.

- Analyze annual sales performance.

- Identify high-performing sales territories.

- Understand product category and subcategory contributions.

- Identify the highest-value customers.

- Analyze customer purchasing frequency.

- Develop actionable business recommendations.



## Tools & Technologies



| Tool | Purpose |
|---|---|
| SQL Server | Data querying and analysis |
| SQL | Data profiling, validation, and business analysis |
| Power Query | Data transformation |
| Power BI | Interactive dashboard development |
| DAX | KPI calculations and time-based analysis |
| Excel | Business insights reporting |



## Key Business Metrics



| KPI | Result |
|---|---:|
| Discount-Adjusted Sales | $109.85M |
| Gross Sales | $110.37M |
| Total Orders | 31,465 |
| Average Order Value | $3,491.07 |
| Customer Records in Power BI Customer Table | 19,820 |
| Customers with Recorded Orders | 19,119 |



**Sales Metric Definitions:**

- Gross Sales = Order Quantity x Unit Price.

- Discount-Adjusted Sales = Sum of LineTotal after discounts.



The two sales figures represent different calculation methods and should not be treated as interchangeable.



## Key Business Insights



### 1. Sales Performance

- Discount-adjusted sales reached approximately $109.85 million.

- The analysis covers four calendar years, from 2011 to 2014.

- Sales performance peaked in 2013.



### 2. Territory Performance

- Southwest was the highest-performing territory, generating approximately $24.18 million.

- Germany recorded approximately $4.92 million, the lowest among the analyzed territories.



### 3. Product Performance

- Bikes generated approximately $94.65 million in sales.

- Road Bikes was the leading subcategory, contributing approximately $43.91 million.

- Mountain Bikes contributed approximately $36.45 million.



### 4. Customer Performance

- The top 10 customers generated individual sales ranging from approximately $727K to $877K.

- Most customers placed only one order.

- A smaller group of customers demonstrated repeat purchasing behavior.



### 5. Customer Order Frequency



| Customer Group | Customers |
|---|---:|
| 1 Order | 11,649 |
| 2-5 Orders | 7,133 |
| 6+ Orders | 337 |



Customer counts depend on the population being measured. The Power BI Customer table contains 19,820 records, while 19,119 customers appear in the sales order history.



## Project Structure

Repository folders:
- `sql/` - 8 SQL analysis scripts
- `powerbi/` - Power BI dashboard
- `reports/` - Business insights Excel report
- `docs/` - Documentation
- `screenshots/` - Dashboard screenshots

## Project Deliverables



### SQL Analysis

Eight SQL scripts covering:

- Database table inventory.

- Sales and customer table identification.

- Data profiling.

- Data validation.

- Core sales analysis.

- Customer analysis.

- Advanced SQL analysis.

- Final business queries.



**[Explore SQL Scripts](sql/)**



### Power BI Dashboard



Interactive dashboard containing two report pages:



1. Executive Sales Overview

2. Customer & Product Analysis



**[View / Download Power BI Dashboard](powerbi/Project_4_Sales_Customer_Analytics.pbix)**



### Business Insights Report



Excel-based business insights and recommendations.



**[View Business Insights Report](reports/Project_4_Business_Insights.xlsx)**



## Data Source



This project uses the AdventureWorks2022 sample database.



The database is used as an analytical source for demonstrating SQL querying, business intelligence, and dashboard development.



The original database backup and raw database files are not included in this repository.



Refer to Microsoft's official documentation for information about the AdventureWorks sample databases.



## Project Limitations



- The analysis is based on historical sample data from 2011-2014.

- Historical findings should not be interpreted as current market conditions.

- Customer counts differ depending on whether all customer records or customers with recorded orders are measured.

- Business recommendations are based on the observed dataset and its analytical scope.



## Conclusion



This project demonstrates how SQL Server, Power Query, Power BI, and DAX can be combined to transform business data into meaningful insights.



It provides an analytical view of sales performance, customer behavior, product contributions, and territory performance to support data-driven business decisions.






