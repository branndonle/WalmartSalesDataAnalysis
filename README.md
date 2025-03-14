# Walmart Sales Data Analysis and Exploratory Data Analysis
 
## About this Project
This project's goals are to explore the Walmart Sales data to gain valueable knowledge in top performing branches and products, sales trend of of different products, and customer behavior. The focus of this is to be able to recognize sales patterns and be able to accustomed to them and optimize our sales strategies. This dataset was retrieved from [Kaggle's Datasets](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

## Objective
This project aims to analyze Walmart's sales data to identify key factors that influence sales performance across various branches. By exploring different variables, we seek to gain valuable insights into how different elements impact branch specific sales.

## Methodology
### Data Wrangling: This is the first step where inspection of data to ensure NULL values and missing values are detected and data replacement methods are used to occupy missing or NULL values.
> 1. Create a new database

> 2. Create a raw table and insert the data.
> 3. Create a staging table with the raw data to alter.
> 4. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.

### Feature Engineering: This will generate new columns while using existing columns.
> 1. Add a new column, **_time_of_day_**, to give insight on sales based on the time of the day (Morning, Afternoon, or Evening).
   
> 2. Add a new column, **_day_name_**, which signifies the day each transaction took place (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday). This aids in answering the question on which day of the week each branch is the slowest, moderate, and busiest.
   
> 3. Add a new column, **_month_name_**, that contains the month of the year when the transaction took place (Jan, Feb, Mar, etc). This will allow us to determine which month of the year is the slowest, when it is moderate, and where we make the most sales/profit.

## Exploratory Data Analysis
### General Questions
> 1. How many unique cities are there?

> 2. Which city is each branch located in?

### Product Insight
> 1. How many unique product lines does the data have?

> 2. What is the most common payment method?
 
> 3. What is the most selling product line?
 
> 4. What is the total revenue by month?
 
> 5. What month had the largest COGS?

> 6. What product line had the largest revenue?
 
> 7. What is the city with the largest revenue?

> 8. What product line had the largest VAT?

> 9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

> 10. Which branch sold more products than average product sold?

> 11. What is the most common product line by gender?

> 12. What is the average rating of each product line?

### Sales Insight
> 1. Number of sales made in each time of the day per weekday

> 2. Which of the customer types brings the most revenue?

> 3. Which city has the largest tax percent/ VAT (Value Added Tax)?

> 4. Which customer type pays the most in VAT?

### Customer Insight
> 1. How many unique customer types does the data have?

> 2. How many unique payment methods does the data have?

> 3. What is the most common customer type?

> 4. Which customer type makes the most transactions?

> 5. What is the gender of most of the customers?

> 6. What is the gender distribution per branch?

> 7. Which time of the day do customers give most ratings?

> 8. Which time of the day do customers give most ratings per branch?

> 9. Which day fo the week has the best avg ratings?

> 10. Which day of the week has the best average ratings per branch?

