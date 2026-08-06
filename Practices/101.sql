create database if not exists aug1;
use aug1;

create table things(
  id int auto_increment, 
  name varchar(50),
  primary key(id)
)auto_increment=50;

insert into things (name) values
('Laptop'),('Mobile'),('Keyboard');

select * 
from things;

create table purpose(
  what varchar(100),
  p_id int,
  foreign key (p_id) references things(id)
  on update cascade
  on delete cascade
);

insert into purpose values ('work', 50), ('daily thing', 51),('for laptop', 52);

alter table purpose
change column what forr varchar(100);

with say as(
 select name, forr, row_number() over(order by name) as serial
 from things as t
 inner join purpose as p
 on t.id = p.p_id
) 
select * 
from say;