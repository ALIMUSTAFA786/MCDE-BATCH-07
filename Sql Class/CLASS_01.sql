SELECT * FROM PRODUCTION.products;

SELECT product_id,
product_name, list_price
FROM production.products;

SELECT product_id, product_name, 
list_price 
from production.products;
 ------------ distinct
SELECT DISTINCT CATEGORY_ID FROM production.products;


------ SORTING---

SELECT PRODUCT_ID, PRODUCT_NAME,LIST_PRICE, BRAND_ID FROM 
PRODUCTION.products
ORDER BY LIST_PRICE DESC ;

--------LIMIT-----

SELECT TOP 10 PRODUCT_NAME, 
PRODUCT_ID, 
LIST_PRICE FROM 
production.products;

SELECT TOP 3 product_name, list_price
FROM production.products
ORDER BY list_price DESC;


SELECT product_name, list_price
FROM production.products
ORDER BY list_price DESC
OFFSET 10 ROWS FETCH NEXT 3 ROWS ONLY;
---------  WHERE CLAUSE---------

SELECT * FROM 
[sales].[orders] 
WHERE customer_id = 5;
------------------
-----------AND ,OR, NOT-----------------

SELECT product_name, category_id
FROM production.products
WHERE category_id = 1 AND category_id = 3;


-- Intention: category 6 or 3, but only under $1000
SELECT product_name, category_id, list_price
FROM production.products
WHERE category_id = 6 OR category_id = 3 AND list_price < 1000;













SELECT * FROM [production].[brands]



