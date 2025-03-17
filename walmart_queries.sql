USE walmart_sales_db;
SELECT * 
FROM walmartsalesdata;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- DATA WRANGLING ------------------------------------------------------------------------------------

-- 1. Build a database
-- 2. Create table and insert the data.
-- 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.


-- Create staging table to alter table and not raw data
CREATE TABLE walmart_sales_data_staging LIKE walmartsalesdata;
INSERT INTO walmart_sales_data_staging SELECT * FROM walmartsalesdata;


-- Make each column default to not null
CREATE TABLE `walmart_sales_data_staging` (
  `invoice_id` varchar(30) NOT NULL,
  `branch` varchar(5) NOT NULL,
  `city` varchar(30) NOT NULL,
  `customer_type` varchar(30) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `product_line` varchar(100) NOT NULL,
  `unit_price` varchar(30) NOT NULL,
  `quantity` int NOT NULL,
  `VAT` float NOT NULL,
  `total` decimal(12,4) NOT NULL,
  `date` datetime NOT NULL,
  `time` time NOT NULL,
  `payment_method` varchar(15) NOT NULL,
  `cogs` decimal(10,2) NOT NULL,
  `gross_margin_percentage` float NOT NULL,
  `gross_income` decimal(12,4) NOT NULL,
  `rating` float NOT NULL,
  `time_of_day` varchar(20) NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


ALTER TABLE walmart_sales_data_staging
CHANGE `Date` date DATETIME NOT NULL,
CHANGE `Time` time TIME NOT NULL,
CHANGE `Payment` payment_method VARCHAR(15) NOT NULL,
CHANGE `cogs` cogs DECIMAL(10, 2) NOT NULL,
CHANGE `Rating` rating FLOAT NOT NULL,
CHANGE `time_of_day` time_of_day varchar(20) NOT NULL;

SELECT *
FROM walmart_sales_data_staging;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- END OF DATA WRANGLING ------------------------------------------------------------------------------------




-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- DATA ENGINEERING -----------------------------------------------------------------------------------------


-- Add time of the day for each row in respect to the time of transaction
ALTER TABLE walmart_sales_data_staging ADD COLUMN time_of_day VARCHAR(20);
UPDATE walmart_sales_data_staging
SET time_of_day = (
CASE 
	WHEN `Time` BETWEEN '00:00:00' AND '11:59:59' THEN "Morning"
    WHEN `Time` BETWEEN '12:00:00' AND '17:00:00' THEN "Afternoon"
	ELSE 'Evening'
END
);

-- Add the new column day of the week for each row
ALTER TABLE walmart_sales_data_staging ADD COLUMN day_of_week VARCHAR(20);
UPDATE walmart_sales_data_staging
SET day_of_week = DAYNAME(`date`);	

-- Add the new column month of the year for each row
ALTER TABLE walmart_sales_data_staging ADD COLUMN month_of_year VARCHAR(20);
UPDATE walmart_sales_data_staging
SET month_of_year = MONTHNAME(`date`);

SELECT *
FROM walmart_sales_data_staging;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------- END OF DATA ENGINEERING ------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- EXPLORATORY DATA ANALYSIS ------------------------------------------------------------------------------------
SELECT *
FROM walmart_sales_data_staging;

-- -------------------------------------------------------------------------------- GENERAL QUESTIONS -------------------------------------------------------------------------------------

-- 1. How many unique cities are there? 
SELECT DISTINCT city
FROM walmart_sales_data_staging;

-- 2. Which city is each branch located in?
SELECT DISTINCT city, branch
FROM walmart_sales_data_staging;
-- -------------------------------------------------------------------------------- PRODUCT INSIGHT ---------------------------------------------------------------------------------------
-- How many unique product lines does the data have? 
SELECT COUNT(DISTINCT product_line) AS unique_products
FROM walmart_sales_data_staging;

-- What is the most common payment method?
SELECT payment_method, COUNT(*) AS counter
FROM walmart_sales_data_staging
GROUP BY payment_method
ORDER BY counter DESC;

-- What is the most selling product line?
SELECT product_line, COUNT(*) AS counter
FROM walmart_sales_data_staging
GROUP BY product_line
ORDER BY counter DESC;

-- What is the total revenue by month?
SELECT month_of_year AS `month` , ROUND(SUM(total), 2) AS total_revenue
FROM walmart_sales_data_staging
GROUP BY `month`
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT month_of_year, SUM(cogs) AS cogs
FROM walmart_sales_data_staging
GROUP BY month_of_year
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT product_line, SUM(total) AS total_revenue
FROM walmart_sales_data_staging
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT branch, city, SUM(total) AS total_revenue
FROM walmart_sales_data_staging
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT product_line, AVG(VAT) AS avg_tax
FROM walmart_sales_data_staging
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Label product_lines as "good" or "bad" based on the total if it's greater than average sales
WITH avg_total AS (
    SELECT AVG(total) AS avg_sales 
    FROM walmart_sales_data_staging
)
SELECT product_line,
CASE 
	WHEN AVG(total) > (SELECT avg_sales FROM avg_total) THEN 'Good'
	ELSE 'Bad'
END AS observation
FROM walmart_sales_data_staging
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS sum_quantity
FROM walmart_sales_data_staging
GROUP BY branch
HAVING sum_quantity > AVG(quantity)
ORDER BY sum_quantity DESC;

-- What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender) AS gender_cnt
FROM walmart_sales_data_staging
GROUP BY gender, product_line
ORDER BY gender_cnt DESC;

-- What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 1) AS avg_rating
FROM walmart_sales_data_staging
GROUP BY product_line
ORDER BY avg_rating DESC;

SELECT * FROM walmart_sales_data_staging;

-- -------------------------------------------------------------------------------- SALES INSIGHT-----------------------------------------------------------------------------------------

-- 1. Number of sales made in each time of the day per weekday
SELECT time_of_day, COUNT(*) total_sales_per_day
FROM walmart_sales_data_staging
WHERE day_of_week IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY')
GROUP BY time_of_day
ORDER BY total_sales_per_day DESC;

-- 2. Which of the customer types brings the most revenue?
SELECT customer_type, SUM(total) AS total_revenue
FROM walmart_sales_data_staging
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- 3. Which city has the largest tax percent/VAT (Value Added Tax)?
SELECT city, AVG(VAT) as avg_vat
FROM walmart_sales_data_staging
GROUP BY city
ORDER BY avg_vat DESC;


-- 4. Which customer type pays the most in VAT?
SELECT customer_type, avg(VAT) as avg_vat
FROM walmart_sales_data_staging
GROUP BY customer_type
ORDER BY avg_vat DESC;

SELECT * FROM walmart_sales_data_staging;

-- -------------------------------------------------------------------------------- CUSTOMER INSIGHT ---------------------------------------------------------------------------------------

-- 1. How many unique customer types does the data have?
SELECT COUNT(DISTINCT customer_type) AS unique_customers
FROM walmart_sales_data_staging;

-- 2. How many unique payment methods does the data have?
SELECT COUNT(DISTINCT payment_method) AS unique_payment
FROM walmart_sales_data_staging;

-- 3. What is the most common customer type?
SELECT customer_type, COUNT(*) AS trans_count
FROM walmart_sales_data_staging
GROUP BY customer_type; 

-- 4. Which customer type makes the most transactions?
SELECT customer_type, SUM(total) AS most_transactions
FROM walmart_sales_data_staging 
GROUP BY customer_type
ORDER BY most_transactions DESC;

-- 5. What is the gender of most of the customers?
SELECT DISTINCT gender, COUNT(*) AS gen_cnt
FROM walmart_sales_data_staging
GROUP BY gender
ORDER BY gen_cnt DESC;

-- 6. What is the gender distribution per branch?

-- 7. Which time of the day do customers give most ratings?
-- 8. Which time of the day do customers give most ratings per branch?
-- 9. Which day fo the week has the best avg ratings?
-- 10. Which day of the week has the best average ratings per branch?


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------- END OF EXPLORATORY DATA ANALYSIS ------------------------------------------------------------------------------------




