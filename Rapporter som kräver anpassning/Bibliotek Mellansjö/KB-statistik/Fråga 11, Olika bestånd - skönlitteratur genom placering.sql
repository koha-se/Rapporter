SELECT 
  COUNT(CASE WHEN itype IN ('BARNBOK','BARNKORT','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL','MUSIKBARN','MUSIKBARN') THEN 1 END) 'Bestånd för barn och unga',
  COUNT(CASE WHEN location IN ('Skonlitteratur','Deckare','Deckare & Thriller','Fantasy','Fantasy/SF','Noveller') THEN 1 END) 'Bestånd av skönlitteratur',
  COUNT(CASE WHEN location IN ('REFERENS') THEN 1 END) 'Antal referensexemplar',
  COUNT(CASE WHEN itype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL') THEN 1 WHEN location IN ('Lattlast','Appelhyllan') THEN 1 END) 'Bestånd läsnedsättning'
  
FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

 WHERE items.homebranch = <<Bibliotek|branches>> 
