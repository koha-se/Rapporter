SELECT branchname,ccode AS Avdelning,authorised_values.lib AS Placering,
SUBSTRING(FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(dateaccessioned))),1,10) AS 'Förvärvad',
SUBSTRING(FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(datelastborrowed))),1,10) AS 'Senast lånad',
ROUND(AVG(issues),1) AS 'Antal lån sedan boken köptes'

FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN authorised_values ON (items.location=authorised_values.authorised_value)

WHERE dateaccessioned IS NOT NULL
AND datelastborrowed IS NOT NULL
AND homebranch LIKE  <<Bibliotek|branches>> 
AND ccode LIKE  <<Avdelning|CCODE:all>> 
AND location LIKE  <<Placering|LOC:all>> 
AND itype LIKE <<Exemplartyp |itemtypes:all>> 


GROUP BY homebranch,ccode,location
ORDER BY homebranch,ccode,location
