	UPDATE Cal
	SET price = NODOLLAR.pr,
		adjusted = NODOLLAR.ad
	FROM (SELECT listing_id, date,
		  REPLACE(price, '$', '') AS pr, 
		  REPLACE(adjusted, '$', '') AS ad FROM Calendarb) AS NODOLLAR
	WHERE Cal.listing_id = NODOLLAR.listing_id AND Cal.date = NODOLLAR.date;
																								   
 