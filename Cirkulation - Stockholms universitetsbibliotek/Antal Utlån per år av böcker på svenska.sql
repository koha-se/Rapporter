SELECT substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36, 3) AS Språk, COUNT(*) AS Antal 
FROM statistics s
LEFT JOIN items i ON (s.itemnumber=i.itemnumber)
LEFT JOIN biblio b ON (i.biblionumber=b.biblionumber)
LEFT JOIN biblio_metadata bm ON (b.biblionumber=bm.biblionumber)
WHERE s.type='issue'
AND YEAR(datetime) = <<Välj ÅR ÅÅÅÅ>> 
GROUP BY Språk 
HAVING Språk = 'swe'
