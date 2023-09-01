use pizza_db
select * from pizza_sales; 
--TOTAL REVENUE
select sum(total_price) as Total_Revenue from pizza_sales;
--AVG ORDER VALUE
select sum(total_price)/count(distinct order_id) as avg_order_value from pizza_sales;
--SUM OF QUANTITY
 select sum(quantity) as Total_Pizza_Sold from pizza_sales;
 --TOTAL NO OF ORDER
  select COUNT(DISTINCT order_id) as Total_Orders_Placed from pizza_sales;
  --AVERAGE PIZZA PER ORDER
  select cast(cast(SUM(quantity)as decimal(10,2))/
  cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizza_per_order from pizza_sales;

  --TOTAL NO. OF ORDERS PER DAY
  SELECT DATENAME(DW,order_date) as Order_day,
  count(distinct order_id)as Total_Orders from pizza_sales
  group by DATENAME(DW,order_date);

  --ORDERS PER HOUR(HOURLY TREND)
  SELECT DATEPART(HOUR,order_time)  AS Order_Hour,
  count(distinct order_id)as Total_Orders from pizza_sales
  group by DATEPART(HOUR,order_time) 
  order by  count(distinct order_id) desc;
  
  --SALES ACCORDING TO PIZZA CATEGORY OF PARTICULAR MONTH
   select pizza_category ,sum(total_price)as Total_Sales,sum(total_price)*100/
   (select sum(total_price) from  pizza_sales where month(order_date)=1) as PCT 
   FROM pizza_sales
   where month(order_date)=1 -- 1 stands for january
 
   GROUP BY pizza_category
   
   --SALES ACCORDING TO PIZZA CATEGORY
   select pizza_category ,sum(total_price)as Total_Sales,sum(total_price)*100/
   (select sum(total_price) from  pizza_sales) as PCT 
   FROM pizza_sales
   

   GROUP BY pizza_category

   --SALES ACCORDING TO PIZZA SIZE
   select pizza_size ,CAST(sum(total_price)AS DECIMAL(10,2))as Total_Sales,CAST(sum(total_price)*100/
   (select sum(total_price) from  pizza_sales WHERE DATEPART(quarter,order_date)=1)AS DECIMAL(10,2)) as PCT 
   FROM pizza_sales
   WHERE DATEPART(quarter,order_date)=1

   GROUP BY pizza_size
   ORDER BY PCT DESC

   --TOTAL NO. OF PIZZA SOLD ACCORDING TO CATEGORY
   SELECT pizza_category, sum(quantity) as Total_Piza_Sold
   from pizza_sales
   group by pizza_category


   --TOP FIVE BEST SELLERS
   SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_sold  
   from pizza_sales
   group by pizza_name
   order by sum(quantity) desc

   --BOTTOM 5 WORST SELLERS
   SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_sold  
   from pizza_sales
   WHERE MONTH(order_date)=8
   group by pizza_name
   order by sum(quantity) 
