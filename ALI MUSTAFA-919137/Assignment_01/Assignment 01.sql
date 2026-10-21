---------CHAPTER 01 EXERCISE------------
--1.1
SELECT product_name,list_price, list_price/1000 AS price_in_thousand 
FROM PRODUCTION.products;

--1.2
SELECT DISTINCT state FROM sales.customers;

--1.3
SELECT TOP 5 product_name, list_price FROM PRODUCTION.products
ORDER BY list_price ASC;

--1.4
SELECT list_price, category_id FROM PRODUCTION.products
WHERE list_price BETWEEN 200 AND 600 AND category_id IN (1,6);

--1.5
SELECT product_name, category_id, list_price 
FROM PRODUCTION.products 
WHERE category_id IN (1,6) AND list_price < 1000; 

--1.6
SELECT email, last_name FROM sales.customers
WHERE email LIKE '%.com' AND last_name LIKE 'M%';

--1.7
SELECT product_name, list_price FROM PRODUCTION.products
ORDER BY list_price DESC
OFFSET 11 ROWS FETCH NEXT 20 ROWS ONLY;

--1.8
SELECT order_id, discount FROM sales.order_items
WHERE discount IS NOT NULL;