SELECT 
CASE 
WHEN 
branchname IS NULL
THEN '=Summa'
ELSE
branchname
END
AS Bibliotek,
  COUNT(CASE WHEN itype IN ('BARN TIDSK','BARNBOK','BOKCDBARN','BOKDAISYBA','BOKMP3BARN') THEN 1 END) 'Nyförvärv tryckt för barn'
  
FROM items

LEFT JOIN branches ON (items.homebranch=branches.branchcode)
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)
LEFT JOIN library_groups kommun ON (library_groups.parent_id=kommun.id)

WHERE items.homebranch IS NOT NULL AND items.dateaccessioned BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>


GROUP BY branchname WITH ROLLUP
