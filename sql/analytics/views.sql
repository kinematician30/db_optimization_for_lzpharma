-- Analytics Questions
CREATE SCHEMA IF NOT EXISTS analytics;
-- Monthly Drug Sales (drug id, drug name, order_date[month], quantity, revenue) - (drugs, orders)
CREATE MATERIALIZED VIEW analytics.monthly_drug_sales AS
SELECT 
	d.drug_id,
	d.name AS drug_name,
	TO_CHAR(o.order_datetime, 'Month') AS Month,
	SUM(o.total_amount) AS revenue,
	AVG(o.total_amount) AS avg_revenue,
	COUNT(d.drug_id) AS quantity_sold
FROM operations.orders o
JOIN inventory.drugs d
ON o.drug_id = d.drug_id
GROUP BY 
	d.drug_id, d.name, 
	TO_CHAR(o.order_datetime, 'Month');

--TO GET THE RESULTS
SELECT * FROM analytics.monthly_drug_sales;

-- to REFRESH the materialized VIEW
REFRESH MATERIALIZED VIEW analytics.monthly_drug_sales;

-- Prescription/Order Metrics per Employee

-- Dispatch/Order Metrics per Employee

-- Research & Regulatory Drug Approvals Summary


SELECT SUM(total_amount) FROM operations.orders
WHERE drug_id = 605;

SELECT 
	drug_id, SUM(total_amount) AS revenue, 
	COUNT(drug_id) AS quantity_sold 
FROM 
	operations.orders
GROUP BY 
	drug_id
ORDER BY 
	quantity_sold DESC
LIMIT 10;