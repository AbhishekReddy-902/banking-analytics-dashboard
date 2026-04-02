# 🏦 Banking Analytics Dashboard
### Loan Portfolio & Transaction Insights | SQL | Tableau

---

## 📌 Project Overview
Conducted an in-depth analysis of banking datasets to uncover 
key performance indicators (KPIs) and loan issuance trends. 
Utilized a multi-tool approach to ensure data accuracy and 
provide comprehensive visual insights for strategic decision-making.

---

## 📂 Datasets Used

| Dataset | Description |
|---------|-------------|
| **Bank Loan Data** | Loan portfolio, disbursements, repayments |
| **Bank Transactions Data** | Debit & Credit transaction analysis |

---

## 🛠️ Tools Used

![SQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

---

## 🎯 Loan Dashboard KPIs

Conducted an in-depth analysis of 100K banking 
transactions to uncover KPIs and loan issuance trends.

| # | KPI |
|---|-----|
| 1 | Total Credit: ₹127.60M |
| 2 | Total Debit: ₹127.29M  |
| 3 | Net Amount: ₹0.32M
| 4 | High-Risk Transactions: 81.57K |
| 5 | Total Loan Amount: ₹750.97M    |
| 6 | Total Loan Count: 65.54K       |
| 7 | Total Collections: ₹814.90M    |
| 8 | Total Interest: ₹155.29M       |


---

## 🎯 Transaction Dashboard KPIs

| # | KPI |
|---|-----|
| 1 | Total Credit Amount |
| 2 | Total Debit Amount |
| 3 | Credit to Debit Ratio |
| 4 | Net Transaction Amount |
| 5 | Account Activity Ratio |
| 6 | Transactions Per Day/Month |
| 7 | Total Transaction by Branch |
| 8 | Transaction Volume by Bank |
| 9 | Transaction Method Distribution |
| 10 | High-Risk Transaction Flag |
| 11 | Suspicious Transaction Frequency |
| 12 | Branch Transaction Growth |

---

## 💡 SQL Highlights

- ✅ Complex **Joins & Aggregations**
- ✅ **Window Functions** (Running Totals)
- ✅ **Views** for Dashboard Integration
- ✅ **Stored Procedures** with Date Range Parameters
- ✅ **High-Risk Transaction** Detection
- ✅ **Branch & Bank Performance** Analysis

---

## 💡 Key SQL Queries

### Q1: Total Number of Transactions
```sql
SELECT COUNT(*) AS total_transactions
FROM bank_transactions;
-- Result: 100K transactions
```

### Q2: Total Credit Amount
```sql
SELECT ROUND(SUM(amount)/1000000, 2) AS total_credit_M
FROM bank_transactions
WHERE transaction_type = 'Credit';
-- Result: 127.60M
```

### Q3: Total Debit Amount
```sql
SELECT ROUND(SUM(amount)/1000000, 2) AS total_debit_M
FROM bank_transactions
WHERE transaction_type = 'Debit';
-- Result: 127.29M
```

### Q4: Net Transaction Amount
```sql
SELECT ROUND(
    SUM(CASE WHEN transaction_type='Credit' 
        THEN amount ELSE -amount END)
    /1000000, 2) AS net_transaction_M
FROM bank_transactions;
-- Result: 0.32M
```

### Q5: Account Activity Ratio
```sql
SELECT account_number,
    ROUND(COUNT(*) / AVG(balance), 4) AS activity_ratio
FROM bank_transactions
GROUP BY account_number;
-- Result: 50K accounts analyzed
```

### Q6: Transactions Per Month
```sql
SELECT YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    CONCAT(ROUND(COUNT(*)/1000, 1), 'K') 
    AS transactions_per_month
FROM bank_transactions
GROUP BY year, month;
-- Result: 8.5K - 9.3K transactions per month
```

### Q7: Total Transaction Amount by Branch
```sql
SELECT branch, 
    CONCAT('₹', ROUND(SUM(amount)/1000000, 2), 'M') 
    AS total_amount
FROM bank_transactions
GROUP BY branch;
-- Result: City Center ₹42.91M | Main ₹42.84M
--         East ₹42.70M | Suburban ₹42.18M
--         North ₹41.68M | Downtown ₹42.59M
```

### Q8: Transaction Volume by Bank
```sql
SELECT bank_name, 
    CONCAT('₹', ROUND(SUM(amount)/1000000, 2), 'M') 
    AS total_amount
FROM bank_transactions
GROUP BY bank_name;
-- Result: Axis ₹42.71M | Kotak ₹42.83M
--         ICICI ₹42.52M | PNB ₹42.37M
--         HDFC ₹41.87M | SBI ₹42.59M
```

### Q9: Transaction Method Distribution
```sql
SELECT transaction_method, 
    CONCAT(ROUND(COUNT(*)/1000, 2), 'K') 
    AS total_transactions
FROM bank_transactions
GROUP BY transaction_method;
-- Result: Credit Card: 33.31K
--         Bank Transfer: 33.34K
--         Debit Card: 33.35K
```

### Q10: High-Risk Transaction Flag
```sql
SELECT is_high_risk, 
    CONCAT(ROUND(COUNT(*)/1000, 2), 'K') AS total_count,
    CONCAT('₹', ROUND(SUM(amount)/1000000, 2), 'M') 
    AS total_value
FROM bank_transactions
GROUP BY is_high_risk;
-- Result: High-Risk: 81.57K = ₹244.72M
--         Normal: 18.43K = ₹10.16M
```

### Q11: Suspicious Transaction Frequency
```sql
SELECT CONCAT(ROUND(COUNT(*)/1000, 2), 'K') 
    AS suspicious_transactions
FROM bank_transactions
WHERE is_high_risk = 1;
-- Result: 81.57K suspicious transactions
```

### Q12: Credit-Debit Summary View
```sql
CREATE VIEW vw_credit_debit_summary AS
SELECT 
    CONCAT('₹', ROUND(SUM(CASE WHEN transaction_type='Credit' 
        THEN amount ELSE 0 END)/1000000, 2), 'M') 
        AS total_credit,
    CONCAT('₹', ROUND(SUM(CASE WHEN transaction_type='Debit' 
        THEN amount ELSE 0 END)/1000000, 2), 'M') 
        AS total_debit
FROM bank_transactions;
-- Result: Total Credit: ₹127.60M | Total Debit: ₹127.29M
```

## 📸 Dashboard Preview
![Dashboard Screenshot](Screenshot%202026-03-24%20232639.png)

---

## 💡 Key Business Insights

- Total Transactions: 100K transactions analyzed
- Total Credit Amount: ₹127.60M
- Total Debit Amount: ₹127.29M
- Net Transaction Amount: ₹0.32M
- High-Risk Transactions: 81.57K = ₹244.72M
- Normal Transactions: 18.43K = ₹10.16M
- Suspicious Transactions flagged: 81.57K


## Conclusion

- 🏦 Identified **high-risk transactions** by branch
- 📈 Tracked **credit vs debit trends** over time
- 🗺️ Analyzed **state-wise loan distribution**
- ⚠️ Detected **delinquent & default loan patterns**
- 💳 Analyzed **payment method preferences**

---

## 💼 Learning Outcome
Built end-to-end banking analytics solution using SQL for 
data extraction, Tableau for visualization, and advanced 
KPI tracking for business decision-making.

---

## 👨‍💻 Author
**Abhishek Reddy**
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abhishekreddy111)
