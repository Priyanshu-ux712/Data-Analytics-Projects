SELECT * FROM third_project.modified_sample_superstore;

create view Sales_by_Region as 
select Region,State,City , round(sum(Sales),2) as Sales from third_project.modified_sample_superstore 
group by Region,State,City 
order by Region;

create view Profitability_by_Category as
select Category , `Sub-Category` , round(sum(Profit)/sum(Sales),2) as Sales_Profit from third_project.modified_sample_superstore
group by Category , `Sub-Category` order by Category;

create view Sales_by_Customer_Segment as
select Segment , round(sum(Sales),2) as  Sales from third_project.modified_sample_superstore group by Segment;

create view Discount_vs_Profit as 
select Discount , round(sum(Profit)/sum(Sales),2) as Sales_Profit from third_project.modified_sample_superstore group by Discount;

create view Top_Customers as
select `Customer Name`,round(sum(Sales),2) as Sales from third_project.modified_sample_superstore 
group by `Customer Name` order by Sales desc limit 10;


create view High_profit_vs_low_profit as 
select `Customer Name`,Sales ,case
when Difference_Data = 1 then "High_Profit"
else "Low_Profit" end as Customer_Status 
from 
(select `Customer Name`,round(sum(Sales),2) as Sales,
ntile(2) over (order by sum(Sales) desc) as Difference_Data
from third_project.modified_sample_superstore 
group by `Customer Name`) as main_Query order by Sales desc;


create view Shipping_delay as
select datediff(
STR_TO_DATE(TRIM(`Ship Date`), '%d-%m-%Y'),
STR_TO_DATE(TRIM(`Order Date`), '%d-%m-%Y')) as Shipping_delay from third_project.modified_sample_superstore group by Shipping_delay;


create view Quarterly_sales as
SELECT 
  CONCAT(YEAR(STR_TO_DATE(TRIM(`Ship Date`), '%d-%m-%Y')), '-Q', QUARTER(STR_TO_DATE(TRIM(`Ship Date`), '%d-%m-%Y'))) AS Quarter,
  round(SUM(Sales),2) AS Total_Quarterly_Sales
FROM third_project.modified_sample_superstore
GROUP BY Quarter
ORDER BY Quarter;


create view Monthly_sales as 
select concat(year(str_to_date(trim(`Order Date`),'%d-%m-%Y')),' - ',lpad(month(str_to_date(trim(`Order Date`),'%d-%m-%Y')),2,'0'))as Months,
round(sum(Sales),2) as Total_Sales 
from third_project.modified_sample_superstore
group by Months
order by Months;


select year(str_to_date(`Order Date`,'%d-%m-%Y')) as year 
from third_project.modified_sample_superstore group by year;



select `Ship Mode` , round(sum(Sales),2) as Total_Sales , sum(Quantity) as Total_Quantities , 
round(sum(Discount),2) as Total_Discount , round(sum(Profit),2) as Total_Profit, count(*) as orders ,
round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0) as Average_Delay
from third_project.modified_sample_superstore
group by `Ship Mode` 
order by Total_Profit;







-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create view shipping_modes as 
select `Ship Mode`,
Total_Sales,
Total_Quantities, 
Total_Discount,
Total_Profit,
orders,
case 
	when Average_Delay = 0 or Average_Delay = 1
		       then concat(Average_Delay,' Day')
		else concat(Average_Delay,' Days')
end as Average_Delay1
from (select `Ship Mode`,
round(sum(Sales),2) as Total_Sales,
sum(Quantity) as Total_Quantities , 
round(sum(Discount),2) as Total_Discount,
round(sum(Profit),2) as Total_Profit,
count(*) as orders ,
round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0) as Average_Delay
from third_project.modified_sample_superstore
group by `Ship Mode`) as inner_query
order by Total_Profit;

-- this query is same too but with differernt query

select `Ship Mode`,
Total_Sales,
Total_Quantities, 
Total_Discount,
Total_Profit,
orders,
Average_Delay1
from (select `Ship Mode`,
round(sum(Sales),2) as Total_Sales,
sum(Quantity) as Total_Quantities , 
round(sum(Discount),2) as Total_Discount,
round(sum(Profit),2) as Total_Profit,
count(*) as orders ,
round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0) as Average_Delay,
case 
	when round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0) in(0,1)
		       then concat(round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0),' Day')
		else concat(round(avg(datediff(str_to_date(`Ship Date`,'%d-%m-%Y') , str_to_date(`Order Date`,'%d-%m-%Y'))),0),' Days')
end as Average_Delay1
from third_project.modified_sample_superstore
group by `Ship Mode`) as inner_query
order by Total_Profit;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create view repeat_customers as
select `Customer ID`,`Customer Name`, count(`Customer ID`) as Total_Orders,
round(sum(Sales),2) as Total_Sales
from third_project.modified_sample_superstore 
group by `Customer ID`,`Customer Name`
-- having Total_Orders > 1 -- commented this condition bcoz we are taking biggest values not the smallest values !!!!
order by Total_Orders desc limit 10;


create view discount_affects_profit as
select Discount,round(avg(Profit),2) as Average_Profit from third_project.modified_sample_superstore group by Discount order by Average_Profit desc ;


create view loss as 
select `Product Name`,count(*) as Product_Count ,round(sum(Profit),2) as Total_Loss,round(avg(Discount),2) as Avg_Discount 
from third_project.modified_sample_superstore
group by `Product Name` 
having Total_Loss < 0 and Avg_Discount > 0.15
order by Total_Loss;



create view Use_maps as
select Region,Country,State,City,round(sum(Sales),2) as Total_Sales , round(sum(Profit),2) as Total_Profit 
from third_project.modified_sample_superstore
group by Region,Country,State,City
order by Total_Sales;


create view by_region as 
select Region , round(sum(Sales),2) as Total_Sales , round(sum(Profit),2) as Total_Profit 
from third_project.modified_sample_superstore group by Region order by Total_Sales;



create view RFM_scores as
select `Customer Name`,`Customer ID`,count(*) as Orders , max(str_to_date(`Order Date`,'%d-%m-%Y')) as Last_Date , round(sum(Sales),2) as Total_Sales 
from third_project.modified_sample_superstore 
group by `Customer ID`,`Customer Name` order by Total_Sales;



create view ABC as 
with Product_Sales as (select `Product Name`,round(sum(Sales),2) as Sales from third_project.modified_sample_superstore group by `Product Name` ),
Total_Sales as ( select sum(Sales) as Final_sales from Product_Sales ),
ABC_Section as ( select x.`Product Name`,
x.Sales , round(sum(x.Sales)over (order by x.Sales desc rows between unbounded preceding and current row),2) as Cumulative_Sales,
round(sum(x.Sales)over (order by x.Sales desc rows between unbounded preceding and current row)/y.Final_Sales*100,2) as Cumulative_Percent
from product_Sales x cross join Total_Sales y )
select *, 
case 
when cumulative_Percent <= 70 then 'A'
when cumulative_Percent >= 90 then 'c'
else 'B'
end as ABC 
from ABC_Section 
order by Sales desc;

