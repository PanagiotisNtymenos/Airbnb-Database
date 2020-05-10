-- Change listings_count value as soon as a listing is added or deleted for the appropriate Host. 

-- ΣΧΟΛΙΑ
-- (ΔΕΝ έφτιαξα κάποια συνάρτηση που να ικανοποιεί την επιλογή UPDATE στον πίνακα Listing καθώς λέτε "όταν προστίθεται/διαγράφεται μία εγγραφή".)
-- (ΔΕΝ διαγράφονται/προστίθενται τα αντίστοιχα rows στους πίνακες Price, Room κλπ., από την στιγμή που θέλετε να επηρεάζεται μόνο το πεδίο του Host.)

-- The function called by the trigger
CREATE FUNCTION log_host_listings_count_changes() 
	RETURNS trigger AS 
$BODY$
	BEGIN
		IF (TG_OP = 'DELETE') THEN
			UPDATE Host SET listings_count = listings_count - 1
			WHERE id = OLD.host_id;
			
			RETURN OLD;		
		ELSIF (TG_OP = 'INSERT') THEN
			UPDATE Host SET listings_count = listings_count + 1
			WHERE id = NEW.host_id;
			
			RETURN NEW;
		END IF;
	END;
$BODY$ LANGUAGE plpgsql;	

-- The actual trigger
CREATE TRIGGER host_listings_count_changes AFTER DELETE OR INSERT ON Listing
	FOR EACH ROW
	EXECUTE PROCEDURE log_host_listings_count_changes();



-- MY TRIGGER

-- ΠΕΡΙΓΡΑΦΗ
-- Κάθε φορά που διαγράφεται/προστίθεται ένα review από τον πίνακα Review, τότε το πεδίο number_of_reviews του Listing πρέπει να ενημερώνεται κατάλληλα.

-- The function called by the trigger
CREATE FUNCTION log_number_of_reviews_changes() 
	RETURNS trigger AS 
$BODY$
	BEGIN
		IF (TG_OP = 'DELETE') THEN
			UPDATE Listing SET number_of_reviews = number_of_reviews - 1
			WHERE Listing.id = OLD.listing_id;
			
			RETURN OLD;		
		ELSIF (TG_OP = 'INSERT') THEN
			UPDATE Listing SET number_of_reviews = number_of_reviews + 1
			WHERE Listing.id = NEW.listing_id;
			
			RETURN NEW;
		END IF;
	END;
$BODY$ LANGUAGE plpgsql;	

-- The actual trigger
CREATE TRIGGER number_of_reviews_changes AFTER DELETE OR INSERT ON Review
	FOR EACH ROW
	EXECUTE PROCEDURE log_number_of_reviews_changes();
