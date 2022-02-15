CREATE database superstore;
USE superstore;

select * from cust_dimen;
select * from market_fact;
select * from orders_dimen;
select * from prod_dimen;
select * from shipping_dimen;

-- TASK 1 : Understanding the DATA

-- Q1. Describe the data in hand in your own words.
-- The Superstore dataset show the data of the customers as "cust_dimen" which shows the customer name, the region they belong to, the segment they work and their customer id. The dataset also shows the stats related to the market as "market_fact" which shows the sales, discount, quantity, profit, shipping cost and margin which is connected through the order id, product id, and ship id. The "order_dimen" shows the details about the order id, date and order priority. The "prod_dimen" shows the category and sub-category the product belongs to having key as prod_id. The "shipping_dimen" shows the shipping mode and the date assigned with the order id and ship id.

-- Q2. Identify and list the Primary Keys and Foreign Keys for this dataset provided to you(In case you don’t find either primary or foreign key, then specially mention this in your answer)
-- The primary key in "cust_dimen" is "cust_id" which is a foreign key in "market_fact", similarly "order_dimen, prod_dimen, shipping_dimen" has primary keys as "ord_id, prod_id, ship_id" respectively, who are acting as foreign keys in "market_fact".

-- TASK 2 : BASIC AND ADVANCED ANALYSIS

-- Q1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.

SELECT
	customer_name 'CUSTOMER NAME', customer_segment 'CUSTOMER SEGMENT'
FROM
	cust_dimen;
    
-- Q2. Write a query to find all the details of the customer from the table cust_dimen order by desc.

SELECT *
FROM
	cust_dimen
ORDER BY
	customer_name desc;
    
-- Q3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.

SELECT
	order_id, order_date
FROM
	orders_dimen
WHERE
	order_priority='high';
    
-- Q4. Find the total and the average sales (display total_sales and avg_sales).

SELECT
	sum(sales) 'TOTAL SALES', avg(sales) 'AVERAGE SALES'
FROM
	market_fact;

-- Q5. Write a query to get the maximum and minimum sales from maket_fact table.

SELECT
	max(sales) 'MAXIMUM SALES', min(sales) 'MIMINUM SALES'
FROM
	market_fact;
    
-- Q6. Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.

SELECT
	region, count(customer_name) 'COUNT'
FROM
	cust_dimen
GROUP BY
	region
ORDER BY
	COUNT desc;
    
-- Q7. Find the region having maximum customers (display the region name and max(no_of_customers).

SELECT
	region, max(customer_name) 'MAXIMUM CUSTOMERS'
FROM
	cust_dimen
GROUP BY
	region
ORDER BY
	max(customer_name) desc limit 1;
    
-- Q8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased).
select * from cust_dimen;
select * from prod_dimen;
select * from market_fact;

SELECT 
	customer_name, count(*)
FROM	
	market_fact m , cust_dimen c , prod_dimen p     
WHERE 
	m.cust_id = c.cust_id
AND
	m.prod_id = p.prod_id 
AND 
	p.product_sub_category = 'TABLES' 
AND 
	c.region = 'ATLANTIC'     
GROUP By 
	Customer_Name;
    
-- Q9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners).

SELECT
	customer_name, count(*)
FROM
	cust_dimen
WHERE
	customer_segment='SMALL BUSINESS'
AND
	province='ONTARIO'
GROUP BY
	customer_name;
    
-- Q10. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold).

SELECT
	prod_id, count(*)
FROM
	market_fact
GROUP BY
	prod_id
ORDER BY
	count(*) desc;
    
-- Q11. Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category.

SELECT
	prod_id, product_sub_category
FROM
	prod_dimen
WHERE
	product_category='FURNITURE'
OR 
	product_category='TECHNOLOGY';
    
-- Q12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?

SELECT
	product_category, profit
FROM
	 prod_dimen p, market_fact m
WHERE
	p.prod_id = m.prod_id
GROUP BY
	product_category
ORDER BY
	profit desc;
    
-- Q13. Display the product category, product sub-category and the profit within each subcategory in three columns.

SELECT
	product_category, product_sub_category, profit
FROM
	 prod_dimen p, market_fact m
WHERE
	p.prod_id = m.prod_id;
    
-- Q14. Display the order date, order quantity and the sales for the order.

SELECT
	order_date, order_quantity, sales
FROM
	orders_dimen o, market_fact m
WHERE
	o.ord_id = m.ord_id
ORDER BY
	order_date;
    
-- Q15. Display the names of the customers whose name contains the : i) Second letter as ‘R’, ii) Fourth letter as ‘D’

SELECT
	DISTINCT customer_name
FROM
	cust_dimen
WHERE
	customer_name like '_R%'
AND
	customer_name like '___D%';
    
-- Q16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.

SELECT
	c.cust_id, sales, customer_name, region
FROM
	cust_dimen c, market_fact m
WHERE
	c.cust_id = m.cust_id
AND
	sales BETWEEN 1000 AND 5000;

-- Q17. Write a SQL query to find the 3rd highest sales.

SELECT
	max(sales) '3rd HIGHEST SALES'
FROM
	market_fact
ORDER BY
	sales limit 3;
    
-- Q18. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region) → Note: You can hardcode the name of the least profitable product subcategory

SELECT
	region, count(ship_id) NO_OF_SHIPMENT, sum(profit) PROFIT_IN_EACH_REGION
FROM
	cust_dimen c, market_fact m, prod_dimen p
WHERE
	c.cust_id = m.cust_id
AND
	m.prod_id = p.prod_id
GROUP BY
	region
ORDER BY
	PROFIT_IN_EACH_REGION;