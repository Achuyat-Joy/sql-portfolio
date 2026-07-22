SELECT concat(name,'(',left(Occupation,1),')') 
FROM OCCUPATIONS
ORDER BY Name;

SELECT concat('There are a total of ',count(name),' ',lower(Occupation),'s.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY count(name), occupation;
