SELECT 
  branchname,
  COUNT(CASE WHEN itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','REFERENS','SPRAKKURS','STORSTIL') THEN 1 END) 'Nyförvärv tryckt bok',
  COUNT(CASE WHEN itype IN ('LAROMDL','LAROMTERM') THEN 1 END) 'Nyförvärv läromedel',
  COUNT(CASE WHEN itype IN ('BARN LJUD','BARNMP3','LJUDBOK','MP3') THEN 1 END) 'Nyförvärv ljudböcker',
  COUNT(CASE WHEN itype IN ('BARNTAL','DAISY') THEN 1 END) 'Nyförvärv talböcker daisy',
  COUNT(CASE WHEN itype IN ('MUSIKCD') THEN 1 END) 'Nyförvärv musik',
  COUNT(CASE WHEN itype IN ('BLURAY','FILM','VHS') THEN 1 END) 'Nyförvärv film',
  COUNT(CASE WHEN itype IN ('KARTOR') THEN 1 END) 'Nyförvärv kartor',
  COUNT(CASE WHEN itype IN ('MUSIK') THEN 1 END) 'Nyförvärv noter',
  COUNT(CASE WHEN itype IN ('TV-SPEL') THEN 1 END) 'Nyförvärv TV-spel',
  COUNT(CASE WHEN itype IN ('ARTIKEL','BLANDAT','FOREMAL','SUFRPLATTA','VECKOLAN','X') THEN 1 END) 'Nyförvärv övrigt'
  
FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE items.homebranch = <<Bibliotek|branches>>  
AND items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 


GROUP BY homebranch
