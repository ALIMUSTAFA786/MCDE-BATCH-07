--Q1. List customers from the state of NY who have no phone number on file. 
--Show their first name, last name, email and city with the aliases First Name, Last Name, Email and City. 
--Sort by last name, then first name, and return only the first 10 rows.


SELECT  first_name AS First_Name,
last_name AS Last_Name,
email AS Email,
city AS City,
state AS State,
phone AS Phone_Number
FROM sales.customers
WHERE state = 'NY' AND phone IS NULL
ORDER BY Last_Name,First_Name;


--Q2. Find products with a model year of 2017 or 2018, a list price between 500 and 1500, whose name contains Trek but does not contain Kids.
--Show product_id, product_name, model_year and list_price, sorted by list_price from highest to lowest.

SELECT product_id,
product_name,
model_year,
list_price
FROM production.products
WHERE model_year = 2017 OR model_year = 2018 AND list_price BETWEEN 500 AND 1500 AND product_name LIKE '%Trek%' AND product_name NOT LIKE '%Kids%'
ORDER BY list_price DESC;


--Q3. (a) List the distinct values of order_status in sales.orders. 

SELECT DISTINCT order_status 
FROM sales.orders;

--Q3. (b) List orders that have not been shipped yet, placed at store 1 or 3 during 2018. 
--Show order_id, customer_id, store_id, order_date and required_date, sorted by order_date.


SELECT order_id,
customer_id,
store_id,
shipped_date,
order_date,
required_date
FROM sales.orders
WHERE shipped_date IS NULL AND store_id IN (1,3) AND order_date LIKE '2018%'
ORDER BY order_date;

--Q4. For order_id = 1, show one row per order line with:
--order_id, order_date, customer full name, product_name, brand_name, category_name, quantity, list_price, discount and line_revenue, where line_revenue = quantity * list_price * (1 - discount) from sales.order_items.

SELECT oi.order_id,
o.order_date,
c.first_name + ' ' + last_name AS customer_name,
p.product_name,
b.brand_name,
ctg.category_name,
oi.quantity,
oi.list_price,
oi.discount,
oi.quantity * oi.list_price * (1 - oi.discount) AS line_revenue
FROM sales.order_items AS oi
INNER JOIN sales.orders AS o
ON oi.order_id = o.order_id
INNER JOIN sales.customers AS c
ON o.customer_id = c.customer_id
INNER JOIN production.products AS p
ON oi.product_id = p.product_id
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id
INNER JOIN production.categories AS ctg
ON p.category_id = ctg.category_id
WHERE oi.order_id = 1;




--Q5. Show every staff member with their store_name and their manager's full name.
--Staff who have no manager must still appear, with the manager shown as 'No Manager'.

SELECT s.staff_id,
s.first_name + ' ' + s.last_name AS staff_name,
st.store_id,
st.store_name,
ISNULL(m.first_name + ' ' + m.last_name,'No Manager') AS manager_name
FROM sales.staffs AS s
INNER JOIN sales.stores AS st
ON s.store_id = st.store_id
LEFT JOIN sales.staffs AS m
ON s.manager_id = m.staff_id;




--Q6. List products that have never been ordered. 
--Show product_id, product_name, brand_name and model_year.

SELECT 
p.product_id,
p.product_name,
b.brand_name,
p.model_year
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
ON p.product_id = oi.product_id
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id
WHERE oi.order_id IS NULL;

--Q7. (a) Create a view sales.vw_order_line_details that returns the Q4 details for all orders, also including store_name and order_status. 

CREATE VIEW sales.vw_order_line_details AS 
SELECT oi.order_id,
o.order_date,
o.order_status,
s.store_name,
c.first_name + ' ' + last_name AS customer_name,
p.product_name,
b.brand_name,
ctg.category_name,
oi.quantity,
oi.list_price,
oi.discount,
oi.quantity * oi.list_price * (1 - oi.discount) AS line_revenue
FROM sales.order_items AS oi
INNER JOIN sales.orders AS o
ON oi.order_id = o.order_id
INNER JOIN sales.customers AS c
ON o.customer_id = c.customer_id
INNER JOIN production.products AS p
ON oi.product_id = p.product_id
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id
INNER JOIN production.categories AS ctg
ON p.category_id = ctg.category_id
INNER JOIN sales.stores AS s
ON o.store_id = s.store_id;


SELECT * FROM sales.vw_order_line_details;

--Q7.Query the view to return all order lines from January 2018, sorted by order_date, then order_id.

SELECT * FROM sales.vw_order_line_details
WHERE order_date >= '2018-01-01' AND order_date < '2018-02-01'
ORDER BY order_date,order_id;

--Q8. (a) Create a view production.vw_product_catalog with product_id, product_name, brand_name, category_name, model_year and list_price.
CREATE VIEW production.vw_product_catalog AS
SELECT p.product_id,
p.product_name,
b.brand_name,
c.category_name,
p.model_year,
p.list_price
FROM production.products AS p
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id
INNER JOIN production.categories AS c
ON p.category_id = c.category_id;

SELECT * FROM production.vw_product_catalog;

--(b) Using only this view, return all Electric Bikes priced above 3000, sorted by price from highest to lowest.

SELECT * FROM production.vw_product_catalog
WHERE category_name = 'Electric Bikes' AND list_price > 3000 
ORDER BY list_price DESC;

--Q9. Using sales.vw_order_line_details, show the total number of distinct orders and total revenue for each store in each year.
--Sort by store_name, then year.

SELECT store_name,
COUNT(DISTINCT order_id) AS total_orders,
SUM(line_revenue) AS total_revenue,
YEAR(order_date) AS order_year
FROM sales.vw_order_line_details
GROUP BY store_name,YEAR(order_date)
ORDER BY store_name,YEAR(order_date);


--Q10. For each brand, show the number of products and the minimum, average and maximum list price. 
--Keep only brands with more than 10 products, sorted by average price from highest to lowest.


SELECT b.brand_name,
COUNT(*) AS product_count,
MIN(p.list_price) AS Min_price,
MAX(p.list_price) AS Max_price,
AVG(p.list_price) AS Avg_price
FROM production.products AS p
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id
GROUP BY b.brand_name
HAVING COUNT(*) > 10
ORDER BY AVG(p.list_price) DESC;


--Q11. Find products whose list price is higher than the average list price of their own category. 
--Show product_name, category_name, list_price and the category's average price.

SELECT p.product_name,
c.category_name,
p.list_price,
a.avg_price AS category_avg_price
FROM production.products AS p
INNER JOIN production.categories AS c
on p.category_id = c.category_id
INNER JOIN (
SELECT category_id,
AVG(list_price) AS avg_price
FROM production.products 
GROUP BY category_id) AS a
ON a.category_id = p.category_id
WHERE p.list_price > a.avg_price;


--Q12. Find customers who placed at least one order in 2016 but no orders in 2018. Show customer_id, full name, email and state. 
--Write the query twice: once with IN / NOT IN and once with EXISTS / NOT EXISTS


--WITH IN / NOT IN

SELECT customer_id,
first_name + ' ' + last_name AS full_name,
email,
state
FROM sales.customers 
WHERE customer_id IN (
SELECT customer_id
FROM sales.orders
WHERE order_date >= '2016-01-01' AND order_date < '2017-01-01')
AND customer_id NOT IN (
SELECT customer_id 
FROM sales.orders 
WHERE order_date >= '2018-01-01' AND order_date < '2019-01-01'
AND customer_id IS NOT NULL);

--EXITS / NOT EXIST


SELECT c.customer_id,
c.first_name + ' ' + c.last_name AS full_name,
c.email,
c.state
FROM sales.customers AS c
WHERE EXISTS (
SELECT 1
FROM sales.orders AS o
WHERE c.customer_id = o.customer_id AND order_date >= '2016-01-01' AND order_date < '2017-01-01')
AND NOT EXISTS (
SELECT 1
FROM sales.orders AS o
WHERE c.customer_id = o.customer_id AND order_date >= '2018-01-01' AND order_date < '2019-01-01');


--Q13. Using two CTEs in one WITH clause, first calculate the total revenue for each store, then the average of those store totals. 
--Return only the stores whose revenue is above the average, with store_name, total_revenue, average and the difference.

WITH store_revenue AS (
SELECT store_name,
SUM(line_revenue) AS total_revenue
FROM sales.vw_order_line_details 
GROUP BY store_name),

average_store_revenue AS (
SELECT AVG(total_revenue) AS avg_revenue
FROM store_revenue)

SELECT s.store_name,
s.total_revenue,
a.avg_revenue,
s.total_revenue - a.avg_revenue AS difference
FROM store_revenue AS s
CROSS JOIN average_store_revenue AS a
WHERE s.total_revenue > a.avg_revenue 
ORDER BY difference DESC;


--Q14. Using a recursive CTE, build the staff hierarchy starting from the staff member with no manager.
--Show staff_id, staff full name, manager_id, level (top = 1) and a reporting path such as Fabiola Jackson > Mireya Copeland > Genna Serrano.


WITH hierarchy AS (
SELECT staff_id,
first_name + ' ' + last_name AS full_name,
manager_id,
1 AS level,
CAST(first_name + ' ' + last_name AS VARCHAR(300)) AS reporting_path
FROM sales.staffs
WHERE manager_id is NULL

UNION ALL 

SELECT s.staff_id,
s.first_name + ' ' + s.last_name AS full_name,
s.manager_id,
h.level + 1,
CAST(h.reporting_path + '>' + s.first_name + ' ' + s.last_name AS VARCHAR(300))
FROM sales.staffs AS s
INNER JOIN hierarchy AS h
ON s.manager_id = h.staff_id
)
SELECT staff_id,
full_name,
manager_id,
level,
reporting_path
FROM hierarchy 
ORDER BY level,staff_id;



--Q15. (a) Using a CTE with a window function, find the top 3 products by 2017 revenue within each category. 
--Show category_name, product_name, total quantity, total revenue and rank. 

WITH ranked AS (
SELECT category_name,
product_name,
SUM(quantity) AS total_quantity,
SUM(line_revenue) AS total_revenue,
RANK() OVER (PARTITION BY category_name ORDER BY SUM(line_revenue) DESC) AS revenue_rank
FROM sales.vw_order_line_details 
WHERE order_date >= '2017-01-01' AND order_date < '2018-01-01'
GROUP BY category_name,product_name)

SELECT * FROM ranked
WHERE revenue_rank <= 3
ORDER BY category_name, revenue_rank;




--Q15.(b) Using a recursive CTE that generates months 1 to 12, show the total orders and total revenue for every month of 2017, with month number and month name, showing 0 for months with no sales.

WITH months AS (
SELECT 1 as month_no
UNION ALL 
SELECT month_no + 1
FROM months 
WHERE month_no > 12)

SELECT 
m.month_no,
DATENAME(MONTH ,DATEFROMPARTS(2017, m.month_no, 1)) AS month_name,
COUNT(DISTINCT v.order_id) AS total_orders,
ISNULL(SUM(v.line_revenue), 0) AS total_revenue
FROM months AS m
LEFT JOIN sales.vw_order_line_details AS v
ON MONTH(v.order_date) = m.month_no AND YEAR(order_date) = 2017
GROUP BY m.month_no
ORDER BY m.month_no;