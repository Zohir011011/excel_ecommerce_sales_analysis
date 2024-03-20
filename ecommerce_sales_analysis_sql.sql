-- selecting the database
use usa_ecommerce_database;

-- showing all the tables from the database
show tables;

-- open country table
select * from country_table;

-- open customer table
select * from customer_table;

-- open order table
select * from order_table;

-- open product table
select * from product_table;

-- open relational table
select * from relational_table;


-- ----------------------- Exploratory Data Analysis -----------------
-- calculate the total sales, total quantity, and total profit from order table
select sum(sales_price) as total_sales, sum(quantity) as total_quantity, sum(profit) as total_profit
from order_table;

-- calculate the total sales, total quantity, and total profit per year from order table
select year, sum(sales_price) as total_sales, sum(quantity) as total_quantity, sum(profit) as total_profit
from order_table
group by year
order by year;

-- calculate the total sales, total quantity, and total profit from each ship mode from order table
select ship_mode, sum(sales_price) as total_sales, sum(quantity) as total_quantity, sum(profit) as total_profit
from order_table
group by ship_mode
order by ship_mode;

-- calculate the number of customers
select count(distinct customer_name) as total_customer
from customer_table;

-- calculate the number of customers from different customer segment
select customer_segment, count(distinct customer_name) as total_customer
from customer_table
group by customer_segment;

-- calculate total salse, total quantity and total profit of a customer such as "Brosina Hoffman"/"Alan Shonely"
select ct.customer_name, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join customer_table ct
on ct.customer_id = rt.customer_id
where ct.customer_name = "Brosina Hoffman";

select ct.customer_name, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join customer_table ct
on ct.customer_id = rt.customer_id
where ct.customer_name = "Alan Shonely";

-- show the customer name with total sales by descending order
select ct.customer_name, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join customer_table ct
on ct.customer_id = rt.customer_id
group by ct.customer_name
order by total_sales desc;

-- show the customer name with total profit by descending order
select ct.customer_name, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join customer_table ct
on ct.customer_id = rt.customer_id
group by ct.customer_name
order by total_profit desc;

-- show the top ten state name that generated highest profit
select ct.state, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join country_table ct
on ct.order_id = rt.order_id
group by ct.state
order by total_profit desc
limit 10;

-- calculate the total sales, total profit and total quantity of each region by each year
select ot.year, ct.region, round(sum(ot.sales_price)) as total_sales, sum(ot.quantity) as total_quantity, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join country_table ct
on ct.order_id = rt.order_id
group by ct.region, ot.year;

-- show total sales, total profit and total quantity by each month and each year
select year, monthname(order_date) as month_name, month(order_date) as month, round(sum(sales_price)) as total_sales, round(sum(profit)) as total_profit, round(sum(quantity)) as total_quantity
from order_table
group by month_name, month, year
order by month, year;

-- calculate the average days between order date and shipping date
select round(avg(datediff(ship_date, order_date))) as avg_days_between_order_and_shipping
from order_table;

-- calculate the average discount rate by each year
select year, round(avg(discount), 2) as average_discount
from order_table
group by year;

-- calculate the average sales, profit and discount of each year
select year, round(avg(sales_price)) as average_salse, round(avg(profit)) as average_profit, round(avg(discount), 2) as average_discount
from order_table
group by year;

-- show the most profitable product category
select pt.category, sum(ot.profit) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join product_table pt
on pt.product_id = rt.product_id
group by pt.category
order by total_profit desc;

-- show the most profitable sub category
select pt.sub_category, round(sum(ot.profit)) as total_profit
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join product_table pt
on pt.product_id = rt.product_id
group by pt.sub_category
order by total_profit desc;

-- show the most sold product category from East region in 2012
select ot.year, cn.region, round(sum(ot.sales_price)) as total_sales
from order_table ot
join relational_table rt
on ot.order_no = rt.order_no
join customer_table cs
on cs.customer_id = rt.customer_id
join country_table cn
on cn.order_id = rt.order_id
where ot.year = "2012"
group by cn.region;




