SELECT
i.itemcallnumber,
b.author,
b.title,
i.barcode,
ExtractValue (bm.metadata,'//datafield[@tag="035"]/subfield[@code="a" and contains(text(), "LIBRIS")]') AS 'LibrisID',
ExtractValue(bm.metadata, '//datafield[@tag="082"]/subfield[@code="a"]') AS 'Dewey',
ExtractValue(bm.metadata, '//datafield[@tag="084"]/subfield[@code="a"]') AS 'SAB',
b.copyrightdate,
i.itype AS 'Item type',
i.onloan AS 'Utlånad',
i.itemlost,
i.homebranch,
i.location,
b.biblionumber,
i.itemnumber
FROM items i
LEFT JOIN biblio_metadata bm ON (i.biblionumber=bm.biblionumber)
LEFT JOIN biblio b ON (bm.biblionumber=b.biblionumber)
WHERE i.homebranch = <<Välj enhet|branches>> 
AND i.location = <<Välj location|LOC>>
AND ExtractValue(bm.metadata, '//datafield[@tag="082"]/subfield[@code="a"]') LIKE <<Skriv början på Deweykod ex 839%>>
ORDER BY i.itemcallnumber
