SELECT 
CASE
WHEN branches.branchname IS NULL
THEN '=Summa'
ELSE
branches.branchname
END
AS Bibliotek,
SUM(tryckt) AS 'Nyförvärv tryckt bok',
SUM(laromedel) AS 'Nyförvärv läromedel',
SUM(ljudbok) AS 'Nyförvärv ljudböcker',
SUM(talbok) AS 'Nyförvärv talböcker daisy',
SUM(musik) AS 'Nyförvärv musik',
SUM(film) AS 'Nyförvärv film',
SUM(kartor) AS 'Nyförvärv kartor',
SUM(noter) 'Nyförvärv noter',
SUM(tvspel) 'Nyförvärv Tv-spel',
SUM(ovrigt) AS 'Nyförvärv övrigt'
FROM
(
(SELECT items.homebranch,1 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)
LEFT JOIN biblio ON (biblio.biblionumber=items.biblionumber)

WHERE 
(biblio.frameworkcode !='BOKP') 
AND items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,materials as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)
LEFT JOIN biblio ON (biblio.biblionumber=items.biblionumber)

WHERE 
(biblio.frameworkcode ='BOKP')
AND items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,1 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('LAROMDL','LAROMTERM')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,1 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,1 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('BARNTAL','DAISY','TALBOKKASS')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,1 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('MUSIKCD','MUSCDBARN')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,1 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('BLURAY','FILM','VHS')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,1 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('KARTOR')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,1 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('MUSIK') 
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,1 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('TV-SPEL')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,1 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE 
items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.itype IN ('ARTIKEL','BLANDAT','BOKPASE','CDROM','FOREMAL','FOREMAL3MD','KONTROLL','SUFRPLATTA','VECKOLAN','X')
AND items.homebranch IS NOT NULL AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 
) ds
LEFT JOIN branches ON (branches.branchcode=ds.homebranch)
GROUP BY branches.branchname WITH ROLLUP
