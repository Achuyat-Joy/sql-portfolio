Select e.employee_id, e.name, count(m.reports_to) as reports_count, round(avg(m.age)) as average_age
from Employees as e
right join employees as m
on e.employee_id=m.reports_to
where e.employee_id is not null
group by e.employee_id
order by e.employee_id
;