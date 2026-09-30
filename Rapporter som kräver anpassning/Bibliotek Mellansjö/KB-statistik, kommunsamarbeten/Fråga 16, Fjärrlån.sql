SELECT 
CASE
WHEN branchname IS NULL
THEN '=Summa'
ELSE
 branchname
 END AS Bibliotek,
 SUM(utlan) AS 'Utlån',
 SUM(inlan) AS 'Inlån'
 
 FROM
 (
 (SELECT branch,1 as utlan, 0 as inlan
 FROM statistics

LEFT JOIN borrowers ON (statistics.borrowernumber=borrowers.borrowernumber)
LEFT JOIN branches ON (statistics.branch=branches.branchcode)
LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)

WHERE type = 'issue' 
AND borrowers.categorycode IN ('BIBLIOTEK') 
AND borrowers.cardnumber NOT IN ('8bxq','8bxz','8bya','8byb','8byc','8byi','8byl','8bym','8byo','8byq','8byr','8bys','Gull','Hjo','Hova','Kabo','Kbro','Mari','Skgy','Sksb','Tida','Tikf','Tore','Vagy')
AND statistics.branch IS NOT NULL 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>
 )
 
 UNION ALL
 
 (SELECT branch,0 as utlan, 1 as inlan
 FROM statistics

LEFT JOIN borrowers ON (statistics.borrowernumber=borrowers.borrowernumber)
LEFT JOIN branches ON (statistics.branch=branches.branchcode)
LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)

WHERE type = 'issue' 
AND itemtype IN ('FJARRLAN')
AND statistics.branch IS NOT NULL 
AND statistics.itemtype IS NOT NULL 
AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> )
) ds
LEFT JOIn branches On (branches.branchcode=ds.branch)

GROUP BY branchname WITH ROLLUP
