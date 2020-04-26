-- Create empty table Host
CREATE TABLE Host (
	id int,
   	url varchar(50),
   	name varchar(40),
   	since date,
   	location varchar(100),
   	about text,
    response_time varchar(20),
    response_rate varchar(10),
    acceptance_rate varchar(10),
    is_superhost boolean,
    thumbnail_url varchar(110),
    picture_url varchar(110),
    neighbourhood varchar(30),
    listings_count int,
    total_listings_count int,
	verifications varchar(150),
    has_profile_pic boolean,
    identity_verified boolean,
	calculated_listings_count int,
	PRIMARY KEY(id)
);

-- Copy from Listing and Delete duplicates
INSERT INTO Host
SELECT DISTINCT host_id, host_url, host_name, host_since, host_location, host_about,
				host_response_time, host_response_rate, host_acceptance_rate, host_is_superhost,
				host_thumbnail_url, host_picture_url, host_neighbourhood, host_listings_count,
				host_total_listings_count, host_verifications, host_has_profile_pic, host_identity_verified,
				calculated_host_listings_count FROM Listing;

-- Delete what you copied from Listing except host_id
ALTER TABLE Listing
DROP COLUMN host_url, 
DROP COLUMN host_name, 
DROP COLUMN host_since, 
DROP COLUMN host_location, 
DROP COLUMN host_about,
DROP COLUMN host_response_time, 
DROP COLUMN host_response_rate, 
DROP COLUMN host_acceptance_rate, 
DROP COLUMN host_is_superhost,
DROP COLUMN host_thumbnail_url, 
DROP COLUMN host_picture_url, 
DROP COLUMN host_neighbourhood, 
DROP COLUMN host_listings_count,
DROP COLUMN host_total_listings_count, 
DROP COLUMN host_verifications, 
DROP COLUMN host_has_profile_pic, 
DROP COLUMN host_identity_verified,
DROP COLUMN calculated_host_listings_count;

-- Make foreign key on Listings
ALTER TABLE Listing
ADD FOREIGN KEY (host_id) REFERENCES Host(id);
