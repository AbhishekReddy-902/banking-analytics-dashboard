
use bank_project;


select * from bank_transactions;

-- Total Number of Transactions --

select count(*) from bank_transactions;

select count(*) as total_transactions
from bank_transactions;


-- 1.Total Credit Amount ---

SELECT SUM(amount) AS total_credit
FROM bank_transactions
WHERE transaction_type = 'Credit';


-- 2. Total Bebit Amount ---

SELECT SUM(amount) AS total_debit
FROM bank_transactions
WHERE transaction_type = 'Debit';


-- 3. Credit and Debit Ratio ---

SELECT 
    SUM(CASE WHEN transaction_type='Credit' THEN amount END) /
    SUM(CASE WHEN transaction_type='Debit' THEN amount END)
    AS credit_debit_ratio
FROM bank_transactions;


-- 4. Net Transaction Amount ---

SELECT 
    SUM(CASE WHEN transaction_type='Credit' THEN amount ELSE -amount END)
    AS net_transaction_amount
FROM bank_transactions;

-- Transactions Per Customer --

SELECT customer_id, COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY customer_id;

-- 5. Account Activity Ratio --

SELECT 
    account_number,
    COUNT(*) / AVG(balance) AS activity_ratio
FROM bank_transactions
GROUP BY account_number;


-- 6. Transactions Per Day ---

SELECT transaction_date, COUNT(*) AS transactions_per_day
FROM bank_transactions
GROUP BY transaction_date;


-- 7 Transactions per Month --

SELECT 
    YEAR(transaction_date) AS year,
    MONTH (transaction_date) AS month,
    COUNT(*) AS transactions_per_month
FROM bank_transactions
GROUP BY year, month;


-- 8 Total Transaction Amount by Branch ---

SELECT branch, sum(amount) AS total_amount
FROM bank_transactions
GROUP BY branch;
 
 -- Total Transaction by branch ---
 
SELECT branch, count(*) AS transaction_count
FROM bank_transactions
GROUP BY branch;

-- Transactions by Branch per (month,year,total)-- 

SELECT 
    branch,
    YEAR(transaction_date) AS transaction_year,
    MONTH(transaction_date) AS transaction_month,
    COUNT(*) AS monthly_transactions,
    SUM(COUNT(*)) OVER (
        PARTITION BY branch 
        ORDER BY YEAR(transaction_date), MONTH(transaction_date)
        ROWS UNBOUNDED PRECEDING
    ) AS up_to_date_total
FROM bank_transactions
GROUP BY branch, YEAR(transaction_date), MONTH(transaction_date)
ORDER BY branch, transaction_year, transaction_month;

-- 9. Transaction Volume by Bank ---

SELECT bank_name, SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY bank_name;

-- Transaction by bank  ---
 
SELECT bank_name, count(*) AS transaction_count
FROM bank_transactions
GROUP BY bank_name;

-- 10 Transaction Method Distribution ---

SELECT transaction_method, COUNT(*) AS total_transactions
FROM bank_transactions
GROUP BY transaction_method;


-- 11 High-Risk Transaction Flag --

SELECT is_high_risk, COUNT(*) as total_count, SUM(amount) as total_value
FROM bank_transactions
GROUP BY is_high_risk;

SELECT transaction_id, customer_name, amount, is_high_risk 
FROM bank_transactions 
WHERE is_high_risk = 1
LIMIT 10;

-- Branch Wise High Risk--

SELECT branch, COUNT(*) AS high_risk_count
FROM bank_transactions
WHERE is_high_risk = 1
GROUP BY branch;


-- 12. Suspicious Transaction Frequency ---

SELECT COUNT(*) AS suspicious_transactions
FROM bank_transactions
WHERE is_high_risk = 1;



-- VIEWS (for Dashboard)---
-- Credit vs Debit Summary---


CREATE VIEW vw_credit_debit_summary AS
SELECT
    SUM(CASE WHEN transaction_type='Credit' THEN amount ELSE 0 END) AS total_credit,
    SUM(CASE WHEN transaction_type='Debit' THEN amount ELSE 0 END) AS total_debit
FROM bank_transactions;

select * from vw_credit_debit_summary;


-- VIEWS (for Dashboard)---
--- Branch Performance--

CREATE VIEW vw_branch_performance AS
SELECT branch, SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY branch;

select * from vw_branch_performance;




-- STORED PROCEDURES --
-- Net Transaction Amount (by date range) --

DELIMITER $$

CREATE PROCEDURE sp_net_transaction_amount(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT 
        SUM(CASE 
            WHEN transaction_type='Credit' THEN amount 
            ELSE -amount 
        END) AS net_amount
    FROM bank_transactions
    WHERE transaction_date BETWEEN start_date AND end_date;
END$$

DELIMITER ;

CALL sp_net_transaction_amount('2024-01-01','2024-12-31');




 -- Stored Procedure:( Transaction Count Summary (by Date Range)
 -- This procedure gives :--
-- Total transactions , Credit count , Debit count , High-risk transaction count ---
    


DELIMITER $$

CREATE PROCEDURE sp_transaction_count_summary(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT
        COUNT(*) AS total_transactions,
        SUM(transaction_type = 'Credit') AS credit_transactions,
        SUM(transaction_type = 'Debit') AS debit_transactions,
        SUM(is_high_risk = 1) AS high_risk_transactions
    FROM bank_transactions
    WHERE transaction_date BETWEEN start_date AND end_date;
END$$

DELIMITER ;

CALL sp_transaction_count_summary('2024-01-01', '2024-12-31');
         

-- ADVISE-- 
-- 1.Fix the Loopfalls --

-- The Wait Problem: If it takes days to approve a loan, customers leave.Solution: Make it instant.​

-- The Paper Problem: Requiring physical signatures for everything. Solution: Go 100% paperless.

​-- The Hidden Problem: Customers only hear from the bank when there is a fee. Solution: Communicate value, not just charges.-- 

-- ​2. Where to Improve (The Action)​

-- Mobile First: The app should be so good that a customer never needs to visit a branch.

​-- Helpful AI: Instead of a generic bot, use AI that says, "Hey, you spent 20% more on groceries this month, want to set a budget?

-- Speed: Use automated systems to verify IDs and documents in minutes, not weeks.​-- 

-- 3. The Best Strategy for Growth​

​-- Be a Partner : Don't just give a car loan; help them find the car, compare insurance, and pay the road tax all in your app.​

-- Trust over Fees: Move away from "sneaky fees" and toward "subscription models" or "premium features" that people actually want to pay for.​

-- Target the Youth: Create features for kids and teens (with parental controls) to build loyalty before they even get their first job.​

-- The Conclusion​

-- The "Last Decision" is to stop selling products (like loans) and start selling convenience. 
-- If you make a customer's life easier, the growth (deposits and interest) will follow naturally..






     






