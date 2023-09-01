use portfolio_project;
create table walmart(Store int,	Date date,	Weekly_Sales float,	Holiday_Flag int,Temperature float,
Fuel_Price float,CPI float,	Unemployment float);
select * from walmart;
select count(store) from walmart;
select count(*) from walmart where weekly_sales is null;
select max(Weekly_Sales) as max_weekly_sales,Date
from walmart 
group by Date
order by max_weekly_sales desc
limit 5;

-- yearly sales

with yearly_sales as (
select extract(year from Date) as sales_year,
sum(Weekly_Sales) as total_sales
from walmart
group by sales_year)
select sales_year,total_sales
from yearly_sales 
order by total_sales desc;

-- monthly sales in 2011

with monthly_sales as(
select extract(month from Date) as sales_month,
sum(Weekly_Sales) as total_sales
from walmart
where extract(year from Date)= 2011
group by sales_month)
select sales_month,total_sales
from monthly_sales
order by total_sales desc;

-- which store had max sales

with total_sales as(
select Store, sum(Weekly_Sales) as total_sales
from walmart
group by Store)
select Store,total_sales
from total_sales
order by total_sales desc
limit 3;

-- sales during holiday and non-holiday week

select case when Holiday_Flag=1 then 'Holiday week'
else 'Non-Holiday week' 
end as week_type, sum(Weekly_Sales) as total_sales
from walmart group by week_type;

-- which holiday week has highest sales

select Holiday_Flag,Date, max(Weekly_Sales) as total_sales
from walmart
where Holiday_Flag=1
group by Date order by total_sales desc;

-- stores with highest growth rate

          
with store_growth_rate as(select subquery.Store,
round((subquery.sales_2012 - subquery.sales_2010) / subquery.sales_2010,4) as growth_rate
from(select walmart.Store,sum( case when extract(year from walmart.Date)=2010 then walmart.Weekly_Sales
end) as sales_2010,
sum( case when extract(year from walmart.Date)=2012 then walmart.Weekly_Sales
end) as sales_2012
from walmart
group by walmart.store)subquery) 


SELECT Store, growth_rate
FROM store_growth_rate
ORDER BY growth_rate DESC
LIMIT 5 ;

-- stores with LOWEST growth rate

with store_growth_rate as(select subquery.Store,
round((subquery.sales_2012 - subquery.sales_2010) / subquery.sales_2010,4) as growth_rate
from(select walmart.Store,sum( case when extract(year from walmart.Date)=2010 then walmart.Weekly_Sales
end) as sales_2010,
sum( case when extract(year from walmart.Date)=2012 then walmart.Weekly_Sales
end) as sales_2012
from walmart
group by walmart.store)subquery) 
SELECT Store, growth_rate
FROM store_growth_rate
ORDER BY growth_rate ASC
LIMIT 5 





