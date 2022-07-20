select city,
count( distinct order_id) as number_orders,
sum(sales) as revenue
from public.orders o
where category in ('Furniture')
and extract('year' from order_date) = 2018
group by 1
having sum(sales) > 10000
order by revenue desc;

select distinct
count(*),
count (distinct o.order_id)
from orders o
where order_id in(select distinct order_id from "returns" );

select avg(discount) as avg_disc
from orders ;
-- 0,1562

select distinct category, sum(sales), 
to_char(ship_date,'YYYY-MM') as year_month from orders
where ship_date is not null
group by year_month, category
order by year_month
;

select profit, order_id
from orders o
where extract('year' from ship_date) = 2020
group by 1, 2
order by 1 desc
;

select returned, product_name
from returns as r , 
lateral (select * from orders as o where r.order_id = o.order_id) product
group by 1, 2
order by 1
;
