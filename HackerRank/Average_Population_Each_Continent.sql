SELECT C.Continent, floor(avg(T.Population))
FROM COUNTRY AS C
INNER JOIN CITY AS T
ON T.CountryCode = C.Code
GROUP BY C.Continent;
