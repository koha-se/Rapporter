SELECT 
CASE WHEN 
branches.branchname IS NULL
THEN '=Summa'
ELSE
branches.branchname 
END 
AS Bibliotek,

SUM(barn) AS 'Bestånd för barn och unga',
SUM(skon) AS 'Bestånd av skönlitteratur',
SUM(referensexemplar) AS'Antal referensexemplar',
SUM(lasnedsattning) AS 'Bestånd läsnedsättning'


FROM
(
(SELECT items.homebranch, 1 as barn, 0 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM items 

WHERE items.homebranch LIKE <<Bibliotek|branches:all>>
AND items.itype IN ('BARN TIDSK','BARNBOK','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, 1 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM items 

WHERE items.homebranch LIKE <<Bibliotek|branches:all>>
AND itemcallnumber LIKE BINARY '%H%' 
AND items.itype IN ('BARN TIDSK','BARNBOK','BOK','LANGLAN','POCKET','TIDSKRIFT'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, 0 as skon, 1 as referensexemplar, 0 as lasnedsattning
FROM items 

WHERE items.homebranch LIKE <<Bibliotek|branches:all>>
AND items.location IN ('REFERENS'))

UNION ALL

(SELECT items.homebranch, 0 as barn, 0 as skon, 0 as referensexemplar, 1 as lasnedsattning
FROM items 

WHERE items.homebranch LIKE <<Bibliotek|branches:all>> 
AND items.itype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL','TALBOKKASS'))

) ds

LEFT JOIN branches ON (branches.branchcode=ds.homebranch)

GROUP BY branches.branchname WITH ROLLUP
