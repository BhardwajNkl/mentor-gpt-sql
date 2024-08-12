use GPT_practice_set_august9;

-- creare the employees table:
	-- decimal(9,2) means 9 digits maximum allowed including digits before and after.
	-- and 2 digits after the decimal point

create table employees(
	employee_id int, first_name varchar(20) not null, last_name varchar(20),
	department varchar(20), salary decimal(9,2), manager_id int, hire_date date,
	primary key(employee_id),
	foreign key(manager_id) references employees(employee_id)
	);

create table departments(
	department_id int, department_name varchar(20),
	primary key(department_id)
	);

-- insert some rows in employees
insert into employees(employee_id, first_name, last_name, department, salary, manager_id, hire_date) 
values
	(1,'John','Doe','HR',50000, null, '2015-01-15'),
	(2,'Jane','Smith','IT',60000, 1, '2016-03-20'),
	(3,'Emily','Davis','IT',70000, 1, '2017-05-23'),
	(4,'Michael','Brown','Marketing',45000,2, '2018-07-11'),
	(5,'Sara','Wilson','HR',52000, null, '2019-09-25'),
	(6,'David','Clark',null,40000, null, '2020-11-30'),
	(7,'Chris','Taylor','IT',68000, 2, '2021-12-15');

-- insert rows in departments: note currently these tables are no connected
insert into departments(department_id, department_name)
values
(1, 'HR'),
(2,'Marketing'),
(3, 'IT'),
(4, 'RESEARCH');
