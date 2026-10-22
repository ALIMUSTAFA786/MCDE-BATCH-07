--2.1
SELECT 
p.product_name,
b.brand_name
FROM production.products AS p
INNER JOIN production.brands AS b
ON p.brand_id = b.brand_id;


--2.2
SELECT st.store_name,
s.staff_id,
s.first_name + ' ' + s.last_name AS full_name
FROM sales.stores AS st
LEFT JOIN sales.staffs AS s
ON st.store_id = s.store_id
WHERE s.staff_id IS NULL;

--2.3
--In previous query it returns all every products regardless of stock level because of LEFT JOIN but when we use INNER JOIN  it only returns common product_id rows between two tables and products fewer than 5 units in stock at store 1.
SELECT p.product_name, s.quantity
FROM production.products AS p
INNER JOIN production.stocks AS s
ON p.product_id = s.product_id AND s.quantity < 5 AND s.store_id = 1;

--2.4

SELECT
e.first_name + ' ' + e.last_name AS Employee,
m.first_name + ' ' + m.last_name AS Manager,
1 AS employee_count
FROM sales.staffs AS e
INNER JOIN sales.staffs AS m
ON m.staff_id = e.manager_id;

--2.5
SELECT o.order_id,p.product_name,oi.list_price FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
ON o.order_id = oi.order_id AND oi.order_id = 1
INNER JOIN production.products AS p
ON p.product_id = oi.product_id;

--2.6
SELECT COUNT(DISTINCT o.order_id) AS total_orders
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
ON o.order_id = oi.order_id 
WHERE o.order_date >= '2018-01-01' AND o.order_date < '2018-12-28';


--2.7 
--CROSS JOIN is used when we want to match every row of Table A  with every row of Table B
--Example: If we have 3 products and stores are 4 so CROSS JOIN can show every product-store combination
SELECT p.product_name,
s.store_name
FROM PRODUCTION.products AS p
CROSS JOIN sales.stores s;