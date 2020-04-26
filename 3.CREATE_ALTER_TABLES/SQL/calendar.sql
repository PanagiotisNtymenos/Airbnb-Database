select DISTINCT(listing_id), available from calendar
order by listing_id
limit 100
-- Convert varchar to double
-- 	Delete dollar sign
	UPDATE Calendar
	SET price = NODOLLAR.pr,
		adjusted = NODOLLAR.ad
	FROM (SELECT listing_id,
		  REPLACE(price, '$', '') AS pr, 
		  REPLACE(adjusted, '$', '') AS ad FROM Calendar) AS NODOLLAR
	WHERE Calendar.listing_id = NODOLLAR.listing_id;

-- 	Delete comma in prices
	UPDATE Calendar
	SET price = NOCOMMA.pr,
		adjusted = NOCOMMA.ad
	FROM (SELECT listing_id,
		  CONCAT(split_part(price, ',', 1), split_part(price, ',', 2)) AS pr, 
		  CONCAT(split_part(adjusted, ',', 1), split_part(adjusted, ',', 2)) AS ad FROM Calendar) AS NOCOMMA
	WHERE Calendar.listing_id = NOCOMMA.listing_id;

-- Finally, alter column type
	ALTER TABLE Calendar
	ALTER COLUMN price TYPE DECIMAL(9,2) USING price::numeric(9,2),
	ALTER COLUMN adjusted TYPE DECIMAL(9,2) USING adjusted::numeric(9,2),
	ALTER COLUMN available TYPE BOOL USING CASE WHEN available='t'THEN TRUE ELSE FALSE END;			 
