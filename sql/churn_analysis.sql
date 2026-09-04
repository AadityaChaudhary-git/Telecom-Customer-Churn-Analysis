-- Telecom Customer Churn Analysis
-- SQLite-compatible business analysis queries

-- 1. Overall churn
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn;

-- 2. Churn by contract
SELECT Contract,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- 3. Churn by payment method
SELECT PaymentMethod,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- 4. Churn by internet service
SELECT InternetService,
       COUNT(*) AS customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- 5. Churn by tenure segment
SELECT
    CASE
        WHEN tenure BETWEEN 0 AND 6 THEN '0-6 months'
        WHEN tenure BETWEEN 7 AND 12 THEN '7-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS tenure_segment,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY tenure_segment
ORDER BY churn_rate_pct DESC;

-- 6. Churn by tech support
SELECT TechSupport,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;

-- 7. Churn by online security
SELECT OnlineSecurity,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY OnlineSecurity
ORDER BY churn_rate_pct DESC;

-- 8. Churn by paperless billing
SELECT PaperlessBilling,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY PaperlessBilling
ORDER BY churn_rate_pct DESC;

-- 9. Average monthly charges by churn
SELECT Churn, ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customer_churn
GROUP BY Churn;

-- 10. Average tenure by churn
SELECT Churn, ROUND(AVG(tenure), 2) AS avg_tenure_months
FROM telco_customer_churn
GROUP BY Churn;

-- 11. Monthly revenue associated with churned customers
SELECT ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_at_risk
FROM telco_customer_churn
WHERE Churn = 'Yes';

-- 12. High-value churned customers
SELECT customerID, Contract, tenure, MonthlyCharges, TotalCharges
FROM telco_customer_churn
WHERE Churn = 'Yes'
  AND MonthlyCharges >= (SELECT AVG(MonthlyCharges) FROM telco_customer_churn)
ORDER BY MonthlyCharges DESC;

-- 13. Contract + internet service
SELECT Contract, InternetService,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY Contract, InternetService
ORDER BY churn_rate_pct DESC;

-- 14. High-risk segment
SELECT Contract, PaymentMethod, InternetService,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY Contract, PaymentMethod, InternetService
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC;

-- 15. Churn by senior citizen status
SELECT SeniorCitizen,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_customer_churn
GROUP BY SeniorCitizen;
