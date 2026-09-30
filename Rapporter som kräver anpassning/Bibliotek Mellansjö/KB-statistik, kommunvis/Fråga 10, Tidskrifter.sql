SELECT biblio.title AS Titel ,GROUP_CONCAT(DISTINCT branches.branchname SEPARATOR '<br>') AS 'Bibliotek',COUNT(serialid) AS 'Antal mottagna nummer',GROUP_CONCAT(DISTINCT 
subscriptionhistory.histstartdate SEPARATOR '<br>') AS Startdatum,
CASE 
WHEN subscriptionhistory.histstartdate > <<Datum från|date>> 
THEN
'Ny'
ELSE
''
END
AS 'Ny?'

FROM subscription
LEFT JOIN biblio ON (biblio.biblionumber=subscription.biblionumber)
LEFT JOIN serial on (serial.subscriptionid=subscription.subscriptionid)
LEFT JOIN library_groups ON (subscription.branchcode=library_groups.branchcode)
LEFT JOIN branches ON (branches.branchcode=subscription.branchcode)
LEFT JOIN subscription_frequencies ON (subscription_frequencies.id=subscription.periodicity)
LEFT JOIN subscriptionhistory ON (subscriptionhistory.subscriptionid=subscription.subscriptionid)

 

WHERE serial.status='2' 
AND subscription_frequencies.id NOT IN ('4')
AND serial.publisheddate BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>> 

GROUP BY subscription.biblionumber
HAVING COUNT(serialid)>1 

ORDER BY biblio.title
