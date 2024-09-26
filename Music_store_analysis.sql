CREATE DATABASE Music_Store;

-- 1. Which countries have the max employees based on their job title?
SELECT 
    country, COUNT(*) AS Number_of_employees
FROM
    employee
GROUP BY country
ORDER BY country DESC
LIMIT 1;
 
-- 2.(a) who is the senior most employee based on job title?
SELECT 
    employee_id, last_name, first_name, title, levels, hire_date, city, state, country, email
FROM
    employee
ORDER BY title
LIMIT 1;

-- 2. (b) which country has the most invoices?
SELECT 
    billing_country, COUNT(*) AS number_of_invoices
FROM
    invoice
GROUP BY billing_country
ORDER BY number_of_invoices DESC
LIMIT 1;

/*3) From which city we have done highest business? We would like to throw a promotional Music Festival in the city where we made the most money. 

*/
SELECT 
    billing_city,
    ROUND(SUM(total), 2) AS Highest_of_invoice_totals
FROM
    invoice
GROUP BY billing_city , billing_country
ORDER BY Highest_of_invoice_totals DESC
LIMIT 1;

-- 4. Who is the most valuable customer and which country he belongs to? The customer who spent the max amount will be "the most valuable customer".
SELECT 
    customer.first_name AS First_name,
    customer.last_name AS Last_name,
    customer.country,
    ROUND(SUM(invoice.total), 2) AS Highest_of_invoice_totals
FROM
    customer
        INNER JOIN
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY First_name , Last_name, country
ORDER BY Highest_of_invoice_totals DESC
LIMIT 1;

-- 5. Find Email, name & Genre of all the audience who listens to rock music(Sort Email Alphabetically).
SELECT DISTINCT
    (customer.email) AS Email_id,
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS Full_name,
    genre.name
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        JOIN
    track ON invoice_line.track_id = track.track_id
        JOIN
    genre ON track.genre_id = genre.genre_id
WHERE
    genre.genre_id = 1
ORDER BY Email_id;

-- 6. Find Top 10 rock band (Artist) who have written the majority of the songs and the number of tracks.
SELECT 
    artist.name AS Artist_name,
    COUNT(album2.artist_id) AS No_of_Tracks
FROM
    artist
        INNER JOIN
    album2 ON artist.artist_id = album2.artist_id
GROUP BY Artist_name
ORDER BY No_of_Tracks DESC
LIMIT 10;

-- 7. Extract Name and milliseconds (in descending order) for all the tracks that have song duration longer than the average song duration.

SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds)
        FROM
            track)
ORDER BY milliseconds DESC;

-- 8. Find how much amount is spent by each customer on the top artist? Give me their names and amount spent.

WITH Most_popular_artist AS(
SELECT a.artist_id AS artist_id, a.name AS Artist_name, SUM(il.quantity * il.unit_price) AS Total_sales
FROM 
invoice_line il 
	JOIN track t ON il.track_id = t.track_id
	JOIN album2 a2 ON t.album_id = a2.album_id
	JOIN artist a ON a2.album_id = a.artist_id
GROUP BY artist_id, Artist_Name
ORDER BY Total_sales DESC LIMIT 1
 )
SELECT CONCAT(c.first_name," ", c.last_name) AS customers_fullname, 
mpa.Artist_name, SUM(il.quantity * il.unit_price) AS Total_sales
FROM customer c 
	JOIN invoice i ON i.customer_id = c.customer_id
	JOIN invoice_line il ON il.invoice_id = i.invoice_id
	JOIN track t ON t.track_id = il.track_id
	JOIN album2 a2 ON a2.album_id = t.album_id
	JOIN Most_popular_artist mpa ON mpa.artist_id = a2.artist_id
GROUP BY customers_fullname, mpa.Artist_name
ORDER BY Total_sales DESC;

/* 9. Find the most popular music genre for each country.
 We determine most popular genre as the genre highest amount of purchase trancations. 
For countries where the maximum number of purchases is shared, provide all genres.
*/

WITH Popular_genre AS (
SELECT i.billing_country, g.name, COUNT(i.billing_country) AS No_of_transactions,
ROW_NUMBER () OVER (PARTITION BY i.billing_country ORDER BY COUNT(i.billing_country) DESC) AS Row_num   FROM genre g
JOIN track t ON t.genre_id = g.genre_id
JOIN invoice_line  il ON il.track_id = t.track_id
JOIN invoice i ON i.invoice_id = il.invoice_id
GROUP BY g.name, i.billing_country
ORDER BY No_of_transactions
DESC)
SELECT * FROM Popular_genre WHERE Row_num <= 1;

# 2nd method
WITH RECURSIVE Popular_genre AS (SELECT i.billing_country AS country, g.name AS genre, COUNT(i.billing_country) AS No_of_transactions FROM genre g
JOIN track t ON t.genre_id = g.genre_id
JOIN invoice_line  il ON il.track_id = t.track_id
JOIN invoice i ON i.invoice_id = il.invoice_id
GROUP BY genre , i.billing_country 
ORDER BY No_of_transactions DESC),
Maxpurchase_per_country AS(SELECT MAX(No_of_transactions) AS Max_no_of_transactions, country FROM Popular_genre
GROUP BY country
ORDER BY country)

SELECT Maxpurchase_per_country.country, genre, Max_no_of_transactions FROM Popular_genre JOIN Maxpurchase_per_country ON Popular_genre.country = Maxpurchase_per_country.country
WHERE Popular_genre.No_of_transactions = Maxpurchase_per_country.Max_no_of_transactions;

/* 10. Find country along with top customer and the amount spent by them. 
For countries where the top customer is shared, provide all customers who spent this amount.
*/

WITH RECURSIVE 
	Customer_details 
AS (
SELECT CONCAT(c.first_name, " " , c.last_name) AS Customer_Fullname,
	i.billing_country AS country, ROUND(SUM(total),2) AS Total_spendings
FROM invoice i 
JOIN customer c ON i.customer_id = c.customer_id
GROUP BY Customer_Fullname, i.billing_country
ORDER BY Total_spendings DESC
),
	Max_total_spendings AS (
SELECT country, ROUND(MAX(Total_spendings),2) as Highest_total_spendings
FROM Customer_details
GROUP BY country
)
SELECT cd.Customer_Fullname, cd.country, mts.Highest_total_spendings FROM Customer_details cd JOIN Max_total_spendings mts
ON cd.country = mts.country
WHERE Total_spendings = Highest_total_spendings
ORDER BY Highest_total_spendings DESC;

-- 11) Find sales reprentative of each customer.
SELECT 
    CONCAT(c.first_name, " ", c.last_name) AS Customer_name,
    CONCAT(e.first_name, " ", e.last_name) AS Sales_Representative
FROM
    customer c
        JOIN
    employee e ON c.support_rep_id = e.employee_id
;
