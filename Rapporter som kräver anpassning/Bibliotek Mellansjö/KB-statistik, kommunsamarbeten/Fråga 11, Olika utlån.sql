SELECT 
CASE 
WHEN branchname IS NULL
THEN '=Summa'
ELSE
branchname
END
AS Bibliotek, SUM(barn) AS 'Utlån barn', SUM (lasned) AS 'Utlån läsnedsättning'
FROM
((SELECT branch, 1 as barn, 0 as lasned

FROM statistics
LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)

WHERE type IN('issue','renew') 
AND itemtype IN ('BARNBOK','BARNKORT','BARN TIDSK','BOKCDBARN','BOKDAISYBA','BOKMP3BARN','BARN LJUD','BARNMP3','BARNTAL','MUSCDBARN')
AND statistics.branch IS NOT NULL 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL 

(SELECT branch, 0 as barn, 1 as lasned

FROM statistics
LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)

WHERE type IN('issue','renew') 
AND itemtype IN ('BARNTAL','BOKCD','BOKCDBARN','BOKDAISYBA','BOKMP3','BOKMP3BARN','DAISY','STORSTIL','TALBOKKASS')
AND statistics.branch IS NOT NULL 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

UNION ALL 

(SELECT branch, 1 as barn, 0 as lasned

FROM statistics
LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)

WHERE type IN('issue','renew') 
AND location IN ('Lattlast','Appelhyllan')
AND statistics.branch IS NOT NULL 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

)ds

LEFT JOIN branches ON (branches.branchcode=ds.branch)
GROUP BY branchname WITH ROLLUP
