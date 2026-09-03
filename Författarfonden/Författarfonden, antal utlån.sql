SELECT 
    CASE
        WHEN COALESCE(
            EXTRACTVALUE(bm.metadata,'//controlfield[@tag="001"][../controlfield[@tag="003"]="SE-LIBR" or ../controlfield[@tag="003"]="LIBRIS"]'),
            EXTRACTVALUE(dbm.metadata,'//controlfield[@tag="001"][../controlfield[@tag="003"]="SE-LIBR" or ../controlfield[@tag="003"]="LIBRIS"]')
        ) != ''
        THEN COALESCE(
            ExtractValue(bm.metadata, '//controlfield[@tag="001"]'),
            ExtractValue(dbm.metadata, '//controlfield[@tag="001"]')
        )
        ELSE ''
    END AS LibrisID,
    COALESCE(b.author, db.author) AS Författare,
    COALESCE(b.title, db.title) AS Titel,
    COALESCE(
        ExtractValue(bm.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
        ExtractValue(dbm.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
    ) AS Delbeteckning,
    COALESCE(
        ExtractValue(bm.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
        ExtractValue(dbm.metadata, '//datafield[@tag="245"]/subfield[@code="p"]')
    ) AS Deltitel,
    COALESCE(b.copyrightdate, db.copyrightdate) AS Utgivningsår,
    COALESCE(bi.editionstatement, dbi.editionstatement) AS Upplaga,
    CONCAT(COALESCE(bi.isbn, dbi.isbn),'|') AS ISBN,
    COALESCE(i.itemcallnumber, di.itemcallnumber) AS Hyllsignum,
    it.description AS Exemplartyp,
    count(s.datetime) AS 'Antal utlån'
FROM statistics s
LEFT JOIN items i ON (i.itemnumber = s.itemnumber)
LEFT JOIN deleteditems di ON (di.itemnumber = s.itemnumber AND i.itemnumber IS NULL)
LEFT JOIN biblio b ON (b.biblionumber = COALESCE(i.biblionumber, di.biblionumber))
LEFT JOIN deletedbiblio db ON (db.biblionumber = di.biblionumber AND b.biblionumber IS NULL)
LEFT JOIN biblioitems bi ON (bi.biblionumber = b.biblionumber)
LEFT JOIN deletedbiblioitems dbi ON (dbi.biblionumber = db.biblionumber AND bi.biblionumber IS NULL)
LEFT JOIN itemtypes it ON (it.itemtype = COALESCE(bi.itemtype, dbi.itemtype))
LEFT JOIN biblio_metadata bm ON (bm.biblionumber = b.biblionumber)
LEFT JOIN deletedbiblio_metadata dbm ON (dbm.biblionumber = db.biblionumber AND bm.biblionumber IS NULL)
WHERE s.datetime BETWEEN (<<Utlånat från och med (åååå-mm-dd)|date>>-INTERVAL 1 DAY) 
    AND (<<Utlånat till och med (åååå-mm-dd)|date>>+INTERVAL 1 DAY)
    AND s.itemnumber IS NOT NULL 
    AND s.type IN ('issue','renew')
    AND COALESCE(i.itype, di.itype) != 'foremal'

GROUP BY COALESCE(b.biblionumber, db.biblionumber)
ORDER BY Författare, Titel, Delbeteckning, Deltitel
