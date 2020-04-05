/* 1st Query
Find all places that got rented in Kypseli and took place between the 1st of April 2020 and the 5th of April 2020
Output: 324 rows
*/

SELECT DISTINCT Listings.name, Listings.zipcode, Listings.latitude, Listings.longitude FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE Calendar.date BETWEEN '20200401' AND '20200405' AND Listings.neighbourhood_cleansed = 'ΚΥΨΕΛΗ'



/* 2nd Query
Find all reviews for houses with 10 reviews or lesser, and at the price between 20$ and 50$. Display from lower price to higher.
Output: 7244 rows
*/

SELECT Listings.name, Listings.price, Reviews.reviewer_name, Reviews.comments FROM Listings
INNER JOIN Reviews
ON Listings.id = Reviews.listing_id
WHERE Listings.number_of_reviews <= 10 AND LENGTH(Listings.price) <= 6 AND CAST((RIGHT(Listings.price, LENGTH(Listings.price) - 1 )) as DECIMAL(9,2)) BETWEEN 20 AND 50
ORDER BY Listings.price ASC



/* 3rd Query
Find Top 10 places to rent, for at least 5 nights. Top meaning a high review score and the cheapest.
Output: 10 rows (Προφανώς) 
*/

SELECT DISTINCT Listings.id, Listings.name, Listings.review_scores_rating, Listings.number_of_reviews, Calendar.minimum_nights, Listings.price FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE CAST(Listings.review_scores_rating AS INT) >= 90 AND Calendar.minimum_nights >= 5 AND Listings.number_of_reviews >= 100
ORDER BY Listings.price ASC
LIMIT 10



/* 4th Query
Find how many reviews are submitted in each neighbourhood.
Output: 45 rows 
*/

SELECT Neighbourhoods.neighbourhood, COUNT(Reviews.id) FROM Listings
LEFT JOIN Reviews
ON Reviews.listing_id = Listings.id
RIGHT JOIN Neighbourhoods
ON Neighbourhoods.neighbourhood = Listings.neighbourhood_cleansed
GROUP BY Neighbourhoods.neighbourhood



/* 5th Query
Find the average review score for every neighbourhood.
Output: 45 rows 
*/

SELECT Neighbourhoods.neighbourhood, COUNT(Listings.id) AS houses, ROUND( AVG( CAST( Listings.review_scores_rating AS NUMERIC(9, 2))), 2) AS MO FROM Listings
LEFT JOIN Neighbourhoods
ON Neighbourhoods.neighbourhood = Listings.neighbourhood_cleansed
GROUP BY Neighbourhoods.neighbourhood



/* 6th Query
Find all rentings of 2020 and show their number of reviews.
Output: 8982 rows 
*/

SELECT Listings.id, Listings.name, Listings.summary, COUNT(Reviews.id) AS Reviews FROM Listings
JOIN Calendar
ON Calendar.listing_id = Listings.id
JOIN Reviews
ON Reviews.listing_id = Listings.id
WHERE CAST(Calendar.date AS VARCHAR(10)) LIKE '2020%'
GROUP BY Listings.id
