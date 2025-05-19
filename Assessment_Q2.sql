-- Q2
-- Calculating the average number of transactions per customer per month

WITH MonthlyTransactions AS (

--  Here, the query calculates the number of transactions each customer makes in each month.
    SELECT
        u.id AS customer_id,
        u.username AS customer_name,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS transaction_month,
        COUNT(s.savings_id) AS monthly_transaction_count
  
-- using inner join to combine the data from both users_customuser and savings_savingsaccount   
    FROM
        users_customuser u
    JOIN
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE
        s.transaction_status = 'success' AND
        s.transaction_type_id IN ('1', '2')
        
-- Here, I grouped the results by customer ID, username, and the year-month.  
       
    GROUP BY
        u.id, u.username, DATE_FORMAT(s.transaction_date, '%Y-%m')
),
AverageTransactions AS (
-- calculating the average number of transactions per month for each customer.
    SELECT
        customer_id,
        customer_name,
        AVG(monthly_transaction_count) AS avg_transactions_per_month
    FROM
        MonthlyTransactions
    GROUP BY
        customer_id, customer_name
),
CategorizedTransactions AS (
-- categorizing each customer based on their average monthly transaction frequency.

    SELECT
        customer_id,
        customer_name,
        avg_transactions_per_month,
        CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month >= 3 AND avg_transactions_per_month <= 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM
        AverageTransactions
)
SELECT
    frequency_category,
    COUNT(customer_id) AS customer_count,
    AVG(avg_transactions_per_month) AS avg_transactions_per_month
FROM
    CategorizedTransactions
GROUP BY
    frequency_category
ORDER BY
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;

