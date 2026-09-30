SELECT 
CASE 
WHEN branchname IS NULL
THEN 
'=Summa'
ELSE 
branchname
END
AS Bibliotek, 
SUM(utltryckt) AS 'Utlån tryckt bok',SUM(omltryckt) AS 'Omlån tryckt bok',
SUM(utllarom) AS 'Utlån läromedel',SUM(omllarom) AS 'Omlån läromedel',
SUM(utlljudbok) AS 'Utlån ljudböcker',SUM(omlljudbok) AS 'Omlån ljudböcker', 
SUM(utltalbok) AS 'Utlån talböcker daisy',SUM(omltalbok) AS 'Omlån talböcker daisy', 
SUM(utltskr) AS 'Utlån tidskrifter',SUM(omltskr) AS 'Omlån tidskrifter', 
SUM(utlmusik) AS 'Utlån musik',SUM(omlmusik) AS 'Omlån musik',
SUM(utlfilm) AS 'Utlån film',SUM(omlfilm) AS 'Omlån film',
SUM(utlkartor) AS 'Utlån kartor',SUM(omlkartor) AS 'Omlån kartor',
SUM(utlnoter) AS 'Utlån noter',SUM(omlnoter) AS 'Omlån noter',
SUM(utlinterakt) AS 'Utlån Interaktiva medier',SUM(omlinterakt) AS 'Omlån Interaktiva medier',
SUM(utlovr) AS 'Utlån övrigt',SUM(omlovr) AS 'Omlån övrigt'

FROM
( 
(SELECT branch, 
1 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BARNBOK','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','BOKPASE','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')  
  AND frameworkcode !='BOKP'
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
materials as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BARNBOK','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','BOKPASE','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')  
  AND frameworkcode ='BOKP'
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
1 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('LAROMDL','LAROMTERM')  
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
1 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
1 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BARNTAL','DAISY','TALBOKKASS')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
1 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BARN TIDSK','TIDSKRIFT')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
1 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('MUSIKCD','MUSCDBARN')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
1 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BLURAY','FILM','VHS')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
1 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('KARTOR')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
1 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('MUSIK','MUSIKBARN')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
1 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('CDROM','TV-SPEL')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
1 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'issue' 
  AND itemtype IN ('BLANDAT','FOREMAL','FOREMAL3MD','KONTROLL','SALLSKAPSS','SUFRPLATTA','VECKOLAN','X')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL
  
  (SELECT branch, 
0 as utltryckt, 1 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BARNBOK','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','BOKPASE','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')  
  AND frameworkcode !='BOKP'
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, materials as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BARNBOK','BOK','BOKCD','BOKCDBARN','BOKDAISY','BOKDAISYBA','BOKMP3','BOKMP3BARN','BOKPASE','LANGLAN','PAKET','POCKET','REFERENS','SPRAKKURS','STORSTIL')  
  AND frameworkcode ='BOKP'
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>) 
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 1 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('LAROMDL','LAROMTERM')  
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 1 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BARN LJUD','BARNMP3','KASSETT','LJUDBOK','MP3')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 1 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BARNTAL','DAISY','TALBOKKASS')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 1 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BARN TIDSK','TIDSKRIFT')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 1 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('MUSIKCD','MUSCDBARN')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 1 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BLURAY','FILM','VHS')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 1 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('KARTOR')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 1 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('MUSIK','MUSIKBARN')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 1 as omlinterakt,
0 as utlovr, 0 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('CDROM','TV-SPEL')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  UNION ALL 
  
  (SELECT branch, 
0 as utltryckt, 0 as omltryckt, 
0 as utllarom, 0 as omllarom, 
0 as utlljudbok, 0 as omlljudbok, 
0 as utltalbok, 0 as omltalbok, 
0 as utltskr, 0 as omltskr, 
0 as utlmusik, 0 as omlmusik,
0 as utlfilm, 0 as omlfilm,
0 as utlkartor, 0 as omlkartor,
0 as utlnoter, 0 as omlnoter,
0 as utlinterakt, 0 as omlinterakt,
0 as utlovr, 1 as omlovr

  FROM statistics 
  LEFT JOIN items ON (statistics.itemnumber=items.itemnumber)
  LEFT JOIN biblio ON (items.biblionumber=biblio.biblionumber)
  LEFT JOIN library_groups ON (statistics.branch=library_groups.branchcode)
  
  WHERE type = 'renew' 
  AND itemtype IN ('BLANDAT','FOREMAL','FOREMAL3MD','KONTROLL','SALLSKAPSS','SUFRPLATTA','VECKOLAN','X')
  AND statistics.branch IS NOT NULL 
  AND statistics.itemtype IS NOT NULL 
  AND statistics.datetime BETWEEN <<Datum från|date>>-INTERVAL 1 DAY AND <<Datum till |date>>+INTERVAL 1 DAY 
  AND library_groups.parent_id=<<Kommun|librarygroupsparentid>>)
  
  
  ) ds
  
  LEFT JOIN branches ON (ds.branch=branches.branchcode)
  GROUP BY branchname WITH ROLLUP
