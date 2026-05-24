-- Topic: SELECT

SELECT w.name, w.population, w.area
FROM World as w
WHERE w.area>=3000000 OR w.population>=25000000;        