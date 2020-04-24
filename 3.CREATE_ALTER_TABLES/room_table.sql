-- Create table Room from Query
CREATE TABLE Room AS
SELECT id, accommodates, bathrooms, bedrooms, beds, bed_type, amenities, square_feet, price, weekly_price, monthly_price, security_deposit FROM Listing;

-- Rename id to listings_id
ALTER TABLE Room 
RENAME COLUMN id TO listing_id;

-- Make primary key on Rooms
ALTER TABLE Room
ADD PRIMARY KEY (listing_id);

-- Make foreign key on Rooms
ALTER TABLE Room
ADD FOREIGN KEY (listing_id) REFERENCES Listing(id);

-- Delete what you copied from Listing except id
ALTER TABLE Listing 
DROP COLUMN accommodates, 
DROP COLUMN bathrooms, 
DROP COLUMN bedrooms, 
DROP COLUMN beds, 
DROP COLUMN bed_type,
DROP COLUMN amenities, 
DROP COLUMN square_feet, 
DROP COLUMN price, 
DROP COLUMN weekly_price,
DROP COLUMN monthly_price, 
DROP COLUMN security_deposit;

