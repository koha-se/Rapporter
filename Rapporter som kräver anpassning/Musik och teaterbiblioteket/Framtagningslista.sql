SELECT *
FROM (SELECT items.location, items.itemcallnumber, biblio.title AS 'Titel', biblio.author AS 'Upphov', biblio.copyrightdate,
      reserves.reservedate AS 'Reservationsdatum', reserves.reservenotes AS 'Kommentar',
      CONCAT_WS(' ', borrowers.firstname, borrowers.surname) AS 'Låntagare',
DENSE_RANK() OVER (PARTITION BY biblio.biblionumber ORDER BY reserves.reservedate ASC, reserves.reserve_id ASC) AS reserveenumeration,
DENSE_RANK() OVER (PARTITION BY biblio.biblionumber ORDER BY 
                   CASE WHEN items.location = 'PjäsHem' THEN '0'
                   WHEN items.location LIKE 'EMS%' THEN CONCAT('2', items.location)
                   WHEN items.location IN ('SVA', 'Referens', 'Rariteter') THEN CONCAT('3', items.location)
                   ELSE CONCAT('1', items.location) END
                   ASC, items.copynumber ASC,items.barcode) AS itemenumeration,
      waitortransit.itemnumber IS NOT NULL AS waitortransit
FROM borrowers INNER JOIN reserves ON borrowers.borrowernumber = reserves.borrowernumber
INNER JOIN biblio ON biblio.biblionumber = reserves.biblionumber
INNER JOIN items ON biblio.biblionumber = items.biblionumber
LEFT OUTER JOIN issues ON issues.itemnumber = items.itemnumber
LEFT OUTER JOIN
      (
      SELECT itemnumber FROM reserves WHERE found IN ('W','T')
      ) AS waitortransit
ON items.itemnumber = waitortransit.itemnumber
WHERE issues.itemnumber IS NULL
AND reserves.suspend = 0
AND (reserves.itemnumber = items.itemnumber OR reserves.itemnumber IS NULL)
AND items.itemlost = '0'
AND COALESCE(reserves.found,'') NOT IN ('W','T')) X
WHERE reserveenumeration = itemenumeration
AND NOT waitortransit
AND (location NOT LIKE 'EMS%' AND location NOT LIKE 'Orkester')
ORDER BY location, itemcallnumber
