SELECT YEAR(datetime) AS Year, 
       MONTH(datetime) AS Month, 
       DAY(datetime) AS Day, 
       HOUR(datetime) AS Hour, 
       count(*) 
FROM statistics  
WHERE datetime BETWEEN <<Mellan|date>> AND <<Och|date>> 
AND type = 'return'
GROUP BY Year, Month, Day, Hour
