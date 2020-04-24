CREATE TABLE Reviews (
	listing_id INT,
	id INT,
	date DATE,
	reviewer_id INT,
	reviewer_name VARCHAR(100),
	comments TEXT,
	PRIMARY KEY(id)
);