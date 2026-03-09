create database zepto_project;
show databases;
use  zepto_project;

-- first 10 data from table
select* from zepto
limit 10;

-- categorys from zepto
select distinct category from zepto
group by category;

-- counting all rows from table
select count(*) from zepto;

-- outofstock checking boolean
select outOfStock,count(id) from zepto
group by outOfStock;

-- changed the column name id to sku_id
alter table zepto
change column id sku_id int primary key;

-- product names present multiple times
select name,count(sku_id) as no_of_duplicates from zepto
group by name
having no_of_duplicates >  1
order by no_of_duplicates desc;

-- data cleaning

-- products with price = 0

select * from zepto
where mrp=0 or discountedSellingPrice=0;
-- deleted the price 0 values here
SET SQL_SAFE_UPDATES = 0;               -- turn it safe update/delete off
delete from zepto
where mrp=0;
SET SQL_SAFE_UPDATES = 1;               -- turn it back  safe update/delete on


-- convert paise to rupees
update zepto
set mrp=mrp/100,
discountedSellingPrice = discountedSellingPrice/100 ; 

select mrp,discountPercent,discountedSellingPrice from zepto;


-- business questions from data 

-- Q1 top 10 best discountpercent products from zepto

select distinct name,mrp,discountpercent from zepto 
order by discountpercent desc
limit 10;

-- Q2 what are the productshave high mrp but outofstack
select distinct name,mrp from zepto 
where outOfStock = 'TRUE' and mrp >300
order by mrp desc;

-- Q3 calculate estimated revenue of each category

select category,sum(discountedSellingPrice*availableQuantity)as total_revenue from zepto 
group by category;

-- Q4 find all the products where mrp greaterthan 500 and discount lessthan 10

select distinct name,mrp,discountPercent 
from zepto 
where mrp>500 and discountPercent<10
order by mrp desc,discountPercent desc;

-- Q5 find the top 5 category offering highest  avg discount percentage

select category,round(avg(discountPercent),2) as discount from zepto
group by category
order by discount desc
limit 5;

-- Q6 find the price per gram for products above 100grms and sort by best value 

select distinct name,weightInGms,discountedSellingprice,
round((discountedSellingprice/weightingms),2) as price_per_gms
from zepto 
where weightingms >= 100
order by price_per_gms desc;


-- Q7 group the products into category like low,medium,bulk by weight
select distinct name,weightingms,
case
    when weightingms < 1000 then 'low'
    when weightingms < 5000 then 'medium'
    else 'bulk'
end as weight_category
from zepto
order by weight_category;

-- Q8 what is the total inventory weight per category
select category,sum(weightingms*availablequantity) as total_weight from zepto
group by category;
    












