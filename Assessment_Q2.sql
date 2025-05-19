USE sql_excercise;

 	-- Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
##	Task: Calculate the average number of transactions per customer per month and categorize them:
	-- High Frequency" (≥10 transactions/month)
	-- Medium Frequency" (3-9 transactions/month)
	-- Low Frequency" (≤2 transactions/month)
	-- Tables: users_customuser, 


-- Calculate transactions per customer per month
	-- CTE: WITH clauses was used to break down complex logic

WITH monthly_data AS (
    SELECT 
        CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
        DATE_FORMAT(
            STR_TO_DATE(s.transaction_date, '%d/%m/%Y %H:%i'),			-- parsing date retrieve in the raw data from string to SQL data format 
            '%Y-%m'														-- This enable me to retrieve data of transaction per month
        ) AS transaction_month,
        COUNT(*) AS monthly_transaction_count							-- count (*) select the total number of transaction in a row
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id, 
        CONCAT(u.first_name, ' ', u.last_name), 
        DATE_FORMAT(STR_TO_DATE(s.transaction_date, '%d/%m/%Y %H:%i'), '%Y-%m')
),

-- Calculate average transactions per customer and categorize them

customer_categories AS (
    SELECT 
        customer_name,
        AVG(monthly_transaction_count) AS avg_transactions_per_month,
        CASE 
            WHEN AVG(monthly_transaction_count) >= 10 THEN 'High Frequency'
            WHEN AVG(monthly_transaction_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM monthly_data
    GROUP BY customer_name
)

-- Count customers in each category and show their average transactions
SELECT 
    frequency_category,
    COUNT(customer_name) AS customer_count,
    AVG(avg_transactions_per_month) AS avg_transactions_per_month
FROM customer_categories
GROUP BY frequency_category
ORDER BY customer_count DESC;