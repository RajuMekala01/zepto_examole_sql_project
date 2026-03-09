# zepto_examole_sql_project

### Project Workflow
* 1. Database Setup

** A database called zepto_project is created and used for the analysis.
```sql
SELECT *
FROM zepto
LIMIT 10;
```

* 2. Data Exploration

Initial queries were performed to understand the dataset.

Examples:

-View first 10 records

-Identify product categories

-Count total records

-Check stock availability

```sql
select * from zepto
limit 10;
```
* 3. Data Cleaning

Some cleaning operations were performed to ensure data quality.

Removing Invalid Price Values

Products with mrp = 0 were removed from the dataset.
```sql
delete from zepto
where mrp = 0;
```
Converting Paise to Rupees

Prices in the dataset were stored in paise, so they were converted to rupees.
```sql
update zepto
set mrp = mrp/100,
discountedSellingPrice = discountedSellingPrice/100;
```
Column Renaming

The column id was renamed to sku_id and set as the primary key.
```sql
alter table zepto
change column id sku_id int primary key;
```
### Business Analysis Queries

Several SQL queries were used to answer business-related questions.

1. Top 10 Products with Highest Discount

Identifies the products offering the highest discounts.
```sql
select name, mrp, discountPercent
from zepto
order by discountPercent desc
limit 10;
```
2. High Price Products That Are Out of Stock

Finds expensive products that are currently unavailable.
```sql
select name, mrp
from zepto
where outOfStock = 'TRUE'
and mrp > 300
order by mrp desc;
```
3. Estimated Revenue by Category

Calculates potential revenue for each product category.
```sql
select category,
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto
group by category;
```
4. Premium Products with Low Discount

Finds expensive products that have minimal discount.
```sql
select name, mrp, discountPercent
from zepto
where mrp > 500
and discountPercent < 10;
```
5. Categories Offering Highest Average Discount

Identifies categories that provide the most discounts.
```sql
select category,
round(avg(discountPercent),2) as discount
from zepto
group by category
order by discount desc
limit 5;
```
6. Best Value Products (Price per Gram)

Calculates value for money based on weight.
```sql
select name,
weightInGms,
discountedSellingPrice,
(discountedSellingPrice/weightInGms) as price_per_gram
from zepto;
```

7. Product Weight Classification

Products are grouped into weight categories.

Low

Medium

Bulk
```sql
case
when weightInGms < 1000 then 'low'
when weightInGms < 5000 then 'medium'
else 'bulk'
end
```
8. Total Inventory Weight by Category

Calculates the total weight of inventory available for each category.
```sql
select category,
sum(weightInGms * availableQuantity) as total_weight
from zepto
group by category;
```
### Key Insights From Analysis

Some products offer very high discounts, which may be used for promotional strategies.

Certain high-value products are out of stock, indicating potential demand.

Categories differ significantly in average discount percentage.

Price-per-gram analysis helps identify the best value products for customers.

Inventory weight analysis helps understand stock distribution across categories.

### Learning Outcomes

This project helped in practicing:

SQL data exploration

Data cleaning techniques

Aggregate functions

Business-focused SQL queries

Analytical thinking with datasets
























