SELECT branchname AS Bibliotek,ccode AS Avdelning,authorised_values.lib AS Placering,SUM(Exemplar) AS Exemplar, SUM(Hyllvarmare) AS 'Aldrig utlånat', CONCAT(ROUND(100*(SUM(Hyllvarmare)/SUM(Exemplar)),0), ' %') AS '', SUM(Utlyear) AS 'Utlånat senaste tre åren', CONCAT(ROUND(100*(SUM(Utlyear)/SUM(Exemplar)),0), ' %') AS '', SUM(Utlanat) AS 'Utlånat just nu', CONCAT(ROUND(100*(SUM(Utlanat)/SUM(Exemplar)),0), ' %') AS ''

FROM 
(SELECT homebranch,ccode,location,COUNT(*) AS Exemplar, 0 AS Hyllvarmare, 0 Utlyear, 0 AS Utlanat
FROM items
WHERE items.homebranch LIKE  <<Bibliotek|branches>> 
AND items.ccode LIKE  <<Avdelning|CCODE:all>> 
AND items.location LIKE  <<Placering|LOC:all>> 
AND items.itype LIKE  <<Exemplartyp |itemtypes:all>> 
GROUP BY homebranch,ccode,location

UNION 

SELECT homebranch,ccode,location,0 AS Exemplar, COUNT(*) AS Hyllvarmare, 0 Utlyear, 0 AS Utlanat
FROM items
WHERE items.homebranch LIKE  <<Bibliotek|branches>> 
AND items.ccode LIKE  <<Avdelning|CCODE:all>> 
AND items.location LIKE  <<Placering|LOC:all>> 
AND items.itype LIKE  <<Exemplartyp |itemtypes:all>> 
AND issues='0'
GROUP BY homebranch,ccode,location

UNION

SELECT homebranch,ccode,location,0 AS Exemplar,0 AS Hyllvarmare, COUNT(*) AS Utlyear, 0 AS Utlanat
FROM items
WHERE items.homebranch LIKE  <<Bibliotek|branches>> 
AND items.ccode LIKE  <<Avdelning|CCODE:all>> 
AND items.location LIKE  <<Placering|LOC:all>> 
AND items.itype LIKE  <<Exemplartyp |itemtypes:all>> 
AND items.datelastborrowed >= curdate() - interval 3 year 
GROUP BY homebranch,ccode,location

UNION 

SELECT homebranch,ccode,location,0 AS Exemplar,0 AS Hyllvarmare, 0 Utlyear, COUNT(*) AS Utlanat
FROM items
WHERE items.homebranch LIKE  <<Bibliotek|branches>> 
AND items.ccode LIKE  <<Avdelning|CCODE:all>> 
AND items.location LIKE  <<Placering|LOC:all>> 
AND items.itype LIKE  <<Exemplartyp |itemtypes:all>> 
AND onloan IS NOT NULL
GROUP BY homebranch,ccode,location) t

LEFT JOIN branches ON (t.homebranch=branches.branchcode)
LEFT JOIN authorised_values ON (t.location=authorised_values.authorised_value)

GROUP BY homebranch,ccode,location
ORDER BY homebranch,ccode,location
