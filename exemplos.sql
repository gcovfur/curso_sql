--SELECT, WHERE, GROUP BY e COUNT
-- Exemplo 1: Select limitando o número de linhas apresentados
select * from olist_customers_dataset limit 100;
-------------------------------------------------------------------------------------------------
-- Exemplo 2: Select com filtro
select
*
from
olist_customers_dataset
where 
customer_state = 'SP'
limit 100;
-------------------------------------------------------------------------------------------------
-- Exemplo 3: Função Count para verificar o filtro
select
count(*)
from
olist_customers_dataset;
-------------------------------------------------------------------------------------------------
select
count(*)
from
olist_customers_dataset
where 
customer_state = 'SP';
-------------------------------------------------------------------------------------------------
--Exemplo 4: Usando funções de agregação (MAX, MIN, AVG, SUM)
select 
min(payment_value) as min -- max(payment_value), avg(payment_value), sum(pay_value) 
from 
olist_order_payments_dataset;
-------------------------------------------------------------------------------------------------
--Exemplo 5: group by
select 
payment_type,
avg(payment_value) as avg
from 
olist_order_payments_dataset
group by
payment_type;
-------------------------------------------------------------------------------------------------
-- Exemplo 6: having
select 
*,
avg(payment_value) as media
from 
olist_order_payments_dataset
group by 
order_id
having 
avg(payment_value) > 100;
-------------------------------------------------------------------------------------------------
--Exemplo 7: Usando operadores lógicos 
select 
*
from 
olist_order_payments_dataset
where 
--payment_value > 100;
-- payment_value < 100;
-- payment_installments != 2;
payment_installments == 2;
-------------------------------------------------------------------------------------------------
-- Exemplo 8: LIKE e NOT LIKE
select 
*
from 
olist_order_payments_dataset
where 
payment_type not like '%credit%';
-------------------------------------------------------------------------------------------------
--Exemplo 9: concat (alguns bancos suportam concat, não é o caso do Sqlite), coalesce
select 
*,
coalesce(product_name_lenght,0) as coalesce,
product_weight_g || product_length_cm as concat
from 
olist_products_dataset
where
product_name_lenght is null;
-------------------------------------------------------------------------------------------------
--Exemplo 10: junção de bases de dados por INNER, LEFT, FULL OULTER, RIGHT JOIN
select 
*
from 
olist_customers_dataset ocd
join olist_orders_dataset ood on ocd.customer_id = ood.customer_id;
-------------------------------------------------------------------------------------------------
--Exemplo 11: between
select 
* 
from 
olist_orders_dataset
where order_purchase_timestamp between '2017-01-01' and '2017-01-31';
-------------------------------------------------------------------------------------------------
--Exemplo 12: casting
select 
customer_zip_code_prefix,
cast(customer_zip_code_prefix as integer) as czcp_int
from 
olist_customers_dataset
limit 100;

-------------------------------------------------------------------------------------------------
--Exemplo 13: subquery
select 
*,
(select current_date) as data_hoje
from 
olist_customers_dataset
limit 100;
-------------------------------------------------------------------------------------------------
--Exemplo 13: with clause
with data_hoje as(
  select
  'franca' as customer_city,
  current_date as data_hoje
)
select 
*
from 
olist_customers_dataset ocd
join data_hoje on ocd.customer_city = data_hoje.customer_city;
-------------------------------------------------------------------------------------------------
--Exemplo 13: case when
select 
*,
case 
  when customer_city = 'franca' then 'cidade do basquete'
  else 'outra cidade qualquer'
end as caracteristica
from 
olist_customers_dataset ocd
limit 1000;
