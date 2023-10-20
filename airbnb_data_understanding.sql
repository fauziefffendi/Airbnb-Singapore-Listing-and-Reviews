-- use database listing_airbnb
use listing_airbnb

-- Total listing property
select count(id) as Total_listing_property 
from listing_property

-- Total host property owner
select count(distinct host_id) as Total_Host
from listing_property

-- Total neighbourhood
select count(distinct neighbourhood) as Total_neighbourhood  
from listing_property;

-- Total listing property by neighbourhood group 
select n.neighbourhood_group as Neighbourhood_group, count(lp.id) as Total_listing_property 
from listing_property lp 
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
group by n.neighbourhood_group
order by Total_listing_property desc;

-- Total listing property by neighbourhood
select neighbourhood, count(id) as Total_listing_property 
from listing_property
group by neighbourhood 
order by Total_listing_property desc;

-- Average price of listing by neighbourhood group
select n.neighbourhood_group as Neighbourhood_group, avg(lp.price) as AVG_Price 
from listing_property lp
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
group by n.neighbourhood_group 
order by AVG_Price desc;

-- Average price of listing by neighbourhood
select lp.neighbourhood, avg(lp.price) as AVG_Price, n.neighbourhood_group 
from listing_property lp 
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
group by lp.neighbourhood, n.neighbourhood_group
order by AVG_Price desc;

-- basic statistic of price
select min(price) as Minum_price, max(price) as maximum_price, avg(price) as Mean
from listing_property

-- crate price interval/range
alter table listing_property add column
price_range varchar(10);

update listing_property
set price_range=
	case 
		when price between 0 and 100 then '0 - 100'
		when price between 101 and 200 then '101 - 200'
		when price between 201 and 300 then '201 - 300'
		when price between 301 and 400 then '301 - 400'
		else '400 Above'	
	end;
	
-- price distribution listing property
select price_range, count(id) as Total_listing
from listing_property
group by price_range;

-- price distribution by neighbourhood_group
select n.neighbourhood_group, lp.price_range, count(lp.id) as Total_listing
from listing_property lp 
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
group by n.neighbourhood_group, lp.price_range
order by n.neighbourhood_group, lp.price_range;

-- price distribution of property review
select price_range, count(r.date) as Total_reviews 
from listing_property lp 
join reviews r on r.listing_id = lp.id 
group by price_range
order by price_range;

-- price distribution of property review by neighbourhood
select price_range, n.neighbourhood_group, count(r.date) as Total_reviews 
from listing_property lp 
join reviews r on r.listing_id = lp.id
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
group by n.neighbourhood_group, price_range
order by n.neighbourhood_group, price_range;

-- Total reviews by Neighbourhood group 
select lp.neighbourhood, n.neighbourhood_group, count(r.date) as Total_reviews
from listing_property lp 
join neighbourhood n on n.neighbourhood = lp.neighbourhood 
join reviews r on r.listing_id = lp.id 
group by n.neighbourhood_group, lp.neighbourhood
order by Total_reviews desc;


-- Top 10 property with the most reviews
select lp.name as Nama_property, count(r.date) as Total_review 
from listing_property lp 
join reviews r on lp.id = r.listing_id
group by lp.name
order by Total_review desc
limit 10;

-- Top 10 reiews by host
select lp.host_name, count(r.date) as Total_reviews
from listing_property lp 
join reviews r on r.listing_id = lp.id 
group by lp.host_name
order by Total_reviews desc
limit 10;