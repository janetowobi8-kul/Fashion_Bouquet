SELECT *
FROM fashion_boutique_dataset


UPDATE fashion_boutique_dataset
SET size = 'Unknown'
WHERE size IS NULL;

SELECT product_id,count(*)
from fashion_boutique_dataset
group by product_id
having count(*)>1


SELECT product_id, original_price, markdown_percentage, current_price,
       ROUND(original_price * (1 - markdown_percentage/100), 2) AS expected_price
FROM fashion_boutique_dataset
WHERE ROUND(original_price * (1 - markdown_percentage/100), 2) <> current_price;

UPDATE fashion_boutique_dataset
SET current_price = ROUND(original_price * (1 - markdown_percentage/100), 2)
WHERE ROUND(original_price * (1 - markdown_percentage/100), 2) <> current_price;


--KPI's
SELECT SUM(current_price * stock_quantity) AS total_revenue
FROM fashion_boutique_dataset;

SELECT COUNT(DISTINCT category) AS unique_products
FROM fashion_boutique_dataset;

SELECT COUNT(DISTINCT brand) AS unique_brand
FROM fashion_boutique_dataset;


SELECT MAX(current_price) AS highest_price, MIN(current_price) AS lowest_price
FROM fashion_boutique_dataset;





--BUSINESS QUESTIONS 

--1. Which categories have the highest total stock available?
SELECT 
    category, 
    sum(stock_quantity) AS total_stock
FROM fashion_boutique_dataset
GROUP BY category
ORDER BY total_stock DESC;


--2.Which brands have the most products in stock?

SELECT 
    brand,
    SUM(stock_quantity) AS total_stock
FROM fashion_boutique_dataset
GROUP BY brand
ORDER BY total_stock DESC;


--3.What is the average price per category?
SELECT 
    category,
    AVG(current_price) AS avg_price
FROM fashion_boutique_dataset
GROUP BY category
ORDER BY avg_price DESC;


--4. What is the average customer rating for each brand?

SELECT brand,
AVG(customer_rating) AS avg_rating
FROM fashion_boutique_dataset
GROUP BY brand 
ORDER BY avg_rating desc



--5.Which colors are most common in the inventory?
SELECT 
    color,
    COUNT(*) AS product_count
FROM fashion_boutique_dataset
GROUP BY color
ORDER BY product_count DESC;

--6.Which sizes are most frequently available?
SELECT
     size,
	 COUNT(*) AS product_count 
from fashion_boutique_dataset
group by size
order by product_count desc


--7. Which categories have the highest average markdown percentage?

SELECT 
    category,
    ROUND(AVG(markdown_percentage), 2) AS avg_markdown_percentage
FROM fashion_boutique_dataset
GROUP BY category
ORDER BY avg_markdown_percentage DESC;



--8. How does average current price vary by season?
SELECT 
    season,
    AVG(current_price) AS avg_current_price
FROM fashion_boutique_dataset
GROUP BY season
ORDER BY avg_current_price DESC;

--9. What are the top reasons for returns?

SELECT 
    return_reason,
    COUNT(*) AS return_count
FROM fashion_boutique_dataset
GROUP BY return_reason
ORDER BY return_count DESC;


--10. Which categories have the highest return rates?

SELECT 
    category,
    COUNT(CASE WHEN is_returned = 'TRUE' THEN 1 END) * 1.0 / COUNT(*) AS return_rate
FROM fashion_boutique_dataset
GROUP BY category
ORDER BY return_rate desc;


--11.How has the total number of products sold changed over time (season)?
-- By Season
SELECT 
    season,
    COUNT(product_id) AS total_products_sold
FROM fashion_boutique_dataset
GROUP BY season
ORDER BY total_products_sold DESC;


--12. Are markdown percentages increasing during certain periods (e.g., end of season sales)?
-- By Season
SELECT 
    season,
    ROUND(AVG(markdown_percentage), 2) AS avg_markdown
FROM fashion_boutique_dataset
GROUP BY season
ORDER BY avg_markdown DESC;

--13Which categories show growing popularity over the past seasons?

SELECT 
    season,
    category,
    COUNT(product_id) AS total_products_sold
FROM fashion_boutique_dataset
GROUP BY season, category
ORDER BY season, total_products_sold DESC;
