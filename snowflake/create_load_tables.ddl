--***********************************
--* create load tables
--***********************************

use role sysadmin
;

use warehouse convex_load_dwh
;

use database convex
;

use schema load
;

CREATE OR REPLACE TABLE raw_transactions 
( txn_data   VARIANT )
;


create or replace table exp_transactions
( customer_id       varchar(20) primary key
, product_id        varchar(20)
, price             decimal(13,2)
, date_of_purchase  date
)
;


create or replace table customers 
( customer_id	   VARCHAR(8) primary key
, loyalty_score    smallint 
)
;


create or replace table products 
( product_id	         VARCHAR(8) primary key
, product_description    VARCHAR(40) 
, product_category       VARCHAR(20)
)
;
