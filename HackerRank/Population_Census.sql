SELECT sum(a.Population)
FROM CITY AS a
INNER JOIN COUNTRY AS b
on a.CountryCode = b.Code
WHERE b.CONTINENT = "Asia";

