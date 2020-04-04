/* Find all places that got rented in Kypseli and took place between the 1st of April 2020 and the 5th of April 2020
Output: 324 rows
*/

SELECT DISTINCT Listings.name, Listings.zipcode, Listings.latitude, Listings.longitude FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE Calendar.date >= '20200401' AND Calendar.date <= '20200405' AND Listings.neighbourhood_cleansed = 'ΚΥΨΕΛΗ';


/* Find all reviews for houses with 10 reviews or lesser, and at the price between 20$ and 50$. Display from lower price to higher.
Output: 7244 rows
*/

SELECT Listings.name, Listings.price, Reviews.reviewer_name, Reviews.comments FROM Listings
INNER JOIN Reviews
ON Listings.id = Reviews.listing_id
WHERE Listings.number_of_reviews <= 10 AND LENGTH(Listings.price) <= 6 AND CAST((RIGHT(Listings.price, LENGTH(Listings.price) - 1 )) as DECIMAL(9,2)) >= 20 AND CAST((RIGHT(Listings.price, LENGTH(Listings.price) - 1 )) as DECIMAL(9,2)) <= 50
ORDER BY Listings.price ASC;


/* Find Top 10 places to rent, for at least 5 nights. Top meaning a high review score and the cheapest.
Output: 10 rows (Προφανώς) 
*/

SELECT DISTINCT Listings.id, Listings.name, Listings.review_scores_rating, Listings.number_of_reviews, Calendar.minimum_nights, Listings.price FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE CAST(Listings.review_scores_rating AS INT) >= 90 AND Calendar.minimum_nights >= 5 AND Listings.number_of_reviews >= 100
ORDER BY Listings.price ASC
LIMIT 10;