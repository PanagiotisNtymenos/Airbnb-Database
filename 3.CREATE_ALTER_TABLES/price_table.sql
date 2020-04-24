-- Create table Price from Query
CREATE TABLE Price AS
SELECT id, price, weekly_price, monthly_price, security_deposit, cleaning_fee,
			guests_included, extra_people, minimum_nights, maximum_nights,
			minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights,
			maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm FROM ListingsB;

-- Rename id to listings_id
ALTER TABLE Price 
RENAME COLUMN id TO listing_id;

-- Convert prices to double precision
-- 	Delete dollar sign
	UPDATE Price
	SET price = NODOLLAR.pr,
		weekly_price = NODOLLAR.wpr,
		monthly_price = NODOLLAR.mpr,
		security_deposit = NODOLLAR.sd,
		cleaning_fee = NODOLLAR.cf,
		extra_people = NODOLLAR.ep
	FROM (SELECT listing_id,
		  REPLACE(price, '$', '') AS pr, 
		  REPLACE(weekly_price, '$', '') AS wpr, 
		  REPLACE(monthly_price, '$', '') AS mpr,
		  REPLACE(security_deposit, '$', '') AS sd,
		  REPLACE(cleaning_fee, '$', '') AS cf,
		  REPLACE(extra_people, '$', '') AS ep FROM Price) AS NODOLLAR
	WHERE Price.listing_id = NODOLLAR.listing_id;

-- 	Delete comma in prices
	SELECT CONCAT(split_part(monthly_price, ',', 1), split_part(monthly_price, ',', 2)) FROM Price;
	UPDATE Price
	SET price = NOCOMMA.pr,
		weekly_price = NOCOMMA.wpr,
		monthly_price = NOCOMMA.mpr,
		security_deposit = NOCOMMA.sd,
		cleaning_fee = NOCOMMA.cf,
		extra_people = NOCOMMA.ep
	FROM (SELECT listing_id,
		  CONCAT(split_part(price, ',', 1), split_part(price, ',', 2)) AS pr, 
		  CONCAT(split_part(weekly_price, ',', 1), split_part(weekly_price, ',', 2)) AS wpr, 
		  CONCAT(split_part(monthly_price, ',', 1), split_part(monthly_price, ',', 2)) AS mpr,
		  CONCAT(split_part(security_deposit, ',', 1), split_part(security_deposit, ',', 2)) AS sd,
		  CONCAT(split_part(cleaning_fee, ',', 1), split_part(cleaning_fee, ',', 2)) AS cf,
		  CONCAT(split_part(extra_people, ',', 1), split_part(extra_people, ',', 2)) AS ep FROM Price) AS NOCOMMA
	WHERE Price.listing_id = NOCOMMA.listing_id;
	
-- 	Restore any NULL cells
	UPDATE Price
	SET weekly_price = NULL
	WHERE weekly_price = '';
				 
	UPDATE Price
	SET monthly_price = NULL
	WHERE monthly_price = '';
	
	UPDATE Price
	SET security_deposit = NULL
	WHERE security_deposit = '';
		
	UPDATE Price
	SET cleaning_fee = NULL
	WHERE cleaning_fee = '';
				 
	UPDATE Price
	SET extra_people = NULL
	WHERE extra_people = '';
				 
-- 	Finally, alter columns' type
	ALTER TABLE Price
	ALTER COLUMN price TYPE DECIMAL(9,2) USING price::numeric(9,2),
	ALTER COLUMN weekly_price TYPE DECIMAL(9,2) USING weekly_price::numeric(9,2),
	ALTER COLUMN monthly_price TYPE DECIMAL(9,2) USING monthly_price::numeric(9,2),
	ALTER COLUMN security_deposit TYPE DECIMAL(9,2) USING security_deposit::numeric(9,2),
	ALTER COLUMN cleaning_fee TYPE DECIMAL(9,2) USING cleaning_fee::numeric(9,2),
	ALTER COLUMN extra_people TYPE DECIMAL(9,2) USING extra_people::numeric(9,2);
				 

-- Make primary key on Price
ALTER TABLE Price
ADD PRIMARY KEY (listing_id);

-- Make foreign key on Rooms
ALTER TABLE Price
ADD FOREIGN KEY (listing_id) REFERENCES Listing(id);

-- Delete what you copied from Listing except id (Some are already dropped from before. I used my backup to copy!)
ALTER TABLE Listing 
DROP COLUMN cleaning_fee, 
DROP COLUMN guests_included, 
DROP COLUMN extra_people, 
DROP COLUMN minimum_nights, 
DROP COLUMN maximum_nights,
DROP COLUMN minimum_minimum_nights, 
DROP COLUMN maximum_minimum_nights, 
DROP COLUMN minimum_maximum_nights, 
DROP COLUMN maximum_maximum_nights,
DROP COLUMN minimum_nights_avg_ntm, 
DROP COLUMN maximum_nights_avg_ntm;

