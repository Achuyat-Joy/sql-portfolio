with countConsecutive as(
    select num, id - row_number() over(partition by num order by id) as sequence
    from Logs
)
select distinct num as ConsecutiveNums
from countConsecutive
group by num, sequence
having count(sequence)>=3
;
