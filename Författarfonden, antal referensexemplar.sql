SELECT 
  CASE
        WHEN EXTRACTVALUE(metadata,'//controlfield[@tag="001"][../controlfield[@tag="003"]=''SE-LIBR'' or ../controlfield[@tag="003"]=''LIBRIS'']')
        THEN 
        ExtractValue( biblio_metadata.metadata, '//controlfield[@tag="001"]')
        ELSE ''
        
        END 
        AS LibrisID,

  biblio.author  AS Författare, 
  biblio.title AS Titel, 
  ExtractValue(metadata, '//datafield[@tag="245"]/subfield[@code="n"]') AS Delbeteckning,
  ExtractValue(metadata, '//datafield[@tag="245"]/subfield[@code="p"]') AS Deltitel,
  editionstatement AS Upplaga, 
  publicationyear AS Utgivningsår, 
  CONCAT(biblioitems.isbn,'|') AS ISBN,
  issn AS ISSN, 
  itemtypes.description AS Exemplartyp,
  itemcallnumber AS 'Hyllsignum',
  COUNT(*) AS 'Antal referens-ex'
FROM 
  items
LEFT JOIN biblio ON (biblio.biblionumber=items.biblionumber)
LEFT JOIN biblioitems ON (biblioitems.biblionumber=items.biblionumber)
LEFT JOIN itemtypes ON (biblioitems.itemtype=itemtypes.itemtype)
LEFT JOIN biblio_metadata ON (biblio_metadata.biblionumber=biblio.biblionumber)

WHERE items.notforloan = 1 
GROUP BY items.biblionumber
ORDER BY Författare,Titel, Delbeteckning, Deltitel
