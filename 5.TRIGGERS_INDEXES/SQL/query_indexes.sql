/* FIRST BULLET: w/out index: 32.145 ms; w/index: 18.723 ms */

CREATE INDEX INDEX_host_id ON Listing(host_id);

DROP INDEX INDEX_host_id;


/* SECOND BULLET: w/out index: 2036.344 ms; w/index: 1938.590 ms */

CREATE INDEX INDEX_price ON Price(price);

DROP INDEX INDEX_price;


/* THIRD BULLET: */

	/* Query 1: w/out index: 19.067 ms; w/index: 13.269 ms */

	CREATE INDEX INDEX_lid_AND_neighcl ON Location(listing_id, neighbourhood_cleansed);
	CREATE INDEX INDEX_host_id ON Listing(host_id);

	DROP INDEX INDEX_lid_AND_neighcl;
	DROP INDEX INDEX_host_id;


	/* Query 2: w/out index: 1295.647 ms; w/index: 421.477 ms */

	CREATE INDEX INDEX_lid ON Review(listing_id);
	CREATE INDEX INDEX_amenity_name ON Amenity(amenity_name);

	DROP INDEX INDEX_lid;
	DROP INDEX INDEX_amenity_name;
	

	/* Query 3: w/out index: 12.613 ms; w/index: 1.265 ms */

	CREATE INDEX INDEX_neighcl ON Location(neighbourhood_cleansed);
	CREATE INDEX INDEX_price_AND_lid ON Price(price, listing_id);
	CREATE INDEX INDEX_bedrooms_AND_lid ON Room(bedrooms, listing_id);

	DROP INDEX INDEX_neighcl;
	DROP INDEX INDEX_price_AND_lid;
	DROP INDEX INDEX_bedrooms_AND_lid;


	/* Query 4: w/out index: 38.386 ms; w/index: 29.907 ms */

	CREATE INDEX INDEX_host_id ON Listing(host_id);			

	DROP INDEX INDEX_host_id;


	/* Query 5: w/out index: 11.173 ms; w/index: 0.149 ms */

	CREATE INDEX INDEX_price_AND_lid ON Price(price, listing_id);
	CREATE INDEX INDEX_host_id ON Listing(host_id);

	DROP INDEX INDEX_price_AND_lid;
	DROP INDEX INDEX_host_id;