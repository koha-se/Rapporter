SELECT 
hembibl.branchname AS 'Hembibliotek',utlbibl.branchname AS 'Utlånande bibliotek',
CONCAT('<a href=\"https://kartor.eniro.se/sok/', REPLACE(zipcode, ' ', '' ), '\" target="_blank">', REPLACE(zipcode, ' ', '' ), '</a>' ) AS 'Postnummer',
COUNT(*) 'Antal lån', COUNT(DISTINCT statistics.borrowernumber) AS 'Antal låntagare'

FROM
statistics
LEFT JOIN borrowers ON (borrowers.borrowernumber=statistics.borrowernumber)
LEFT JOIN branches utlbibl ON (utlbibl.branchcode=statistics.branch)
LEFT JOIN branches hembibl On (hembibl.branchcode=borrowers.branchcode)

WHERE statistics.itemtype IS NOT NULL 
AND statistics.type='issue' 
AND statistics.branch LIKE <<Utlånanade bibliotek|branches:all>>
AND borrowers.branchcode LIKE <<Låntagarens hembibliotek|branches:all>>
AND borrowers.categorycode LIKE <<Låntagarkategori|categorycode:all>>
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND CHAR_LENGTH(REPLACE(zipcode, ' ', '' ))=5

GROUP BY statistics.branch,borrowers.branchcode,REPLACE(zipcode, ' ', '' )
ORDER BY REPLACE(zipcode, ' ', '' ),utlbibl.branchname,hembibl.branchname
