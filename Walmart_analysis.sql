SELECT COLUMN_NAME, IS_NULLABLE, 
       COALESCE(CHARACTER_MAXIMUM_LENGTH,0) as Longitud, 
       DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name = 'WalmartSalesData' 
ORDER BY ordinal_position;

------------------------------------- FEATURE ENGINEERING----------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- time_of_day

SELECT time,
       (CASE
	   WHEN CONVERT(varchar(10), Time,108) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	   WHEN CONVERT(varchar(10), Time,108)  BETWEEN '12:00:01' AND '16:00:00' THEN 'Afternoon'
	   ELSE 'Evening'
	   END
	   ) AS time_of_day
FROM DBO.WalmartSalesData

---------- First we changed the method used in MySQL to adapt it to SQL server, and we could convert the column 'Time' of type datetime to varchar because we want
---------- to change the format to only %H:%m:%s that is the format 108
----------- ''''select CONVERT(varchar(10), Time,108)
----------------from dbo.WalmartSalesData''''

---Now we want to add the column into our data set with the information above of the time of the day
---We have to go to the Object Explorer and select the project>table>columns and left click 'create column'
ALTER TABLE dbo.WalmartSalesData
ADD Time_of_day varchar(20) NULL

UPDATE dbo.WalmartSalesData
SET Time_of_day = (CASE
	   WHEN CONVERT(varchar(10), Time,108) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	   WHEN CONVERT(varchar(10), Time,108)  BETWEEN '12:00:01' AND '16:00:00' THEN 'Afternoon'
	   ELSE 'Evening'
	   END
	   )

----- THEN CREATE A COLUMN CALLED DAY_NAME WHERE WE CAN SEE THE NAME OF THE DAY OF THE WEEK 
SELECT date, DATENAME(WEEKDAY,Date) AS day_name
FROM dbo.WalmartSalesData

----- Add a new column in the table WalmartSalesData
ALTER TABLE dbo.WalmartSalesData
ADD day_name varchar(10) null;

UPDATE dbo.WalmartSalesData
SET day_name = DATENAME(WEEKDAY,Date)

--------------------------THEN CREATE A COLUMN CALLED MONTH_NAME WHERE WE CAN SEE THE NAME OF THE MONTH OF THE COLUMN: DATE
SELECT Date, DATENAME(MONTH,Date) AS month_name
FROM dbo.WalmartSalesData
--------------------------add a new column in the table WalmartSalesData
ALTER TABLE dbo.WalmartSalesData
ADD month_name varchar(20) null;

UPDATE dbo.WalmartSalesData
SET month_name = DATENAME(MONTH,Date)

SELECT * FROM dbo.WalmartSalesData

