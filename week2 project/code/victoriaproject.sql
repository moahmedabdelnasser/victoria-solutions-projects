-- KPI 1: Total revenue by product category (shows which categories generate the most sales)
SELECT 
    Product_Category, 
    SUM(Revenue) AS Total_Revenue
FROM raw_sales_data
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;

-- KPI 2: Average discount percentage by product category (helps assess pricing/discounting strategy per category)
SELECT 
    Product_Category, 
    AVG([Discount]) AS Avg_Discount
FROM raw_sales_data
GROUP BY Product_Category;

-- KPI 3: Monthly revenue trend (shows seasonal or time-based revenue fluctuations)
SELECT 
    FORMAT(Order_Date, 'yyyy-MM') AS Month, 
    SUM(Revenue) AS Monthly_Revenue
FROM raw_sales_data
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;

-- KPI 4: Customers receiving above-average discounts (identifies customers benefiting from higher-than-normal discounts)
SELECT 
    Customer_Name, 
    AVG([Discount]) AS Avg_Discount
FROM raw_sales_data
GROUP BY Customer_Name
HAVING AVG([Discount]) > (
    SELECT AVG([Discount]) FROM raw_sales_data
);

-- KPI 5: Data quality check – counts missing or invalid email/phone records (assesses completeness of customer contact data)
SELECT 
    SUM(CASE 
            WHEN Email IS NULL OR LTRIM(RTRIM(Email)) IN ('', 'Unknown', 'unknown') 
            THEN 1 ELSE 0 
        END) AS Missing_Emails,
    SUM(CASE 
            WHEN Phone IS NULL OR LTRIM(RTRIM(Phone)) IN ('', 'Unknown', 'unknown') 
            THEN 1 ELSE 0 
        END) AS Missing_Phones
FROM raw_sales_data;
