SELECT 
CASE WHEN
branchname IS NULL
THEN
'=Summa'
ELSE
branchname 
END 
AS 'Låntagarens hembibliotek',
COUNT(CASE WHEN code = 'PERSNUMMER' AND LEFT( RIGHT(attribute, 2), 1) % 2 = 0 THEN 1 END) 'Aktiva kvinnor',
COUNT(CASE WHEN code = 'PERSNUMMER' AND LEFT( RIGHT(attribute, 2), 1) % 2 = 1 THEN 1 END) 'Aktiva män',
COUNT (CASE WHEN borrowers.categorycode IN ('BIBLIOTEK','ELEVTIDA','FORSKOLA','INSTT','KVALON','PERSONAL','PTID','SKOLA','SKOLBIBTID') THEN 1 END) 'Institutionslåntagare',
COUNT(CASE WHEN dateofbirth > DATE_SUB(CURDATE(), INTERVAL 18 YEAR) OR borrowers.categorycode IN ('ELEVTIDA','SKOLBIBTID','BARN') THEN 1 END) 'Under 18 år'

FROM borrowers 

LEFT JOIN borrower_attributes ON (borrowers.borrowernumber=borrower_attributes.borrowernumber) 
LEFT JOIN branches ON (borrowers.branchcode=branches.branchcode)

WHERE 
borrowers.borrowernumber IN

(SELECT borrowernumber 

FROM
statistics 

WHERE 
statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY AND statistics.branch LIKE <<Utlånande bibliotek|branches:all>> AND statistics.type='issue')

GROUP BY branchname WITH ROLLUP
