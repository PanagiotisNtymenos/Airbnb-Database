BEGIN;

ALTER TABLE Calendar
ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);

ALTER TABLE Listings
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhoods(neighbourhood);

ALTER TABLE Reviews
ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);

COMMIT;