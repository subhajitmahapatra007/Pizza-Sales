USE pizza_db;
SELECT * FROM pizza_sales;

UPDATE pizza_sales SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
## Business KPIs
-- Total Revenue
SELECT ROUND(SUM(total_price),2)  AS total_revenue FROM pizza_sales;

-- Avarage Order Value 
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2)  AS Avg_order_value FROM pizza_sales;

-- Total Pizza Sold
SELECT SUM(quantity) AS total_pizza_order FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- Avarage Pizzas per order
SELECT ROUND(SUM(quantity)/COUNT(DISTINCT order_id),2)  AS Avg_pizza_per_order FROM pizza_sales;

## Insights and Key trends
 -- Daily Trend for Total Orders:
SELECT 
	DAYNAME(order_date) AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales GROUP BY day_name ORDER BY total_orders DESC;

-- Monthly Trend for Total Orders:
SELECT 
	MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales GROUP BY day_name ORDER BY total_orders DESC;

-- Percentage of Sales by Pizza Category:
SELECT pizza_category,	
    ROUND(SUM(total_price),2) AS category_total_price,
	ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2) AS sales_percentage
FROM pizza_sales GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size:
SELECT pizza_size,	
    ROUND(SUM(total_price),2) AS category_total_price,
	ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2) AS sales_percentage
FROM pizza_sales GROUP BY pizza_size;

-- Total Pizzas Sold by Pizza Category:
SELECT pizza_category,	
	COUNT(*) AS total_order,
    ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM pizza_sales),2) As order_percentage
FROM pizza_sales GROUP BY pizza_category;

-- Top 5 Best Pizza by Revenue, Total Quantity and Total Orders:
SELECT pizza_name,
	COUNT(*) AS total_order,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales GROUP BY pizza_name 
ORDER BY total_order DESC,total_quantity DESC,total_revenue DESC LIMIT 5;

-- Bottom 5 Best Pizza by Revenue, Total Quantity and Total Orders:
SELECT pizza_name,
	COUNT(*) AS total_order,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales GROUP BY pizza_name 
ORDER BY total_order,total_quantity,total_revenue LIMIT 5;