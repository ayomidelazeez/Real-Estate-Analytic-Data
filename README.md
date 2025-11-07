# Real-Estate-Analytic-Data
# 🏠 Real Estate SQL Insights & Performance Dashboard

## 📋 Project Overview
This project analyzes real estate performance data using SQL. It explores **key business metrics** such as:
- Total and average revenue
- Top-performing agents
- Most expensive properties
- Buyer purchasing behavior
- City-wise sales performance

The insights were later visualized in a Power BI dashboard for better data storytelling and decision-making.

---

## 🗃️ Dataset Information
The dataset contains four main tables:
- **TRANSACTIONS** — records of property sales
- **AGENTS** — details of real estate agents
- **BUYERS** — information on property buyers
- **PROPERTIES** — data on properties listed and sold

A combined **FULLDETAILS** view was created to join all key entities for analysis.

---

## 🧩 SQL Highlights
Key queries and operations included:
- Creating database and tables
- Joining datasets using `LEFT JOIN`
- Calculating total revenue, average price, and top performers
- Identifying buyers with multiple purchases
- City-level and agent-level performance analysis

Example SQL snippets:

```sql
-- Total Revenue Generated
SELECT SUM(sale_price) AS total_revenue FROM fulldetails;

-- Top Performing Agents
SELECT agents_first_name, agents_last_name, 
       SUM(sale_price) AS total_sales
FROM fulldetails
GROUP BY agents_first_name, agents_last_name
ORDER BY total_sales DESC
LIMIT 5;

-- Average Sale Price per City
SELECT city, AVG(sale_price) AS avg_price
FROM fulldetails
GROUP BY city
ORDER BY avg_price DESC;

