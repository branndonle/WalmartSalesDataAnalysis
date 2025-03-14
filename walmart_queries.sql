USE walmart_sales_db;
SELECT *
FROM walmartsalesdata;

CREATE TABLE walmart_sales_data_Staging LIKE walmartsalesdata;
INSERT INTO walmart_sales_data_Staging SELECT * FROM walmartsalesdata;


-- Add time of the day for each row in respect to the time of transaction
ALTER TABLE walmart_sales_data_Staging ADD COLUMN time_of_day VARCHAR(20);
UPDATE walmart_sales_data_Staging
SET time_of_day = (
CASE 
	WHEN `Time` BETWEEN '00:00:00' AND '11:59:59' THEN "Morning"
    WHEN `Time` BETWEEN '12:00:00' AND '17:00:00' THEN "Afternoon"
	ELSE 'Evening'
END
);

SELECT *
FROM walmart_sales_data_Staging;







