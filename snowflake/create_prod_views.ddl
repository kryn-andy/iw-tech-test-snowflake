--*******************
--* Create prod views
--*******************

use role sysadmin
;

use warehouse convex_load_dwh
;

use database convex
;

use schema prod
;

create or replace view customer_summary as
select cust.customer_id
     , cust.loyalty_score
     , prod.product_id
     , upper(substr(prod.product_category,1,1)) as product_category
     , count(*)                                 as purchase_count
from       customers     cust
inner join transactions  tran on tran.customer_id = cust.customer_id
inner join products      prod on prod.product_id = tran.product_id
group by cust.customer_id
       , cust.loyalty_score
       , prod.product_id
       , prod.product_category
order by cust.customer_id
       , cust.loyalty_score
       , prod.product_id
        , prod.product_category
;
