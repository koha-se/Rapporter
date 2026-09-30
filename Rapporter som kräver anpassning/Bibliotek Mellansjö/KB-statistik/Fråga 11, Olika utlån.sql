SELECT 
  branchname AS Bibliotek,
  COUNT(CASE WHEN type IN ('issue','renew') AND itemtype IN ('BARNBOK','BARNKORT','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL') THEN 1 END) 'Utlån för barn',
  COUNT(CASE WHEN type IN ('issue','renew') AND itemtype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL') THEN 1 WHEN type IN ('issue','renew') AND location IN ('Lattlast','Appelhyllan') THEN 1 END) 'Utlån läsnedsättning'  
FROM statistics

LEFT JOIN branches ON (statistics.branch=branches.branchcode)

WHERE statistics.branch = <<Bibliotek|branches>> 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
 


GROUP BY branch
