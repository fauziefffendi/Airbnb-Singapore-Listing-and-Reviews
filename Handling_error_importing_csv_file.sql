-- create database listing_airbnb
create database listing_airbnb;

-- use database listing_airbnb
use listing_airbnb;

-- create table
create table listing_property (
id int not null primary key,
name varchar(150) null,
host_id int null,
host_name varchar(150) null,
neighbourhood varchar(30) null,
latitude double null,
longitude double null,
room_type varchar(30) null,
price float null,
minimum_nights int null,
availability_365 int null
);

-- importing data with csv and handling error

-- Error imputing csv file beacause; Data too long for column 'name' at row 2940
-- change data type column name
alter table listing_property 
modify column name varchar(1000) null;

-- Error imputing bacause; Out of range value for column 'id' at row 3297
-- change data type column id
alter table listing_property 
modify column id varchar(50) not null;



-- create table reviews
create table reviews (
listing_id varchar(50) not null,
date date not null
);

-- import data csv file

-- create table neighbourhood
create table neighbourhood (
neighbourhood_group varchar(50),
neighbourhood varchar(50)
);

-- import data csv file

