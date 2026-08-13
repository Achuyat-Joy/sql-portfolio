with measure as (
    select person_name, sum(weight) over(order by turn) as Total
    from Queue
)
select person_name
from measure
where Total<=1000 
order by Total desc
limit 1;