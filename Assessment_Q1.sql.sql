USE sql_excercise;

## Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
-- I used three tables; users_customuser, savings_savingsaccount, and plans_plan.

SELECT 
  u.id AS owner_id,					-- selecting the column id from table users_customuser and calling the table owner_id
  CONCAT(u.first_name, ' ', u.last_name) AS name,	-- concat allows mw to add first_name and last_name colmn into one
  COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_counts,		-- count function and conditional statement if allow me to count and capture when regular_saving is 1 as positive  
  COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_counts,
  SUM(s.new_balance) AS total_deposits		-- sum function give me total number and alias new_balance as total_deposits.
FROM plans_plan p							-- some selected column are from the table plans_plan alias as p
JOIN savings_savingsaccount s ON p.id = s.plan_id -- I joined savings_savingsaccount on common occcurence identical column in both tables
JOIN users_customuser u ON p.owner_id = u.id
GROUP BY u.id, CONCAT(u.first_name, ' ', u.last_name)								-- groupby allows me to aggregate by the factors: id, name 
HAVING 												-- having allow me to do a special filter, where i gives a more specific information
  savings_counts >= 1 								-- saving_plans greater or equal to 1
  AND investment_counts >= 1							-- investment_plans greater than or equal to 1
ORDER BY total_deposits DESC;						-- oder allow me to do an additional filtration in a descending order.
