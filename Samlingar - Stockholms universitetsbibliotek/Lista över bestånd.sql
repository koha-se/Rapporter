SELECT
i.itemcallnumber AS 'Call number',
i.barcode,
b.author AS 'Författare',
b.title AS 'Titel',
b.unititle AS 'Undertitel',
i.enumchron as 'Serial Enumeration',
ExtractValue(bm.metadata,'//datafield[@tag="245"]/subfield[@code="n"]') AS 'Del',
CONCAT('https://libris.kb.se/bib/', 
       SUBSTRING(ExtractValue( bm.metadata, '//datafield[@tag=035]/subfield[@code="a" and contains(text(), "LIBRIS")]'), 9)
       ) AS 'LibrisID länk',
CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', b.biblionumber, '\">', b.biblionumber, '</a>' ) AS 'Koha länk',
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
WHERE i.homebranch = <<Välj enhet|branches>> 
AND i.location = <<Välj location|LOC>>
AND i.itemcallnumber LIKE <<Skriv callnumber ex A%>>
ORDER BY i.itemcallnumber
