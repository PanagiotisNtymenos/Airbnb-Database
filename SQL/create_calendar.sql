CREATE TABLE Calendar (
	listing_id INT,
	date DATE,
	available VARCHAR(30),
	price MONEY,
	adjusted MONEY,
	minimum_nights INT,
	maximum_nights INT,
	PRIMARY KEY (listing_id, date)
);