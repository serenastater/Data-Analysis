SELECT occurred_at, account_id, channel /* which columns */
 			gloss_qty + poster_qty AS nonstandard_qty /* add columns together aka 'derived column', name it what you want */
	 FROM web_events /* from which table */
	WHERE account_id = 4251 /* place after from but before ORDER BY or LIMIT; if string, surround with quotes */
	WHERE referrer_url LIKE '/%google%/' /* anything where url contains google; opeartor requires wild cards: % % */
	WHERE name IN ('Walmart', 'Apple')
	WHERE sales_rep_id NOT IN (321500, 321570) /* opposite */
	WHERE referrer_url NOT LIKE '/%google%/' /* opposite */
	WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01' /* AND used within WHERE statement. Each time you link a new statement with an AND, you will need to specify the column you are interested in looking at. This operator works with all of the operations we have seen so far including arithmetic operators (+, *, -, /). LIKE, IN, and NOT logic can also be linked together using the AND operator */
	WHERE column BETWEEN 6 AND 10
	WHERE standard_qty = 0 OR gloss_qty = 0 /* or means one or the other is true */
	WHERE (standard_qty = 0 OR gloss_qty = 0) /* parentheses make one logical statement that resolves to true or false. as long as ONE statement is true, the entire block in parentheses is considered to be true */
	ORDER BY occurred_at, account_id DESC channel /* must appear after FROM and before LIMIT. DESC should be last */
  LIMIT 15; /* limit to first 15 rows */

/* | statement | how to use it | other details | */
SELECT	SELECT Col1, Col2, ...	Provide the columns you want
FROM	FROM Table	Provide the table where the columns exist
LIMIT	LIMIT 10	Limits based number of rows returned
ORDER BY	ORDER BY Col	Orders table based on the column. Used with DESC.
WHERE	WHERE Col > 5	A conditional statement to filter your results
LIKE	WHERE Col LIKE '%me%	Only pulls rows where column has 'me' within the text
IN	WHERE Col IN ('Y', 'N')	A filter for only rows with column of 'Y' or 'N'
NOT	WHERE Col NOT IN ('Y', "N')	NOT is frequently used with LIKE and IN
AND	WHERE Col1 > 5 AND Col2 < 3	Filter rows where two or more conditions must be true
OR	WHERE Col1 > 5 OR Col2 < 3	Filter rows where at least one condition must be true
BETWEEN	WHERE Col BETWEEN 3 AND 5	Often easier syntax than using an AND

/* Logical operators */
LIKE
-- This allows you to perform operations similar to using WHERE and =,
-- but for cases when you might not know exactly what you are looking for.
IN
-- This allows you to perform operations similar to using WHERE and =, but for more than one condition.
NOT
-- This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.
AND & BETWEEN
-- These allow you to combine operations where all combined conditions must be true.
OR
-- This allow you to combine operations where at least one of the combined conditions must be true.

Write a query that returns the top 5 rows from orders ordered according to newest to oldest, but with the largest total_amt_usd for each date listed first for each date. You will notice each of these dates shows up as unique because of the time element. When you learn about truncating dates in a later lesson, you will better be able to tackle this question on a day, month, or yearly basis.

SELECT *
	FROM orders
  ORDER BY occurred_at DESC, total_amt_usd DESC
  LIMIT 5

Write a query that returns the top 10 rows from orders ordered according to oldest to newest, but with the smallest total_amt_usd for each date listed first for each date. You will notice each of these dates shows up as unique because of the time element. When you learn about truncating dates in a later lesson, you will better be able to tackle this question on a day, month, or yearly basis.

SELECT *
	FROM orders
  ORDER BY occurred_at, total_amt_usd
  LIMIT 10

Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

SELECT *
	FROM orders
  WHERE gloss_amt_usd >= 1000
  LIMIT 5;

Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

SELECT *
	FROM orders
  WHERE total_amt_usd < 500
  LIMIT 10;

Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT 		id,
	account_id,
	standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column). Include the id and account_id fields. NOTE - you will be thrown an error with the correct solution to this question. This is for a division by zero. You will learn how to get a solution without an error to this query when you learn about CASE statements in a later section. For now, you might just add some very small value to your denominator as a work around.

SELECT 	id,
		account_id,
        (poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders

Use the accounts table to find:
All the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%'

All companies whose names contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name LIKE '%one%'

All companies whose names end with 's'.

SELECT name
FROM accounts
WHERE name LIKE '%S'

Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Google')

Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

Use the accounts table to find:
all the companies whose names do not start with 'C'.

SELECT *
FROM accounts
WHERE name NOT IN ('C%');

All companies whose names do not contain the string 'one' somewhere in the name.

SELECT *
FROM accounts
WHERE name NOT IN ('%one%');

All companies whose names do not end with 's'.

SELECT *
FROM accounts
WHERE name NOT IN ('%s');

Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

-- Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.

SELECT *
FROM accounts
WHERE name NOT IN ('C%') AND name IN ('%s');

-- Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and started their account at any point in 2016 sorted from newest to oldest.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at DESC;

-- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000

-- Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.

SELECT *
FROM orders
WHERE standard_qty = 0
	AND (gloss_qty > 1000 OR poster_qty > 1000);

-- Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%';
