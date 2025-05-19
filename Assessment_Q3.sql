-- Q3
-- Finding all active accounts (savings or investments) with no transactions in the last 1 year 

SELECT
    pp.id AS plan_id,
    pp.owner_id,
    CASE
    
    -- Classifying the plan type where if 'plan_type_id' is 1, then Savings and if 2, then investment
    -- And for other 'plan_type_id' value, then Other.   
       WHEN pp.plan_type_id = 1 THEN 'Savings'
        WHEN pp.plan_type_id = 2 THEN 'Investment'
        ELSE 'Other'
    END AS type,
	-- Determined the most recent activity date for the plan
    COALESCE(MAX(s.transaction_date), pp.created_on) AS last_transaction_date,
    
     -- Calculated the number of days since the plan's last activity
    DATEDIFF(CURRENT_DATE, COALESCE(MAX(s.transaction_date), pp.created_on)) AS inactivity_days
FROM
    plans_plan pp
  
 -- Performed a LEFT JOIN to Combine plans data with transaction data from savings_savingsaccount (aliased as 's')
LEFT JOIN
    savings_savingsaccount s ON pp.id = s.plan_id
WHERE
    pp.status_id = 1
GROUP BY
    pp.id, pp.owner_id, pp.plan_type_id, pp.created_on
HAVING
    DATEDIFF(CURRENT_DATE, COALESCE(MAX(s.transaction_date), pp.created_on)) < 365
ORDER BY
    pp.id;
