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
### General Insight
> 1. How many unique cities are there?

> 2. Which city is each branch located in?

> 3. How many sales transactions were there?

> 4. How many products were sold?

> 5. When was the first and last transaction?

### Product & Sales Information
> 1. How many product lines are there?

> 2. What is the most common form of payment?
 
> 3. What is the most popular product category?
 
> 4. Which branches sold more products than the average number of products sold?

> 5. What is the total revenue each month?
 
> 6. Which city genereates the most revenue?

> 7. What month had the largest COGS?

> 8. What product line had the largest revenue?
 
> 9. What is the city with the largest revenue?

> 10. What is the average rating of each product line?

> 11. Label product_lines as good or bad based on if the total is greater than average sales

### Profitable & Finacial Metrics
> 1. Which branch is the most profitable?

> 2. What is the gross margin percentage by product line?

> 3. What is the comparison between the cost of goods sold versus revenue?

### Sales Performance & Trends
> 1. Which city has the largest tax percent?

> 2. Number of sales made in each time of the day per weekday

> 3. Which of the customer types brings the most revenue?

> 4. Which customer type pays the most in VAT?

> 5. What are the total sales by each branch? 

> 6. What does the sales growth over time look like?

> 7. What is the yearly sales growth?

### Customer Insight
> 1. How many customer types are there?

> 2. Which customer type spends more?

> 3. What is the most frequent customer type seen?

> 4. What is the sales difference between customer segments? 

> 5. How many payment methods are there?

> 6. When do the most ratings occur during the day?

> 7. Which Payment Method Has the Highest Average Rating?

> 8. Which day of the week has the best average ratings?

> 9. Which day of the week has the best average ratings per branch?

> 10. Which branch has the best customer satisfaction rating?