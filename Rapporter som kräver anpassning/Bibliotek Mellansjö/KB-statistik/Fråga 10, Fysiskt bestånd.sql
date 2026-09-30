SELECT 
  branchname,
  COUNT(CASE WHEN itype IN ('BARNBOK','BARNKORT','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','KORTLON','LANGLAN','PAKET','REFERENS','SPRAKKURS','STORSTIL') THEN 1 END) 'Bestånd tryckt bok',
  COUNT(CASE WHEN itype IN ('LAROMDL','LAROMTERM') THEN 1 END) 'Bestånd läromedel',
  COUNT(CASE WHEN itype IN ('BARN LJUD','BARNMP3','LJUDBOK','MP3') THEN 1 END) 'Bestånd ljudböcker',
  COUNT(CASE WHEN itype IN ('BARNTAL','DAISY') THEN 1 END) 'Bestånd talböcker daisy',
  COUNT(CASE WHEN itype IN ('MUSIKCD') THEN 1 END) 'Bestånd musik',
  COUNT(CASE WHEN itype IN ('BLURAY','FILM','VHS') THEN 1 END) 'Bestånd film',
  COUNT(CASE WHEN itype IN ('KARTOR') THEN 1 END) 'Bestånd kartor',
  COUNT(CASE WHEN itype IN ('MUSIK') THEN 1 END) 'Bestånd noter',
  COUNT(CASE WHEN itype IN ('TV-SPEL') THEN 1 END) 'Bestånd TV-spel',
  COUNT(CASE WHEN itype IN ('ARTIKEL','BLANDAT','FOREMAL','SUFRPLATTA','VECKOLAN','X') THEN 1 END) 'Bestånd övrigt'
  
FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE items.homebranch = <<Bibliotek|branches>> 
