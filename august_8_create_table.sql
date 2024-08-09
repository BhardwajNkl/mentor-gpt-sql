use GPT_practice_set_august8;

-- creare the employees table:
	-- decimal(9,2) means 9 digits maximum allowed including digits before and after.
	-- and 2 digits after the decimal point

create table employees(
	employee_id int, first_name varchar(20) not null, last_name varchar(20),
	department varchar(20), salary decimal(9,2),
	primary key(employee_id), 
	);

create table departments(
	department_id int, department_name varchar(20),
	primary key(department_id)
	);

-- insert some rows in employees
insert into employees(employee_id, first_name, last_name, department, salary) 
values
	(1,'John','Doe','HR',50000),
	(2,'Jane','Smith','IT',60000),
	(3,'Emily','Davis','IT',70000),
	(4,'Michael','Brown','Marketing',45000),
	(5,'Sara','Wilson','HR',52000);

-- insert rows in departments: note currently these tables are no connected
insert into departments(department_id, department_name)
values
(1, 'HR'),
(2,'Marketing'),
(3, 'IT');