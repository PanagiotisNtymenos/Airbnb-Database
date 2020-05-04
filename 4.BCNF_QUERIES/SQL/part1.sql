-- Create Amenity table with one column. Select unique amenities from Room table 
CREATE TABLE Amenity AS
	(SELECT DISTINCT UNNEST(amenities::text[]) AS amenity_name FROM Room);

 
-- Create column with Primary Key using SERIAL(αυτόματη προσαύξηση)
ALTER  TABLE Amenity
ADD COLUMN amenity_id SERIAL PRIMARY KEY;

 
-- Change amenity_name TYPE since we don't need it to be this big anymore
ALTER TABLE Amenity
ALTER COLUMN amenity_name TYPE varchar(100);
 
 
-- Create a NEW Table to connect the tables Room and Amenity (Don't keep any duplicates). 
CREATE TABLE Room_Amenity AS
	(SELECT DISTINCT RM.listing_id, Amenity.amenity_id FROM Amenity,
		(SELECT Room.listing_id, UNNEST(amenities::text[]) AS am_name FROM Room) AS RM
	WHERE RM.am_name = Amenity.amenity_name);

	 
-- Make both columns as Primary Key
ALTER TABLE Room_Amenity
ADD PRIMARY KEY(listing_id, amenity_id);
	 

-- Connect the two tables by creating Foreign Keys	 
ALTER TABLE Room_Amenity
ADD FOREIGN KEY(listing_id) REFERENCES Room(listing_id),
ADD FOREIGN KEY(amenity_id) REFERENCES Amenity(amenity_id); 

	 
-- Now, delete the amenities column from Room
ALTER TABLE Room
DROP COLUMN amenities;