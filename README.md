# Project Walmart Sales Data Analysis

## Project overview
------

This project aims to explore the Walmart sales data to understand top performing branches and products, sales trend of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The data was obteined from the [Kaggle Walmart Sales Forecasting Competition.](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

"One challenge of modeling retail data is the need to make decisions based on limited history. If Christmas comes but once a year, so does the chance to see how strategic decisions impacted the bottom line." 
"...job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact."
[source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

Despite this challenge was several years before, I'm practicing how to do EDA in some examples or projects and this one is interesting for me.

## Data Sources
Walmart Sales Data: The primary dataset used for this analysis is the "WalmartSalesData.csv" file, containing information in 17 columns and 1000 rows. The following table shows the columns of the data set and the type of variable for each column.

![image](https://github.com/AlanDnl/Walmart-Sales-Data-Analysis/assets/150567418/cbe338cc-6679-461f-ac52-11edfffdfaa9)

## Tools
- SQL server: Data cleaning and Data analysis
- Power BI: Creating report

## Data cleaning/preparation
1. Feature Engineering: This will help use generate some new columns from existing ones.
   
    1.1 Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
   
    1.2 Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day 
        each branch is busiest.
   
    1.3 Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

2. Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

3. Conclusion:

## Analysis List
**Product Analysis**
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

**Sales Analysis**
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

**Customer Analysis**
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

# Business Questions to Answer
## Generic Question
1. How many unique cities does the data have?
2. In which city is each branch?
## Product
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
10. Which branch sold more products than average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

## Sales
1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (Value Added Tax)?
4. Which customer type pays the most in VAT?
## Customer
1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day fo the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?

## Data Analysis
Include some interesting code/features worked with
```` sql
--9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT AVG(Total) AS avg_total FROM WalmartSalesData ------- The avg_total is 322.966749

SELECT Total,
       (CASE
        WHEN Total > (SELECT AVG(Total) FROM WalmartSalesData) THEN 'Good'
		ELSE 'Bad'
		END) AS Qualification
FROM WalmartSalesData
--10.Which branch sold more products than average product sold?
SELECT Branch, SUM(Quantity) AS products_sold FROM WalmartSalesData
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM WalmartSalesData)
-----------------------------------------------------------------------A	1859, C	1831, B	1820
--11.What is the most common product line by gender?
SELECT Product_line,Gender,COUNT(Product_line) AS product_count FROM WalmartSalesData
GROUP BY Product_line, Gender
ORDER BY product_count DESC
````

## Revenue and Profit Calculations

$ COGS = unitsPrice * quantity $

$ VAT = 5% * COGS $

VAT is added to the COGS and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

Example with the first row in our DB:

Data given:

* $ \text{Unite Price} = 45.79 $
* $ \text{Quantity} = 7 $
$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5% * COGS\= 5% 320.53 = 16.0265 $

$ total = VAT + COGS\= 16.0265 + 320.53 = 336.5565

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\=\frac{16.0265}{336.5565} = 0.047619\\approx 4.7619% $

## Data visualization
![image](https://github.com/AlanDnl/Walmart-Sales-Data-Analysis/assets/150567418/af8d6fbb-4b46-4632-9767-c37e4408ed0e)


## References
1. Walmart Sales Data Analysis With MySQL | MySQL Protfolio Project | Part 1 [https://www.youtube.com/watch?v=Qr1Go2gP8fo]
2. Walmart Sales Data Analysis With MySQL | MySQL Protfolio Project | Part 2 [https://www.youtube.com/watch?v=36fBGMT0tuE]
3. SQL Tutorial [https://www.w3schools.com/sql/default.asp]
4. Princekrampah Portfolio [https://github.com/Princekrampah/WalmartSalesAnalysis]
