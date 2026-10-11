SELECT * FROM PRODUCTION.PRODUCTS
WHERE  BETWEEN '2018-01-01' AND '2018-03-31';



SELECT * FROM[sales].[orders] WHERE order_date  
BETWEEN '2018-01-01' AND '2018-03-31';


SELECT * 
FROM [sales].[orders] WHERE order_status IN (1,2);


----------

SELECT * 

FROM sales.orders WHERE order_id = 1 OR order_id = 2 AND order_status = 3 OR order_status = 4;

SELECT * FROM sales.orders WHERE order_id IN (1,2) AND order_status IN (3 , 4);


SELECT PRODUCT_NAME, PRODUCT_ID FROM production.products
WHERE PRODUCT_NAME LIKE '%EDNE%';


 ----  FETCH PRODUCT_NAME ITS CATGEGORY AND PRICE LIKN 300 SY 3000 BETWEEN AND 
 ----CATEGORY OS KI 1 HO YA 6 HO  OR  PRODUCT NAME MN FRAME NA AYE.
SELECT
    product_name,
    category_id,
    list_price
FROM production.products
WHERE list_price BETWEEN 300 AND 3000
  AND category_id =1 OR category_id =6
  AND product_name NOT LIKE '%Frame%'
ORDER BY list_price DESC
OFFSET 1 ROWS FETCH NEXT 10 ROWS ONLY;

--------JOINS


----------------------








-------------INNER JOIN----------------
SELECT
    P.product_name,
    C.category_name,
    P.list_price
FROM production.products AS P
INNER JOIN  production.categories AS C
ON  c.category_id = P.category_id;
--------------------------------------------


SELECT
    o.order_id,
    o.order_date,
    s.store_name,
    s.city
FROM sales.orders AS o
INNER JOIN sales.stores AS s
    ON o.store_id = s.store_id
WHERE o.order_id IN (1, 2, 3);

--- Orders kis staff ne treat kia he us staff ka staff id, staff first_name, staff Last_name display
-----kro or phr uske order by b add kro
SELECT
	o.order_id,
	o.order_date,
	s.staff_id,
	s.first_name,
	s.last_name
From sales.orders as o
inner join sales.staffs as s
on o.staff_id = s.staff_id
order by order_id desc
offset 500 rows fetch NEXT 500 rows only;
----------------------------- LEFT JOIN




SELECT
    p.product_name,
    oi.order_id
FROM production.products AS p
LEFT JOIN sales.order_items AS oi
    ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;






