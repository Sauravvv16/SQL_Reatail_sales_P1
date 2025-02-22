create database RSA;

USE RSA;

DROP TABLE IF EXISTS RETAIL_SALES;
CREATE TABLE RETAIL_SALES
	(transactions_id INT PRIMARY KEY,	
	sale_date	DATE,
	sale_time	TIME,
	customer_id	INT,
	gender	VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantiy	INT,
	price_per_unit	FLOAT,
	cogs	FLOAT,
	total_sale FLOAT);
    
    SELECT * FROM RETAIL_SALES;

SELECT 
	COUNT(*) 
FROM RETAIL_SALES;

---- DATA CLEANING ----

SELECT * FROM RETAIL_SALES
WHERE 
	transactions_id IS NULL
    or
    sale_date IS NULL
    or
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    or
    age IS NULL
    OR
    category IS NULL
    or
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

	 SELECT * FROM RETAIL_SALES;
     
DELETE FROM RETAIL_SALES
WHERE 
	transactions_id IS NULL
    or
    sale_date IS NULL
    or
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    or
    age IS NULL
    OR
    category IS NULL
    or
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    ----  DATA EXPLORATION ----
    
   ---- 1. HOW MANY SALES WE HAVE ?----
    SELECT COUNT(*) AS "TOTAL SALES" FROM RETAIL_SALES;
    
    ---- 2. HOW MANY CUSTOMER WE HAVE ? ----
     SELECT COUNT(distinct CUSTOMER_ID) AS "TOTAL CUSTOMER" FROM RETAIL_SALES;
     
     	 SELECT * FROM RETAIL_SALES;
     
     ---- 3. HOW MANY CATEGORY WE HAVE ? ----
     SELECT distinct category FROM RETAIL_SALES;
     
     ---- DATA ANALYSIS & BUSINESS PROBLEMS ----
     
     ---- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05: ? -----
     
     SELECT *
     FROM RETAIL_SALES
     WHERE SALE_DATE = '2022-11-05';
     
     ----- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022: ----
     
     SELECT 
		*
     FROM RETAIL_SALES
     WHERE CATEGORY  = 'CLOTHING'
		AND
        DATE_FORMAT(SALE_DATE, '%Y-%m') = '2022-11'
		  AND QUANTIY >= 4;
          
----- 3. Write a SQL query to calculate the total sales (total_sale) for each category. -----

SELECT 		
	CATEGORY,
    SUM(TOTAL_SALE) AS NET_SALES,
    COUNT(*) AS 'TOTAL ORDER' 
FROM RETAIL_SALES
GROUP BY 1;

----- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.----

select 
	ROUND(avg(AGE),2) AS 'AVERAGE AGE'
from retail_sales
	where CATEGORY = 'BEAUTY';

----- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000. ----

select 
	* 
FROM RETAIL_SALES
	WHERE TOTAL_SALE > '1000'; 
    
----- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. -----

select 
	category,
    gender,
    count(*) as total_trans
from retail_Sales
Group by 
	category,
    Gender
order by 1;

----- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year -----

Select 
	extract(YEAR FROM SALE_DATE) AS YEAR,
    extract(MONTH FROM SALE_DATE) AS MONTH,
    avg(TOTAL_SALE) AS AVG_SALE
FROM 
	RETAIL_SALES
group by 1,2
ORDER BY 1;

---- 8. **Write a SQL query to find the top 5 customers based on the highest total sales ----

SELECT 
	CUSTOMER_ID,
    SUM(TOTAL_SALE) AS TOTAL_SALE
FROM RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

---- 9. Write a SQL query to find the number of unique customers who purchased items from each category. ----

SELECT 
	CATEGORY,
    COUNT(distinct CUSTOMER_ID) as Unique_customer
FROM 
	RETAIL_SALES
    GROUP BY 1
    ORDER BY 2 DESC;
    
---- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): ----

with hourly_sale
as 
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR from SALE_TIME ) >12 THEN 'Morrning'
		WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon' 
		ELSE 'Evening'
        end as 'Shift'
FROM RETAIL_SALES
) 
select 
	shift,
    COUNT(*) AS TOTAL_ORDERS
    FROM HOURLY_SALE
    group BY
    1;

-------------------------- END OF PROJECT ----------------------