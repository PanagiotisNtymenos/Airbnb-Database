/* Find how many Listings in ΠΕΤΡΑΛΩΝΑ, belong to each Host 
Output:  rows
*/

select * from Host

SELECT Host.id, Host.name, COUNT(Listing.id) from Listing
FULL JOIN Host
ON Host.id = Listing.host_id
JOIN Location
ON Listing.id = Location.listing_id
WHERE Location.neighbourhood_cleansed = 'ΠΕΤΡΑΛΩΝΑ'
GROUP BY Host.id



/* Find the number of Reviews for EVERY Listing that has a TV
Output: 10019 rows
*/

SELECT Listing.id, Listing.listing_url, Listing.name, COUNT(Review.listing_id) AS reviews FROM Review
RIGHT JOIN Listing
ON Listing.id = Review.listing_id
JOIN Room_Amenity
ON Listing.id = Room_Amenity.listing_id
JOIN Amenity
ON Room_Amenity.amenity_id = Amenity.amenity_id
WHERE Amenity.amenity_name = 'TV'
GROUP BY Listing.id;



/* Find the Price of the cheapest Listing in each Neighbourhood that have at least 5 bedrooms
Output: 23 rows
*/

SELECT Geolocation.properties_neighbourhood, MIN(Price.price) AS price FROM Geolocation
JOIN Neighbourhood
ON Geolocation.properties_neighbourhood = Neighbourhood.neighbourhood
JOIN Location
ON Location.neighbourhood_cleansed = Neighbourhood.neighbourhood
JOIN Listing
ON Listing.id = Location.listing_id
JOIN Price
ON Listing.id = Price.listing_id
JOIN Room
ON Listing.id = Room.listing_id
WHERE Room.bedrooms > 4
GROUP BY Geolocation.properties_neighbourhood;



/* Find all Hosts with 3 Listings or more
Output: 735 rows
*/

SELECT Host.id, Host.name, COUNT(Listing.id) FROM Listing
JOIN Host
ON Host.id = Listing.host_id
GROUP BY Host.id
HAVING COUNT(Listing.id) > 2;



/* Find the Hosts with the cheapest Listings BUT NOT FREE!
Output: 4 rows
*/

SELECT Host.id, Host.name, Price.price FROM Host
JOIN Listing
ON Listing.host_id = Host.id
JOIN Price
ON Price.listing_id = Listing.id
GROUP BY Host.id, Price.price
HAVING Price.price = (SELECT MIN(Price.price) FROM Price
					 WHERE Price.price != 0);