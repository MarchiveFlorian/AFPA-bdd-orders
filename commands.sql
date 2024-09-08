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