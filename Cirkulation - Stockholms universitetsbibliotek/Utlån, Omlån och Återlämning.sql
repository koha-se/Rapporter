SELECT
      MONTH(datetime) AS Månad, 
      SUM( IF(type = 'issue', 1, 0 )) AS Utlån,
      SUM( IF(type = 'renew', 1, 0 )) AS Omlån,
      SUM( IF(type = 'return', 1, 0 )) AS Återlämning,
      COUNT(statistics.type) AS 'Total Transactions'
FROM  statistics
WHERE branch = <<Enhet|branches>>
AND YEAR(datetime) = <<Välj ÅR ÅÅÅÅ>> 
AND  MONTH(datetime) = <<Välj månad, tex 05 för maj>>
GROUP BY MONTH(datetime)
