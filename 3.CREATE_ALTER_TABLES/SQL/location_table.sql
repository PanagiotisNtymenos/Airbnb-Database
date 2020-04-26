-- Create table Location from Query
CREATE TABLE Location AS
SELECT id, street, neighbourhood, neighbourhood_cleansed, city, state, 
		zipcode, market, smart_location, country_code, country, latitude, longitude,
		is_location_exact FROM Listing;

-- Rename id to listings_id
ALTER TABLE Location 
RENAME COLUMN id TO listing_id;

-- Make primary key on Location
ALTER TABLE Location
ADD PRIMARY KEY (listing_id);

-- Make foreign keys on Location
ALTER TABLE Location
ADD FOREIGN KEY (listing_id) REFERENCES Listing(id),
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhood(neighbourhood);

-- Delete what you copied from Listing except id
ALTER TABLE Listing 
DROP COLUMN street, 
DROP COLUMN neighbourhood, 
DROP COLUMN neighbourhood_cleansed, 
DROP COLUMN state, 
DROP COLUMN zipcode,
DROP COLUMN market, 
DROP COLUMN smart_location, 
DROP COLUMN country_code, 
DROP COLUMN country,
DROP COLUMN latitude, 
DROP COLUMN longitude,
DROP COLUMN is_location_exact;

