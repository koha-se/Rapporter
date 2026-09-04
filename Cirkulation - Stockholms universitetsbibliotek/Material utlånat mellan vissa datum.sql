SELECT
i.itemcallnumber AS 'Call number',
b.author,
b.title,
i.barcode,
ExtractValue( bm.metadata, '//datafield[@tag=035]/subfield[@code="a" and contains(text(), "LIBRIS")]') AS 'LibrisID', 
b.biblionumber,
i.itemnumber,
b.copyrightdate,
i.itype AS 'Item type',
i.issues AS 'Antal utlån',
i.onloan AS 'Utlånad',
i.itemlost AS 'Saknad', 
i.datelastborrowed AS 'Senast utlånad',
i.datelastseen AS 'Senast sedd',
i.homebranch,
i.location
FROM items i
LEFT JOIN biblio_metadata bm ON (i.biblionumber=bm.biblionumber)
LEFT JOIN biblio b ON (bm.biblionumber=b.biblionumber)
WHERE i.datelastborrowed BETWEEN <<Utlån sedan|date>> AND <<Utlån till|date>>
AND i.homebranch = <<Välj enhet|branches>>
AND i.location = <<Välj location|LOC>>
AND i.itemcallnumber LIKE <<Skriv callnumber ex A%>>
ORDER BY itemcallnumber
