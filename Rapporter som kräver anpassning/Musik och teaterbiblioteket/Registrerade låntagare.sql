SELECT
	CASE
		WHEN attr IN ('m','man') THEN 'Man'
		WHEN attr IN ('k','kvinna') THEN 'Kvinna'
		WHEN attr IN ('i','Svensk institution') THEN 'Svensk Institution'
		WHEN attr IN ('u','Utländsk institution') THEN 'Utländsk Institution'
		WHEN attr IN ('-','Ospecificerat') THEN 'Ospecifierat'
		ELSE 'Okänt'
	END AS 'Kategori',
    COUNT(*) AS 'Antal låntagare'
FROM
	(
	SELECT
		borrowers.borrowernumber,
		MAX(borrower_attributes.attribute) attr
	FROM
		borrowers
	LEFT OUTER JOIN
		borrower_attributes
	ON
		borrower_attributes.borrowernumber=borrowers.borrowernumber
	WHERE 
		COALESCE(borrower_attributes.code = 'INST', borrower_attributes.borrowernumber IS NULL)
	GROUP BY 
		borrowernumber
	) borrowerstats
GROUP BY 1 ORDER BY 1
