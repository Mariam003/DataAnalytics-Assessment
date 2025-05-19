-- Q4
-- calculating the total number of transactions and total transaction value for each customer
WITH CustomerTransactions AS (
    SELECT
        u.id AS customer_id,
        u.username AS customer_name,
        u.date_joined,
        COUNT(s.savings_id) AS total_transactions,
        SUM(s.amount) AS total_transaction_value  
 
    FROM
        users_customuser u
    JOIN
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE s.transaction_status = 'success' AND s.transaction_type_id IN ('1', '2')
    GROUP BY
        u.id, u.username, u.date_joined
),
CustomerTenure AS (
    SELECT
        customer_id,
        customer_name,
        date_joined,
        total_transactions,
        total_transaction_value,
        -- Calculating tenure in months
        CASE
            WHEN date_joined > CURRENT_DATE THEN 0  
            ELSE TIMESTAMPDIFF(MONTH, date_joined, CURRENT_DATE)
        END AS tenure_months
    FROM
        CustomerTransactions
)
SELECT
    customer_id,
    customer_name,
    tenure_months,
    total_transactions,
    -- Calculate Estimated CLV
    (total_transactions / tenure_months) * 12 * (0.001 * total_transaction_value) AS estimated_clv
FROM
    CustomerTenure
ORDER BY
    estimated_clv DESC;
