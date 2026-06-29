/*
===========================================
 RetailCo Database Setup
===========================================
*/

USE prac;

-- Create Sales Table
create table if not exists sales_transc(
order_id int, # modified the datatype into varchar(20), below is the query for the same
o_date date,
region varchar(20),
category varchar(50),
product varchar(50),
units int,
unit_price float,
revenue float,
discount float,
customer_type varchar(20)
);

-- Load Sales Data
LOAD DATA LOCAL INFILE '/private/tmp/Claude data analysis project/sales_transactions.csv'
INTO TABLE sales_transc
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Create Customer Table
create table if not exists cust_master(
customer_id varchar(20),
city varchar(20),
region varchar(20),
age_group varchar(10),
member_since int,
total_orders int,
lifetime_value float,
last_purchase varchar(20),
c_status varchar(20)
);

-- Load Customer Data
LOAD DATA LOCAL INFILE '/private/tmp/Claude data analysis project/customer_master.csv'
INTO TABLE cust_master
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Create Marketing Spend Table
create table if not exists marketing_spend(
m_month varchar(20),
region varchar(10),
m_channel varchar(20),
spend float,
impressions int,
clicks int,
conversions int);

-- Load Marketing Spend Data
load data local infile '/private/tmp/Claude data analysis project/marketing_spend.csv'
into table marketing_spend
fields terminated by ','
ignore 1 rows;


-- Create Regional Targets Table
create table if not exists regional_target(
rt_year year,
region varchar(10),
category varchar(50),
target int,
actual int,
achivement_percent float,
yoy_growth_percent float
);

-- Load Regional Targets Data
load data local infile '/private/tmp/regional_targets.csv'
into table regional_target
fields terminated by ','
ignore 1 rows;