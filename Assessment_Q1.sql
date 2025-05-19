-- Q1
-- Getting the number of customers who have both savings and investment plan
-- The count function was used to count both the number of savings and investment by checking
-- if each row in transaction_type_id equals 1

SELECT
    u.id AS owner_id,
    u.username AS name,
    COUNT(CASE WHEN s.transaction_type_id =  '1'  THEN s.savings_id END) AS savings_count, 
    COUNT(CASE WHEN s.transaction_type_id =  '1'  THEN s.savings_id END) AS investment_count, 
    SUM(s.new_balance) AS total_deposits
    
-- using inner join to combine the data from both users_customuser and savings_savingsaccount 
 
FROM
    users_customuser u
JOIN
    savings_savingsaccount s ON u.id = s.owner_id 
WHERE
    s.transaction_status = 'success' -- This includes only the rows where transaction was a success
    AND s.transaction_type_id IN ('1', '2')  -- includes rows where the transaction type is 1 and 2 
GROUP BY
    u.id, u.username
ORDER BY
    u.id;