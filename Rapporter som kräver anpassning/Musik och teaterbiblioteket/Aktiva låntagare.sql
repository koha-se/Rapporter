SELECT
	CASE
		WHEN attr IN ('m','man') THEN 'Man'
		WHEN attr IN ('k','kvinna') THEN 'Kvinna'
		WHEN attr IN ('i','Svensk institution') THEN 'Svensk Institution'
		WHEN attr IN ('u','Utländsk institution') THEN 'Utländsk Institution'
		WHEN attr IN ('-','Ospecificerat') THEN 'Ospecifierat'
		ELSE 'Okänt'
	END AS 'Kategori',
	mdt AS 'Året som lånt senast var aktiv',
	COUNT(*) AS 'Antal låntagare'
FROM
	(
	SELECT
		borrowers.borrowernumber,
		MAX(borrower_attributes.attribute) attr,
		MAX(LEFT(statistics.datetime,4)) mdt
	FROM
		statistics
	INNER JOIN
		borrowers
	ON
		statistics.borrowernumber = borrowers.borrowernumber
	INNER JOIN
		borrower_attributes
	ON
		borrower_attributes.borrowernumber=borrowers.borrowernumber
	WHERE 
		borrower_attributes.code = 'INST'
	GROUP BY 
		borrowernumber
	) borrowerstats
GROUP BY 1,2 ORDER BY 1,2
