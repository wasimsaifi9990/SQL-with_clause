-- create database with_clause;
use with_clause;

create table emp
( emp_ID int
, emp_NAME varchar(50)
, SALARY int);

insert into emp values(101, 'Mohan', 40000);
insert into emp values(102, 'James', 50000);
insert into emp values(103, 'Robin', 60000);
insert into emp values(104, 'Carol', 70000);
insert into emp values(105, 'Alice', 80000);
insert into emp values(106, 'Jimmy', 90000);

select * from emp;

create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

-- Find total sales per each store
select store_name,sum(quantity*cost) as total_sales
from sales 
group by store_name

with average_salary (avg_salary) as (
	select avg(salary) from emp 
    )
select * from emp e,average_salary av
where e.salary > av.avg_salary

select * from sales;
-- Find stores who's sales where better than the average sales accross all stores

select * from (
	select avg(total_sale) as avg_total from (
		select store_id,sum(cost) as total_sale from sales
		group by store_id ) as total_sale ) AS Avg_total_sales
join (
		select store_id,sum(cost) total_s from sales
		group by store_id ) as total
on total.total_s > Avg_total_sales.avg_total

-- Using with clause 
with total_sales(store_id, total_sales) as(
		select store_id,sum(cost) from sales
		group by store_id),
Avg_total_sales(avg_total) as (
		select avg(total_sales)  from total_sales)	
select * from total_sales 
join avg_total_sales 
on total_sales.total_sales > Avg_total_sales.avg_total

