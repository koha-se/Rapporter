SELECT 
CASE 
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='swe' THEN '1 Svenska'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='' THEN '1 Svenska'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='fin' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='9mk' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='smi' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='smj' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='sme' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='sms' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='sma' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='rom' THEN '2 Minoritets'
WHEN substring( ExtractValue(metadata,'//controlfield[@tag="008"]'), 36,3 )='yid' THEN '2 Minoritets'
ELSE '3 Utländska'
END
AS 'Språk',
COUNT(*) AS 'Antal titlar'
    
FROM biblio_metadata 

WHERE
biblio_metadata.biblionumber
IN
(SELECT items.biblionumber

FROM items
LEFT JOIN library_groups ON (items.homebranch=library_groups.branchcode)

WHERE items.homebranch IS NOT NULL 
AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 

GROUP BY 1
