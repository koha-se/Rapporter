SELECT COUNT(borrowernumber) AS 'Nya låntagare'
FROM borrowers
WHERE YEAR(dateenrolled) = <<Välj år ÅÅÅÅ>> 
