	SELECT
	S.store_name,
	s.phone,
	s.email,
	p.quantity,
	s.store_id
	FROM
	sales.stores AS S
	left join
	production.stocks As p
	on s.store_id = p.store_id
	where p.quantity is Null;


SELECT
p.product_name,
p.product_id,
s.quantity
FROM production.products AS p
left JOIN production.stocks AS s
    ON p.product_id = s.product_id
WHERE s.quantity IS NULL;

--------------------------------------  right join
	SELECT
    p.product_name,
    oi.order_id
FROM sales.order_items AS oi
RIGHT JOIN production.products AS p
    ON oi.product_id = p.product_id
WHERE oi.order_id IS NULL;


-------------cross join ----

SELECT
    s.store_name,
    c.category_name
FROM sales.stores AS s
CROSS JOIN production.categories AS c;









SELECT e.first_name + ' '+  e.last_name as full_employee_name,
m.first_name +' '+ m.last_name as full_manager_name 
FROM  sales.staffs as e 
LEFT JOIN sales.staffs as m  
on  m.staff_id = e.manager_id 

select * from sales.staffs;



select 
c.customer_id,
c.city,
o.order_id,
o.order_status,
o.order_date,
oi.list_price,
oi.product_id,
p.product_name,
cc.category_name
from 
sales.customers as c LEFT JOIN 
sales.orders AS o on 
c.customer_id = o.customer_id
inner join  sales.order_items as oi
on  o.order_id = oi.order_id
inner join production.products as p
on oi.product_id = p.product_id 
inner  join production.categories as cc
on p.category_id = cc.category_id

