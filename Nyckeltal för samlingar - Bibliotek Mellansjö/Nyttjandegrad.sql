SELECT 
branchname AS Bibliotek, Avdelning, Placering, Utlan, 
Exemplar AS 'Egna exemplar', 
ROUND(
(Utlan/Exemplar)
,1)
AS Nyttjandegrad

FROM
(SELECT statistics.branch, statistics.ccode AS Avdelning, authorised_values.lib AS Placering, COUNT(statistics.type) AS Utlan,
(SELECT COUNT (*)
FROM items

WHERE items.homebranch=statistics.branch
AND items.ccode=statistics.ccode
AND items.location=statistics.location) AS Exemplar

FROM statistics
LEFT JOIN authorised_values ON (statistics.location=authorised_values.authorised_value)

WHERE 
statistics.branch LIKE  <<Bibliotek|branches>> 
AND statistics.ccode LIKE  <<Avdelning|CCODE:all>> 
AND statistics.location LIKE  <<Placering|LOC:all>> 
AND statistics.itemtype LIKE  <<Exemplartyp |itemtypes:all>> 
AND statistics.type='issue'

GROUP BY branch,Avdelning,Placering
ORDER BY branch,ccode,location)t

LEFT JOIN branches ON (t.branch=branches.branchcode)
