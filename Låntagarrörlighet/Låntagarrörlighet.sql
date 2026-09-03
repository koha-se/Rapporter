SELECT hembibl.branchname AS 'Låntagarens hembibliotek',utlbibl.branchname AS 'Utlånande bibliotek',COUNT(*) AS 'Antal lån',COUNT(DISTINCT statistics.borrowernumber) AS 'Antal låntagare'

FROM statistics
LEFT JOIN borrowers ON (borrowers.borrowernumber=statistics.borrowernumber)
LEFT JOIN branches hembibl ON (hembibl.branchcode=borrowers.branchcode)
LEFT JOIN branches utlbibl ON (utlbibl.branchcode=statistics.branch)

WHERE statistics.branch LIKE <<Utlånande bibliotek|branches:all>>
AND borrowers.branchcode LIKE <<Låntagarens hembibliotek|branches:all>> 
AND borrowers.categorycode LIKE <<Låntagarkategori|categorycode:all>>
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY AND statistics.branch IS NOT NULL

GROUP BY borrowers.branchcode,statistics.branch

ORDER BY 2,4
