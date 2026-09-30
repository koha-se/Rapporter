SELECT biblio.copyrightdate As 'Utgivning',
       biblio.author AS Författare,
	   CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">', biblio.title, '</a>' ) AS Titel,
       items.itemcallnumber AS Signum,
       items.ccode AS Avd,
       itemtypes.description AS Extyp,
	   avplac.lib AS Plac,
       items.barcode AS Streckkod,
       CASE
       WHEN items.datelastborrowed IS NULL
       THEN 'Aldrig'
       ELSE items.datelastborrowed 
       END 
       AS 'Senast lånad',
       items.issues AS 'Antal lån',
       (SELECT GROUP_CONCAT( DISTINCT ItemInnerDets.ItemDetails ORDER BY ItemInnerDets.ItemDetails ASC SEPARATOR '</br>')
            FROM
           (SELECT itemsInner.biblionumber, branches.branchname, itemsInner.barcode,
                   CONCAT(branches.branchname,', ',itemsInner.issues,' Utlån, senaste ',
                   CASE 
                   WHEN itemsInner.datelastborrowed IS NULL
                   THEN '---'
                   ELSE
                   itemsInner.datelastborrowed
                   END
                   ) AS ItemDetails 
            FROM items itemsInner 
			LEFT JOIN branches ON (itemsInner.homebranch=branches.branchcode)
            WHERE itemsInner.homebranch IN ('8BXQ','8BXZ','8BYA','8BYB','8BYC','8BYI','8BYL','8BYM','8BYQ','8BYR','8BYS','GULL','HJO','HOVA','KABO','MARI','SKSB','TIDA','TIKF','TORE') AND itemsInner.itemlost='0'
			) ItemInnerDets
         WHERE ItemInnerDets.biblionumber = items.biblionumber AND  ItemInnerDets.barcode <> items.barcode  ORDER BY ItemInnerDets.ItemDetails  
         )  AS 'Finns även vid',
        (SELECT GROUP_CONCAT( DISTINCT HistoryInnerDets.HistoryDetails ORDER BY HistoryInnerDets.HistoryDetails ASC SEPARATOR '</br>')
            FROM
           (SELECT items.biblionumber, branches.branchname, HistoryInner.itemnumber,
                   CONCAT(branches.branchname) AS HistoryDetails 
            FROM old_issues HistoryInner 
			LEFT JOIN branches ON (HistoryInner.branchcode=branches.branchcode)
			LEFT JOIN items ON (items.itemnumber=HistoryInner.itemnumber)
            WHERE HistoryInner.branchcode IN ('8BXQ','8BXZ','8BYA','8BYB','8BYC','8BYI','8BYL','8BYM','8BYQ','8BYR','8BYS','GULL','HJO','HOVA','KABO','MARI','SKSB','TIDA','TIKF','TORE')
			) HistoryInnerDets
         WHERE HistoryInnerDets.biblionumber = items.biblionumber  ORDER BY HistoryInnerDets.HistoryDetails  
         )  AS 'Titeln tidigare lånad vid (lån i Koha, eller gamla sparade lån)',

       CASE 
        WHEN ExtractValue(bm.metadata, '//controlfield[@tag="003"]') = 'SE-LIBR' 
		
        THEN 
		CONCAT(
		
		CONCAT(       
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Umdp','%'),'Depåbiblioteket </br></br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Gull','%'),'Gullspång </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Hjo','%'),'Hjo </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Hova','%'),'Hova </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Kabo','%'),'Karlsborg</br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Mari','%'),'Mariestad </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Sksb','%'),'Skövde </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Tikf','%'),'Tibro </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Tida','%'),'Tidaholm </br>',''),
IF (ExtractValue (bm.metadata,'//datafield[@tag="852"]/subfield[@code="b"]') LIKE CONCAT('%','Tore','%'),'Töreboda </br>','')
)
,

		CONCAT('<a href=\"https://libris.kb.se/bib/', ExtractValue( bm.metadata, '//controlfield[@tag="001"]'), '\" target="_blank">', 'Libris webbsök', '</a></br>' )
,

CASE 
WHEN 
ExtractValue (bm.metadata,'//datafield[@tag="887"]/subfield[@code="a"]') =''
THEN 
'Marcfält 887 saknas'
ELSE
CONCAT('<a href=\"https://libris.kb.se/katalogisering/', SUBSTRING(ExtractValue (bm.metadata,'//datafield[@tag="887"][1]/subfield[@code="a"]'),9,15), '\" target="_blank">', 'LibrisXL', '</a>' )
END


		)
			
			
        ELSE 'Ej Libris-post'
       END
       AS 'Bestånd i Libris'
	   
FROM items 
LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber) 
LEFT JOIN authorised_values avplac ON (items.location=avplac.authorised_value)            
LEFT JOIN itemtypes ON (items.itype=itemtypes.itemtype)
INNER JOIN biblio_metadata bm ON bm.biblionumber = biblio.biblionumber AND bm.format = 'marcxml'

 WHERE items.homebranch = <<Bibliotek|branches>> 
 AND items.location LIKE <<Placering|LOC:all>> 
 AND items.ccode LIKE <<Avdelning (barn/vuxen/magasin)|ccode:all>>
 AND items.itype LIKE <<Exemplartyp|itemtypes:all>>
 AND items.itemcallnumber LIKE <<Hyllsignum. 
 Trunkera med %. 
 För att få med alla hyllsignum, skriv bara %>>
 AND (YEAR(NOW())-YEAR(items.datelastborrowed) > <<Antal år sedan senaste utlån>>  OR items.datelastborrowed IS NULL)
 AND (YEAR(NOW())-YEAR(items.dateaccessioned) > <<Antal år sedan senaste utlån>>)
 AND items.itemnumber NOT IN (SELECT issues.itemnumber FROM issues) 
 AND items.itemlost='0'

ORDER BY ccode,avplac.lib,itemcallnumber, author, title
