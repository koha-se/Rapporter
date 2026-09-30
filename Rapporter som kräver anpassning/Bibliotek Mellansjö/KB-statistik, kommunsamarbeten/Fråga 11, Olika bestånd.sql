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

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND items.itype IN ('BARN TIDSK','BARNBOK','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, 1 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND itemcallnumber LIKE BINARY '%H%' 
AND items.itype IN ('BARN TIDSK','BARNBOK','BOK','LANGLAN','POCKET','TIDSKRIFT'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, 0 as skon, 1 as referensexemplar, 0 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND items.location IN ('REFERENS'))

UNION ALL

(SELECT items.homebranch, 0 as barn, 0 as skon, 0 as referensexemplar, 1 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> AND items.itype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL','TALBOKKASS'))

UNION ALL 

(SELECT items.homebranch, -1 as barn, 0 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE (items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND items.itype IN ('BARN TIDSK','BARNBOK','BARNKORT','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, -1 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE (items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND itemcallnumber LIKE BINARY '%H%' 
AND items.itype IN ('BARN TIDSK','BARNBOK','BARNKORT','BOK','KORTLON','LANGLAN','POCKET','TIDSKRIFT'))

UNION ALL 

(SELECT items.homebranch, 0 as barn, 0 as skon, -1 as referensexemplar, 0 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE (items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND items.location IN ('REFERENS'))

UNION ALL

(SELECT items.homebranch, 0 as barn, 0 as skon, 0 as referensexemplar, -1 as lasnedsattning
FROM items 

LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE (items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> AND items.itype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL','TALBOKKASS'))

UNION ALL 

(SELECT deleteditems.homebranch, 1 as barn, 0 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM deleteditems 

LEFT JOIN library_groups ON (deleteditems.homebranch=library_groups.branchcode)

WHERE (deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND deleteditems.itype IN ('BARN TIDSK','BARNBOK','BARNKORT','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL'))

UNION ALL 

(SELECT deleteditems.homebranch, 0 as barn, 1 as skon, 0 as referensexemplar, 0 as lasnedsattning
FROM deleteditems 

LEFT JOIN library_groups ON (deleteditems.homebranch=library_groups.branchcode)

WHERE (deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND deleteditems.itemcallnumber LIKE BINARY '%H%' 
AND deleteditems.itype IN ('BARN TIDSK','BARNBOK','BARNKORT','BOK','KORTLON','LANGLAN','POCKET','TIDSKRIFT'))

UNION ALL 

(SELECT deleteditems.homebranch, 0 as barn, 0 as skon, 1 as referensexemplar, 0 as lasnedsattning
FROM deleteditems 

LEFT JOIN library_groups ON (deleteditems.homebranch=library_groups.branchcode)

WHERE (deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 
AND deleteditems.location IN ('REFERENS'))

UNION ALL

(SELECT deleteditems.homebranch, 0 as barn, 0 as skon, 0 as referensexemplar, 1 as lasnedsattning
FROM deleteditems 

LEFT JOIN library_groups ON (deleteditems.homebranch=library_groups.branchcode)

WHERE (deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> AND deleteditems.itype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL','TALBOKKASS'))

) ds

LEFT JOIN branches ON (branches.branchcode=ds.homebranch)

GROUP BY branches.branchname WITH ROLLUP
