SELECT 
  branchname AS Bibliotek,
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','REFERENS','SPRAKKURS','STORSTIL') THEN 1 END) 'Utlån tryckt bok',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAICY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','REFERENS','SPRAKKURS','STORSTIL') THEN 1 END) 'Omlån tryckt bok',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('LAROMDL','LAROMTERM') THEN 1 END) 'Utlån läromedel',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('LAROMDL','LAROMTERM') THEN 1 END) 'Omlån läromedel',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('BARN LJUD','BARNMP3','LJUDBOK','MP3') THEN 1 END) 'Utlån ljudböcker',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('BARN LJUD','BARNMP3','LJUDBOK','MP3') THEN 1 END) 'Omlån ljudböcker',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('BARNTAL','DAISY') THEN 1 END) 'Utlån talböcker daisy',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('BARNTAL','DAISY') THEN 1 END) 'Omlån talböcker daisy',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('BARN TIDSK','TIDSKRIFT') THEN 1 END) 'Utlån tidskrifter',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('BARN TIDSK','TIDSKRIFT') THEN 1 END) 'Omlån tidskrifter',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('MUSIKCD') THEN 1 END) 'Utlån musik',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('MUSIKCD') THEN 1 END) 'Omlån musik',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('BLURAY','FILM','VHS') THEN 1 END) 'Utlån film',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('BLURAY','FILM','VHS') THEN 1 END) 'Omlån film',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('KARTOR') THEN 1 END) 'Utlån kartor',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('KARTOR') THEN 1 END) 'Omlån kartor',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('MUSIK','MUSIKBARN') THEN 1 END) 'Utlån noter',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('MUSIK','MUSIKBARN') THEN 1 END) 'Omlån noter',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('TV-SPEL') THEN 1 END) 'Utlån TV-spel',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('TV-SPEL') THEN 1 END) 'Omlån TV-spel',
  COUNT(CASE WHEN type = 'issue' AND itemtype IN ('ARTIKEL','BLANDAT','FOREMAL','SUFRPLATTA','VECKOLAN','X') THEN 1 END) 'Utlån övrigt',
  COUNT(CASE WHEN type = 'renew' AND itemtype IN ('ARTIKEL','BLANDAT','FOREMAL','SUFRPLATTA','VECKOLAN','X') THEN 1 END) 'Omlån övrigt'

FROM statistics

LEFT JOIN branches ON (statistics.branch=branches.branchcode)

WHERE statistics.branch=<<Bibliotek|branches>> 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 


GROUP BY branch

ORDER BY branchname
