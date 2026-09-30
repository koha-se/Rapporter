SELECT 
  branchname,
  COUNT(CASE WHEN itype IN ('BARN LJUD','BARN TIDSK','BARNBOK','BARNKORT','BOKCDBARN','BOKDAISYBA','BOKMP3BARN') THEN 1 END) 'Nyförvärv tryckt för barn'
  
FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)

WHERE items.homebranch IS NOT NULL 
AND items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND items.homebranch = <<Bibliotek|branches>>


GROUP BY homebranch
