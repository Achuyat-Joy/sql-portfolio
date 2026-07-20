SELECT c.NAME
FROM CITY AS c
LEFT JOIN COUNTRY as d
ON c.CountryCode = d.Code
WHERE d.Continent="Africa";
