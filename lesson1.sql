SELECT occurred_at, account_id, channel /* which columns */
 			gloss_qty + poster_qty AS nonstandard_qty /* add columns together aka 'derived column', name it what you want */
	 FROM web_events /* from which table */
	WHERE account_id = 4251 /* place after from but before ORDER BY or LIMIT; if string, surround with quotes */
	WHERE referrer_url LIKE '/%google%/' /* anything where url contains google; opeartor requires wild cards: % % */
	WHERE name IN ('Walmart', 'Apple')
	ORDER BY occurred_at, account_id DESC channel /* must appear after FROM and before LIMIT. DESC should be last */
  LIMIT 15; /* limit to first 15 rows */

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
