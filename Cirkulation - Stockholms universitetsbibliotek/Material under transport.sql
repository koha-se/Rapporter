SELECT bt.frombranch, bt.tobranch, i.homebranch, i.itemcallnumber, i.barcode, b.title, b.author, bt.datesent
FROM branchtransfers bt
LEFT JOIN items i ON (bt.itemnumber = i.itemnumber)
LEFT JOIN biblio b ON (i.biblionumber = b.biblionumber)
WHERE bt.datesent <= DATE_SUB(CURDATE(),interval 2 week)
AND bt.datearrived IS NULL
AND i.itemlost NOT LIKE '4'
AND i.homebranch = <<HEMENHET|branches>>
GROUP BY bt.frombranch, bt.tobranch, i.homebranch, i.itemcallnumber, i.barcode, b.title, b.author, bt.datesent
