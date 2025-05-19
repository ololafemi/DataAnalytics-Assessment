USE sql_excercise;

##	Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
##	Tables: plans_plan savings_savingsaccount

-- 

DROP PROCEDURE IF EXISTS active_account;

 DELIMITER $$

CREATE PROCEDURE active_account(
    IN start_date DATE,
    IN end_date   DATE
)
BEGIN
    /*
      1) Join plans_plan to savings_savingsaccount
	  2) Restrict to plans flagged as savings or investments (no status filter).
      3) Find each plan’s most recent inflow and flag those idle >365 days before end_date.
    */
    SELECT
    p.id                                     AS plan_id,
    p.owner_id                               AS owner_id,
    CASE
      WHEN p.is_regular_savings  = 1 THEN 'Savings'
      WHEN p.is_fixed_investment = 1 THEN 'Investment'
      ELSE 'Unknown'
    END                                      AS `type`,
    DATE(MAX(s.transaction_date))            AS last_transaction_date,
    DATEDIFF(
      end_date,
      DATE(MAX(s.transaction_date))
    )                                        AS inactivity_days
  FROM plans_plan p
  JOIN savings_savingsaccount s
    ON p.id = s.plan_id
   AND s.amount > 0                          
  WHERE p.is_regular_savings  = 1
     OR p.is_fixed_investment = 1
  GROUP BY
    p.id, p.owner_id, p.is_regular_savings, p.is_fixed_investment
  HAVING
    last_transaction_date < DATE_SUB(end_date, INTERVAL 1 YEAR)
  ORDER BY inactivity_days DESC;
END$$
DELIMITER ;


CALL active_account('2024-01-01','2025-01-01');







 