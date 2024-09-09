-- 1
select
	first_name,
	encode(digest('test11',
	'sha1'),
	'hex')
from
	client
where
	first_name = 'Muriel';

-- 2
select
	last_name,
	count(*)
from
	order_line
group by
	last_name
having
	count(*)>1;  

-- 3
update
	order_line
set
	total_price = (quantity * unit_price);

-- 4
select co.id as order_id, 
       co.purchase_date, 
       c.first_name, 
       c.last_name, 
       SUM(ol.total_price) as total_order_price
from customer_order co
join client c on co.client_id = c.id
join order_line ol on co.id = ol.order_id
group by co.id, co.purchase_date, c.first_name, c.last_name;

-- 5
select
	extract(month
from
	co.purchase_date) as month,
	sum(ol.total_price) as total_order_price
from
	customer_order co
join order_line ol on
	co.id = ol.order_id
group by
	month;

-- 6
select
	c.first_name,
	c.last_name,
	sum(ol.total_price) as total_order_amount
from
	client c
join customer_order co on
	c.id = co.client_id
join order_line ol on
	co.id = ol.order_id
group by
	c.id,
	c.first_name,
	c.last_name
order by
	total_order_amount desc
limit 10;

-- 7
select
	extract(day
from
	co.purchase_date) as day,
	sum(ol.total_price) as total_price_order
from
	customer_order co
join order_line ol on
	co.id = ol.order_id
group by
	day
;

-- 8
alter table order_line 
add column category int4;

-- 9
update order_line 
set category = case 
	when total_price < 200 then 1
	when total_price >= 200 and total_price < 500 then 2
	when total_price >= 500 and total_price < 1000 then 3
	when total_price >= 1000 then 4
	else -1
end;
