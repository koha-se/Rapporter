SELECT COUNT(s.itemnumber) AS antal
FROM statistics s
LEFT JOIN action_logs a ON (s.itemnumber=a.object AND s.datetime=a.timestamp)
WHERE s.branch = <<Välj enhet|branches>>
AND s.type = 'issue'
AND a.user = <<Skriv borrower id för utlåningsmaskin>>
AND date(datetime) BETWEEN <<Startdatum|date>>
AND <<Slutdatum|date>>
