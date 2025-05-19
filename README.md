# DataAnalytics-Assessment
## Q1: High-Value Customers with Multiple Products

### Approach

The SQL query aims to understand customer transaction activity by looking at data from two tables: users_customuser which holds customer details, and savings_savingsaccount which contains transaction information.. To do this, I:

1.  Combined Customer and Transaction Data: I merged the information from two tables(user_customuser and savings_savingsaccount). This allowed me to link specific transactions to the customers who made them.

2.  Counted Transaction by Type: I counted how many transactions are of each type (savings or investment) for each customer. This helped me determine the customers who have both savings and investment transactions.

3.  Calculated Total Deposits: I summed up the total amount of money deposited by each customer.

4.  Grouped and Summarized: Finally, I grouped the results by customer, so that the output shows a summary of each customer's activity, including their transaction count for each product type and their total deposits.

### Challenges 

The main challenges I likely faced were the potential miscounting of investment transactions due to the same condition used for savings, and the lack of clear definition for the transaction type IDs.

## Q2: Transaction Frequency Analysis 

## Approach

The first thing I did was figure out how many transactions each customer made in a single month. To do this, I looked at the users_customuser table for the customer info and the savings_savingsaccount table for all the transaction details. I combined this info where the customer IDs matched up and made sure the successful transactions that went through were of specific types('1' and '2'). Then, I went on to group everything in order to get a count of transactions for each individual customer within each specific month.

Next , I calculated the average number of transactions per month. Then took those monthly transaction counts for each customer and computed the average across all the months.I furthered by putting the customers into groups based on how often they transact. So, I created categories. For this, if a customer averages 10 or more transactions a month, they are "High Frequency." If their average is between 3 and 9, they are "Medium Frequency." And if they average 2 or fewer, they are in the "Low Frequency" group.
The final result gave each frequency category, the customer count, and the average transaction per month.

## Q3: Account Inactivity Alert

### Approach

The objective of this query was to identify all active accounts that haven't had any transaction activity within the last year. My approach involved several steps. First, I needed to determine the type of each financial plan, classifying them as 'Savings', 'Investment', or 'Other' based on a specific identifier. Then, for each of these plans, I aimed to find the most recent date of activity. To handle cases where an account might never have had a transaction, I used the plan's creation date as a fallback. Finally, I calculated how many days had passed since this last activity date and then filtered the results to only show those accounts where this period of inactivity was less than 365 days, effectively pinpointing the recently active accounts.

### Challenges 

The only issue I had here was when my code kept returning no rows. I figured it was as a result of me using 'active' in place of '1' for the pp.status_id

## Q4:  Customer Lifetime Value (CLV) Estimation

### Approach

The main objective of this query was to calculate an estimated Customer Lifetime Value (CLV) for each customer. To do this, I First needed to figure out the total number of successful transactions and the total value of those transactions for each customer. I did this by joining the customer information with their transaction history and then grouping the results by customer. After that, I calculated how long each customer has been using the company's product , which I called their tenure_months. Finally, I used a formula that takes into account their total transactions, their tenure, and an assumed profit per transaction to estimate their CLV, and then I presented this information, ranking the customers from the highest estimated CLV to the lowest.
