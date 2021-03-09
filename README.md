# Snowflake Data Test - Starter Project

### Prerequisites

#### Python 3.8.* or later.

See installation instructions at: https://www.python.org/downloads/

Check you have python3 installed:

```bash
python3 --version
```

### Dependencies and data

#### Creating a virtual environment

Ensure your pip (package manager) is up to date:

```bash
pip3 install --upgrade pip
```

To check your pip version run:

```bash
pip3 --version
```

Create the virtual environment in the root of the cloned project:

```bash
python3 -m venv .venv
```

#### Activating the newly created virtual environment

You always want your virtual environment to be active when working on this project.

```bash
source ./.venv/bin/activate
```

#### Installing Python requirements

This will install some of the packages you might find useful:

```bash
pip3 install -r ./requirements.txt
```


#### Generating the data

A data generator is included as part of the project in `./input_data_generator/main_data_generator.py`
This allows you to generate a configurable number of months of data.
Although the technical test specification mentions 6 months of data, it's best to generate
less than that initially to help improve the debugging process.

To run the data generator use:

```bash
python ./input_data_generator/main_data_generator.py
```

This should produce customers, products and transaction data under `./input_data/starter`



#### Getting started

Please save Snowflake model code in `snowflake` and infrastructure code in `infra` folder.

Update this README as code evolves.


#### Additional comments by kryn-andy
```bash
NB A bug was identified in main_data_generator.py
When running the script it failed with
python ./input_data_generator/main_data_generator.py
Traceback (most recent call last):
  File "./input_data_generator/main_data_generator.py", line 108, in <module>
    generate_transactions(
KeyError: 'bws'

There was no dictionary entry for bws in main_data_generator.py
The code was amended and run to completion.
```
#### Additional requiremenst for the project are:
```bash
1.	Install AWS CLI
2.	Install SNOWFLAKE cli
3.	AWS s3 bucket called convins with sub folders /load/trasactions

4.	Add a connetion string to ~/.snowsql/config file ie
```
```bash
[connections.convex]
accountname = *******
username = *****
password = *********
region = eu-west-1
warehousename = CONVEX_LOAD_DWH
dbnane = CONVEX

This will allow the snowflake code to connect to the snowflake environment
```

```bash
5.	Create a file ~/virtualenv/.convex/.Env containing:
    export SQL_DIR=~/virtualenv/.convex/snowflake
    export SQL_ETC=~/virtualenv/.convex/infra
	This is to set up additional environmental variables
```
```bash
6.	The following modules have been created in ~/virtualenv/.infinity/infra
  a.	build_convex_environment.sh
  b.	s3_copy_customers.sh
  c.	s3_copy_products.sh
  d.	s3_copy_transactions.sh
  e.	load_customers.sh
  f.	load_products.sh
  g.	load_transactions.sh
  h.	populate_target_tables.sh
	Module runs once to build the snowflake environment.
  Modules b to f  have been broken down to their particular function so that they can be re-run if necessary and also as part of a schedule. 
```
```bash
7.	The following modules have been created in ~/virtualenv/.infinity/snowflake
  a.	create_environment.sql
  b.	create_load_tables.ddl
  c.	create_prod_tables.ddl
  d.	create_prod_views.ddl
  e.	populate_target_tables.sql

Modules a to d are run within the build_convex_environment.sh to create the snowflake environment.
Module populate_target_tables.sql inserts data to the prod target 
tables from the load tables.
```
```bash
8.	A view has been created called convex.prod.customer_summary has been created to provide the required customer summary data.
```

#### Running the code
	Change to directory ~/virtualenv/.infinity/infra
	Run the following modules in order using./
```bash
  build_convex_environment.sh
```
```bash
  s3_copy_customers.sh
	This will copy customer data to s3 convins/load/
``` 
```bash
   s3_copy_products.sh
	This will copy products data to s3 convins/load/
``` 
```bash
s3_copy_transactions.sh
	This will copy customer data to s3 convins/load/trasactions/*
```
```bash
   load_customers.sh
``` 
```bash
   load_products.sh
``` 
```bash
   load_transactions.sh
``` 
```bash
   populate_target_tables.sh
``` 
