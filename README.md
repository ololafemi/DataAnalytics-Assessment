# DataAnalytics-Assessment

QUESTIONS

1. High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Tables:
●	users_customuser
●	savings_savingsaccount
●	plans_plan

Challanges:
It was very difficult to join the primary keys from each of the table. I do not have adequate knowledge of the raw data, as column names different, and using the Join appropiately was very difficult. 



2. Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
●	"High Frequency" (≥10 transactions/month)
●	"Medium Frequency" (3-9 transactions/month)
●	"Low Frequency" (≤2 transactions/month)
Tables:
●	users_customuser
●	savings_savingsaccount





3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
Tables:
●	plans_plan
●	savings_savingsaccount

Challanges:
The information in the raw data did not show explicity the the meaning of transaction status. Either transaction status 1 means active account, and transactio_status 2 means dormant account.
also, I was trying to parse the date but, I was not getting a result, hence, i did not parse it and it work just fine.
Furthermore, i wanted a materialised view where, the data can automatically refresh every one Month, using events schedular, but I was not getting a desire result, hence I went for a stored procedure, where I can reuse the queris as usual.



