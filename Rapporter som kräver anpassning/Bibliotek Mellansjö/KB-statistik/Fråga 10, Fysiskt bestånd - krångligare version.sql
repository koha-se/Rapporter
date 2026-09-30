SELECT 
CASE
WHEN branches.branchname IS NULL
THEN '=Summa'
ELSE
branches.branchname
END
AS Bibliotek,
SUM(tryckt) AS 'Bestånd tryckt bok',
SUM(laromedel) AS 'Bestånd läromedel',
SUM(ljudbok) AS 'Bestånd ljudböcker',
SUM(talbok) AS 'Bestånd talböcker daisy',
SUM(musik) AS 'Bestånd musik',
SUM(film) AS 'Bestånd film',
SUM(kartor) AS 'Bestånd kartor',
SUM(noter) 'Bestånd noter',
SUM(tvspel) 'Bestånd Tv-spel',
SUM(ovrigt) AS 'Bestånd övrigt'
FROM
(
(SELECT items.homebranch,1 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')
AND items.homebranch LIKE <<Bibliotek|branches:all>>)

UNION ALL

(SELECT items.homebranch,0 as tryckt,1 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('LAROMDL','LAROMTERM')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,1 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,1 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('BARNTAL','DAISY','TALBOKKASS')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,1 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('MUSIKCD','MUSCDBARN')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,1 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('BLURAY','FILM','VHS')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,1 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('KARTOR')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,1 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('MUSIK','MUSIKBARN') 
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,1 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('TV-SPEL')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,1 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
items.itype IN ('BLANDAT','BOKPASE','CDROM','FOREMAL','FOREMAL3MD','KONTROLL','SALLSKAPSS','SUFRPLATTA','VECKOLAN','X')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,-1 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,-1 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('LAROMDL','LAROMTERM')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,-1 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,-1 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('BARNTAL','DAISY','TALBOKKASS')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,-1 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('MUSIKCD','MUSCDBARN')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,-1 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('BLURAY','FILM','VHS')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,-1 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('KARTOR')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,-1 as noter,0 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('MUSIK','MUSIKBARN') 
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,-1 as tvspel,0 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('TV-SPEL')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT items.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,-1 as ovrigt
FROM items 

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE 
(items.dateaccessioned BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE()) 
AND items.itype IN ('ARTIKEL','BLANDAT','BOKPASE','CDROM','FOREMAL','FOREMAL3MD','KONTROLL','SALLSKAPSS','SUFRPLATTA','VECKOLAN','X')
AND items.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,1 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,1 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('LAROMDL','LAROMTERM')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,1 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE (deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,1 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('BARNTAL','DAISY','TALBOKKASS')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,1 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('MUSIKCD','MUSCDBARN')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,1 as film,0 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('BLURAY','FILM','VHS')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,1 as kartor,0 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('KARTOR')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,1 as noter,0 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('MUSIK','MUSIKBARN') 
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,1 as tvspel,0 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('TV-SPEL')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 

UNION ALL

(SELECT deleteditems.homebranch,0 as tryckt,0 as laromedel,0 as ljudbok,0 as talbok,0 as musik,0 as film,0 as kartor,0 as noter,0 as tvspel,1 as ovrigt
FROM deleteditems 

LEFT JOIN branches ON (deleteditems.homebranch=branches.branchcode)

WHERE 
(deleteditems.timestamp BETWEEN <<Datum (Nyårsafton i KB-statistiken)|date>> AND CURDATE())
AND deleteditems.itype IN ('ARTIKEL','BLANDAT','BOKPASE','CDROM','FOREMAL','FOREMAL3MD','KONTROLL','SALLSKAPSS','SUFRPLATTA','VECKOLAN','X')
AND deleteditems.homebranch  LIKE <<Bibliotek|branches:all>>) 
) ds
LEFT JOIN branches ON (branches.branchcode=ds.homebranch)
GROUP BY branches.branchname WITH ROLLUP
