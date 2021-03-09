--***********************************
--* Set up load and prod environment
--***********************************
use role sysadmin
;

use warehouse convex_load_dwh
;

create or replace database convex
;

use database convex
;

create or replace schema load
;

create or replace schema prod
;

--***********************************
--* Set up load warehouse
--***********************************
CREATE or replace WAREHOUSE convex_load_dwh WITH
WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 600
AUTO_RESUME = TRUE
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 4
SCALING_POLICY = 'STANDARD'
COMMENT = 'warehouse for loading tables'
;

--***********************************
--* Set up compute warehouse
--***********************************
CREATE or replace WAREHOUSE convex_compute_dwh WITH
WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 600
AUTO_RESUME = TRUE
MIN_CLUSTER_COUNT = 1
MAX_CLUSTER_COUNT = 4
SCALING_POLICY = 'STANDARD'
COMMENT = 'warehouse for populating tables'
;


--***********************************
--* Set up stages
--***********************************
CREATE OR REPLACE STAGE S3_LOAD_STAGE
URL = 's3://convins/load' 
CREDENTIALS = ( AWS_KEY_ID = 'AKIAIDWOGKIYOLJOWPFQ'
                AWS_SECRET_KEY = 'YOVuKdvDCxP20T/Mf+ZFeCNYqiom9XmonxevH2Sd')
;

--***********************************
--* Set up stages
--***********************************
CREATE FILE FORMAT CSV_LOAD_HEAD
COMPRESSION = 'NONE'
FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
ESCAPE = 'NONE'
ESCAPE_UNENCLOSED_FIELD = 'NONE'
DATE_FORMAT = 'YYYY-MM-DD'
TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF9'
NULL_IF = ('')
COMMENT = 'Standard format for loading CSV data (excluding header ) to Data Warehouse'
;
