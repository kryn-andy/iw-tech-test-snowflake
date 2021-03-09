--******************************************
--* propulate from load to prod target tables
--******************************************

--******************************************
--* flatten the raw transactions
--******************************************
use role sysadmin
;

use WAREHOUSE convex_compute_dwh
;

use database convex
;

use schema load
;


truncate exp_transactions
;


insert into exp_transactions
SELECT txn_data:customer_id::string     as customer_id
     , VALUE:product_id::String         as product_id
     , VALUE:price::decimal(13,2)       as price
     , txn_data:date_of_purchase::Date  as date_of_purchase
FROM   RAW_TRANSACTIONS
   , LATERAL FLATTEN( INPUT => txn_data:basket )
;


--******************************************
--* Populate target prod transactions
--* Check to see if rows already exist in 
--* case of a re-run
--******************************************
insert into convex.prod.transactions
     ( customer_id
     , product_id
     , price
     , date_of_purchase
     )
select distinct
       tb1.customer_id
     , tb1.product_id
     , tb1.price
     , tb1.date_of_purchase
from   convex.load.exp_transactions tb1
where not exists
  ( select null
    from  convex.prod.transactions tb2
    where tb2.customer_id      = tb1.customer_id
    and   tb2.product_id       = tb1.product_id
    and   tb2.price            = tb1.price
    and   tb2.date_of_purchase = tb1.date_of_purchase
  )
;



--************************************************
--* Populate target prod customers from load table
--* Check to see if rows already exist in
--* case of a re-run
--************************************************
insert into convex.prod.customers
     ( customer_id
     , loyalty_score
     )
select distinct
       tb1.customer_id
     , tb1.loyalty_score
from   convex.load.customers tb1
where not exists
  ( select null
    from  convex.prod.customers tb2
    where tb2.customer_id = tb1.customer_id
  )
;

--***********************************************
--* Populate target prod products from load table
--* Check to see if rows already exist in
--* case of a re-run
--***********************************************
insert into convex.prod.products
     ( product_id
     , product_description
     , product_category
     )
select distinct
       product_id
     , product_description
     , product_category
from   convex.load.products tb1
where not exists
  ( select null
    from  convex.prod.products tb2
    where tb2.product_id = tb1.product_id
  )
;

