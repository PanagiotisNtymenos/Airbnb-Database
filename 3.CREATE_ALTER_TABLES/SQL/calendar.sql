-- 	Delete dollar sign
	UPDATE Calendar
	SET price = NODOLLAR.pr,
		adjustable_price = NODOLLAR.ad
	FROM (SELECT listing_id, date,
		  REPLACE(price, '$', '') AS pr, 
		  REPLACE(adjustable_price, '$', '') AS ad FROM Calendar) AS NODOLLAR
	WHERE Calendar.listing_id = NODOLLAR.listing_id AND Calendar.date = NODOLLAR.date;

-- 	Delete comma in prices (Use condition to execute Query faster)
	UPDATE Calendar
	SET price = NOCOMMA.pr,
		adjustable_price = NOCOMMA.ad
	FROM (SELECT listing_id, date,
		  CONCAT(split_part(price, ',', 1), split_part(price, ',', 2)) AS pr, 
		  CONCAT(split_part(adjustable_price, ',', 1), split_part(adjustable_price, ',', 2)) AS ad FROM Calendar
		  WHERE price LIKE '%,%' OR adjustable_price LIKE '%,%') AS NOCOMMA
	WHERE Calendar.listing_id = NOCOMMA.listing_id AND Calendar.date = NOCOMMA.date AND (Calendar.price LIKE '%,%' OR Calendar.adjustable_price LIKE '%,%');

-- Finally, alter column type
	ALTER TABLE Calendar
	ALTER COLUMN price TYPE DECIMAL(9,2) USING price::numeric(9,2),
	ALTER COLUMN adjustable_price TYPE DECIMAL(9,2) USING adjustable_price::numeric(9,2),
	ALTER COLUMN available TYPE BOOL USING CASE WHEN available='t' THEN TRUE ELSE FALSE END;	

