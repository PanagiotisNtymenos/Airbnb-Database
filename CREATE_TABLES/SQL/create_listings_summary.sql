CREATE TABLE Listings_Summary (
	id INT,
    name VARCHAR(300),
    host_id INT,
    host_name VARCHAR(50),
    neighbourhood_group VARCHAR(30),
    neighbourhood VARCHAR(40),
    latitude VARCHAR(20),
    longitude VARCHAR(20),
    room_type VARCHAR(20),
    price MONEY,
    minimum_nights INT,
    number_of_reviews INT,
    last_review VARCHAR(10),
    reviews_per_month VARCHAR(10),
    calculated_host_listings_count INT,
    availability_365 INT,
    PRIMARY KEY (id)
);