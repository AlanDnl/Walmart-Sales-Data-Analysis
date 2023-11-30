-- EXPLORATORY DATA ANALYSIS (EDA) IN PYTHON
--Business Questions To Answer
--Generic Question
--1.How many unique cities does the data have? 
SELECT DISTINCT City FROM DBO.WalmartSalesData 
--------------------------- We have 3 unique cities Naypyitaw, Yangon Mandalay
--2.In which city is each branch?
SELECT DISTINCT City,Branch FROM DBO.WalmartSalesData
----------------------------Mandalay	B, Naypyitaw	C, Yangon	A
--Product
--1.How many unique product lines does the data have?
SELECT DISTINCT Product_line FROM WalmartSalesData
----------------------------Fashion accessories, Health and beauty, Electronic accessories, Food and beverages, Sports and travel, Home and lifestyle
--2.What is the most common payment method?
SELECT Payment, COUNT(Payment) AS count FROM WalmartSalesData
GROUP BY Payment
-----------------------------Ewallet	345, Cash	344, Credit card	311
--3.What is the most selling product line?
SELECT Product_line,COUNT(product_line) FROM WalmartSalesData
GROUP BY Product_line
-----------------------------The last method was provided by the creator but I think It depeneds on the quantity of each product, so that we have to consider
----------------------------- the 'Quantity' column and convert it from varchar to int type
ALTER TABLE
   WalmartSalesData
ALTER COLUMN
   Quantity int not null

SELECT Product_line,sum(Quantity) AS Total_sales, COUNT(Product_line) AS Total FROM DBO.WalmartSalesData
GROUP BY Product_line
ORDER BY Total DESC
--4.What is the total revenue by month?
SELECT month_name, SUM(Total) AS Total_revenue FROM WalmartSalesData
GROUP BY month_name
ORDER BY Total_revenue DESC
-----------------------------------------------------------January	116291.868, March	109455.507, February	97219.374
--5.What month had the largest COGS?
SELECT month_name, SUM(cogs) AS Total_cogs FROM WalmartSalesData
GROUP BY month_name
ORDER BY Total_cogs DESC
-----------------------------------------------------------January	110754.16, March	104243.34, February	92589.88
--6.What product line had the largest revenue?
SELECT Product_line, ROUND(SUM(Total),2) AS Total_revenue FROM WalmartSalesData
GROUP BY Product_line
ORDER BY Total_revenue DESC
-----------------------------------------------------------Food and beverages	56144.84
--7.What is the city with the largest revenue?
SELECT Branch,City, ROUND(SUM(Total),2) AS Total_revenue FROM WalmartSalesData
GROUP BY City, Branch
ORDER BY Total_revenue DESC
------------------------------------------------------------ C	Naypyitaw	110568.71
--8.What product line had the largest VAT? VAT is calculated by COGS*0.05
SELECT Product_line, AVG(cogs*0.05) AS VAT FROM WalmartSalesData
GROUP BY Product_line
ORDER BY VAT DESC
------------------------------------------------------------ Home and lifestyle	16.03033125
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
------------------------------------------------------------------------Fashion accessories	Female	96, Health and beauty	Male	88
--12.What is the average rating of each product line?
SELECT Product_line, ROUND(AVG(Rating),2) AS avg_rating FROM WalmartSalesData
GROUP BY Product_line
ORDER BY avg_rating DESC
---------------------------------------------------------------------------Food and beverages	7.11, Fashion accessories	7.03, Health and beauty	7
---------------------------------------------------------------------------Electronic accessories	6.92, Sports and travel	6.92, Home and lifestyle	6.84
--Sales
--1.Number of sales made in each time of the day per weekday
SELECT Time_of_day, SUM(Quantity) AS number_of_sales FROM WalmartSalesData
GROUP BY Time_of_day
ORDER BY number_of_sales DESC
-----------------------------------------------------------------------------Evening	2361, Afternoon	2111, Morning	1038
--2.Which of the customer types brings the most revenue?
SELECT Customer_type,SUM(Total) AS revenue FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY revenue DESC
-----------------------------------------------------------------------------Member	164223.444, Normal	158743.305
--3.Which city has the largest tax percent/ VAT (Value Added Tax)? We calculate the VAT as the following mathematic expression: COGS*0.05
SELECT City, MAX(cogs*0.05) AS VAT FROM WalmartSalesData
GROUP BY City
ORDER BY VAT DESC
-----------------------------------------------------------------------------Naypyitaw	49.65 has the largest VAT
SELECT City, ROUND(AVG(cogs*0.05), 2) AS VAT_avg FROM WalmartSalesData
GROUP BY City
ORDER BY VAT_avg DESC
-----------------------------------------------------------------------------Naypyitaw	16.05 has the largest VAT average
--4.Which customer type pays the most in VAT?
SELECT Customer_type, ROUND(AVG(cogs*0.05),2) AS VAT FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY VAT DESC
-----------------------------------------------------------------------------Member	15.61, Normal	15.15
--Customer
--1.How many unique customer types does the data have?
SELECT DISTINCT Customer_type FROM WalmartSalesData
------------------------------------------------------------------------------NORMAL AND MEMBER
--2.How many unique payment methods does the data have?
SELECT DISTINCT Payment FROM WalmartSalesData
------------------------------------------------------------------------------Ewallet, Cash, Credit card
--3.What is the most common customer type?
SELECT Customer_type,COUNT(*) AS count FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY count DESC
-------------------------------------------------------------------------------Member	501, Normal	499
--4.Which customer type buys the most?
SELECT Customer_type,SUM(Quantity) AS quantity FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY quantity DESC
---------------------------------------------------------------------------------Member	2785, Normal	2725
--5.What is the gender of most of the customers?
SELECT Gender,COUNT(*) AS  count FROM WalmartSalesData
GROUP BY Gender
ORDER BY count DESC
----------------------------------------------------------------------------------Male	499, Female	501
--6.What is the gender distribution per branch?
SELECT Branch,Gender, COUNT(*) AS count FROM WalmartSalesData
GROUP BY Branch, Gender
ORDER BY Branch
----------------------------------------------------------------------------------A	Female	161, A	Male	179, B	Female	162
----------------------------------------------------------------------------------B	Male	170, C	Female	178, C	Male	150
--7.Which time of the day do customers give most ratings?
SELECT Time_of_day,ROUND(AVG(Rating),2) AS Rating_AVG FROM WalmartSalesData
GROUP BY Time_of_day
ORDER BY Rating_AVG DESC
-----------------------------------------------------------------------------------Afternoon	7.03, Morning	6.96, Evening	6.93
--8.Which time of the day do customers give most ratings per branch?
SELECT Branch, Time_of_day,ROUND(AVG(Rating),2) AS Rating_AVG FROM WalmartSalesData
GROUP BY Branch, Time_of_day
ORDER BY Rating_AVG DESC
-----------------------------------------------------------------------------------A	Afternoon	7.19, C	Evening	7.12, C	Afternoon	7.07, A	Morning	7.01
-----------------------------------------------------------------------------------C	Morning	6.97, B	Morning	6.89, A	Evening	6.89, B	Afternoon	6.84, B	Evening	6.77
--9.Which day of the week has the best avg ratings?
SELECT day_name, ROUND(AVG(Rating),2) AS AVG_RATING FROM WalmartSalesData
GROUP BY day_name
ORDER BY AVG_RATING DESC
----------------------------------------------------------------------------------------Monday	7.15
--10.Which day of the week has the best average ratings per branch?
SELECT Branch,day_name, ROUND(AVG(Rating),2) AS AVG_RATING FROM WalmartSalesData
GROUP BY Branch,day_name
ORDER BY AVG_RATING DESC