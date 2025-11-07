CREATE DATABASE REAL_ESTATE;
USE REAL_ESTATE;
SELECT * FROM TRANSACTIONS;
SELECT * FROM AGENTS;
SELECT * FROM BUYERS;
SELECT * FROM PROPERTIES;
CREATE VIEW FULLDETAILS AS
SELECT
TRANSACTIONS.TRANSACTION_ID,
TRANSACTIONS.SALE_PRICE,
TRANSACTIONS.SALE_DATE,
BUYERS.BUYER_ID,
BUYERS.FIRST_NAME AS BUYERS_FIRST_NAME,
BUYERS.LAST_NAME AS BUYERS_LAST_NAME,
BUYERS.BUDGET,
PROPERTIES.PROPERTY_ID,
PROPERTIES.ADDRESS,
PROPERTIES.CITY,
PROPERTIES.PRICE,
AGENTS.AGENT_ID,
AGENTS.FIRST_NAME AS
AGENTS_FIRST_NAME,
AGENTS.LAST_NAME AS
AGENTS_LAST_NAME,
AGENTS.EMAIL
FROM BUYERS
LEFT JOIN TRANSACTIONS ON BUYERS.BUYER_ID
=TRANSACTIONS.BUYER_ID
LEFT JOIN PROPERTIES ON 
TRANSACTIONS.PROPERTY_ID=
PROPERTIES.PROPERTY_ID
LEFT JOIN AGENTS ON PROPERTIES.AGENT_ID=
AGENTS.AGENT_ID;
SELECT * FROM PROPERTIES;
SELECT * FROM FULLDETAILS;
SELECT COUNT(DISTINCT PROPERTY_ID)FROM FULLDETAILS;
SELECT COUNT(DISTINCT PROPERTY_ID)FROM FULLDETAILS WHERE TRANSACTION_ID IS NOT NULL;
-- Find the top expensive properties 
SELECT DISTINCT PROPERTY_id,sale_price as top_expensive_properties from fulldetails
order by sale_price desc
limit 5;
-- Identify the top-performing agents.
SELECT agents_first_name,agents_last_name, 
sum(sale_price) as top_performing_agents from fulldetails
group by agents_first_name,agents_last_name
order by top_performing_agents desc
limit 6;
-- What is the total revenue generated from property sales?
select sum(sale_price) as total_revenue from fulldetails;
-- how many properties were sold by each agents
SELECT agents_first_name,agents_last_name, count(distinct property_id) as properties_sold_by_agents from fulldetails
where agents_first_name is not null and agents_last_name is not null
group by agents_first_name,agents_last_name
order by properties_sold_by_agents desc
limit 5;
-- What is the average sale price of properties in each city?
select city, avg(sale_price) as avg_sale_price from fulldetails
group by city
order by avg_sale_price desc
limit 10;
select * from fulldetails;
  -- Which buyers purchased multiple properties?
SELECT buyers_first_name,buyers_last_name,
       COUNT(distinct property_id) AS properties_bought
FROM fulldetails
WHERE buyer_id IS NOT NULL
GROUP BY buyers_first_name,buyers_last_name
HAVING COUNT(distinct property_id) > 1
order by properties_bought desc
limit 6;
-- What is the highest-priced property sold, and who was the buyer?
SELECT
       buyers_last_name,
       sale_price
FROM fulldetails
order by sale_price desc
limit 1;
--  Which agent had the highest total sales revenue?
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    SUM(t.sale_price) AS total_revenue,
    COUNT(t.transaction_id) AS properties_sold
FROM transactions t
LEFT JOIN properties p ON t.property_id = p.property_id
LEFT JOIN agents a ON p.agent_id = a.agent_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_revenue DESC
LIMIT 1;
