SELECT COALESCE(cat," Total") AS cat,loans,loans/MAX(loans) OVER (ORDER BY loans DESC)*100 FROM
(
SELECT
	CASE
		WHEN attr IN ('k') THEN 'Blekinge'
		WHEN attr IN ('w') THEN 'Dalarna'
		WHEN attr IN ('i') THEN 'Gotland'
		WHEN attr IN ('x') THEN 'Gävleborg'
		WHEN attr IN ('n') THEN 'Halland'
		WHEN attr IN ('z') THEN 'Jämtland'
		WHEN attr IN ('f') THEN 'Jönköping'
		WHEN attr IN ('h') THEN 'Kalmar'
		WHEN attr IN ('g') THEN 'Kronoberg'
		WHEN attr IN ('b') THEN 'Norrbotten'
		WHEN attr IN ('m') THEN 'Skåne'
		WHEN attr IN ('a') THEN 'Stockholm'
		WHEN attr IN ('d') THEN 'Södermanland'
		WHEN attr IN ('c') THEN 'Uppsala'
		WHEN attr IN ('s') THEN 'Värmland'
		WHEN attr IN ('1') THEN 'Västerbotten'
		WHEN attr IN ('y') THEN 'Västernorrland'
		WHEN attr IN ('u') THEN 'Västmanland'
		WHEN attr IN ('o') THEN 'Västra Götaland'
		WHEN attr IN ('t') THEN 'Örebro'
		WHEN attr IN ('e') THEN 'Östergötland'
		ELSE 'Okänt'
	END AS cat,
	COUNT(*) AS loans
FROM
	(
	SELECT
		borrowers.borrowernumber,
		MAX(borrower_attributes.attribute) attr
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
		borrower_attributes.code = 'LÄN'
      	AND statistics.datetime BETWEEN <<Välj startdatum|date>> AND <<och slutdatum|date>>
	GROUP BY 
		borrowernumber
	) borrowerstats
GROUP BY 1 WITH ROLLUP
) x
ORDER BY 1
