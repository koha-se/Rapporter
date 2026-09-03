SELECT branchname AS Bibliotek,ccode AS Avdelning,authorised_values.lib AS Placering, SUM(Forvarv) AS 'Förvärvat', SUM(Gallrat) AS 'Gallrat', SUM(Forvarv)-SUM(Gallrat) AS 'Förändring'
FROM
(
SELECT homebranch,ccode,location,COUNT(*) AS Forvarv, 0 AS Gallrat
FROM items
WHERE items.dateaccessioned >= curdate() - interval 1 year
AND items.homebranch LIKE <<Bibliotek|branches>> 
AND items.ccode LIKE  <<Avdelning|CCODE:all>> 
AND items.location LIKE  <<Placering|LOC:all>> 
AND items.itype LIKE  <<Exemplartyp |itemtypes:all>> 
GROUP BY homebranch,ccode,location

UNION

SELECT homebranch,ccode,location,0 'Förvärv', COUNT(*) AS Gallrat
FROM deleteditems
WHERE deleteditems.timestamp >= curdate() - interval 1 year
AND deleteditems.homebranch LIKE <<Bibliotek|branches>>
AND deleteditems.ccode LIKE  <<Avdelning|CCODE:all>> 
AND deleteditems.location LIKE  <<Placering|LOC:all>> 
AND deleteditems.itype LIKE  <<Exemplartyp |itemtypes:all>> 
GROUP BY homebranch,ccode,location
) t

LEFT JOIN branches ON (t.homebranch=branches.branchcode)
LEFT JOIN authorised_values ON (t.location=authorised_values.authorised_value)

GROUP BY homebranch,ccode,location
ORDER BY homebranch,ccode,location
