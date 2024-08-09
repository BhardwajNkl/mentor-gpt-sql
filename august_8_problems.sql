use GPT_practice_set_august8;

-- problem 1
select * from employees;
-- problem 2
select first_name, last_name from employees;

-- problem 3: find of IT depert
select * from employees where department='IT';
select * from employees where department like '_T'; -- just for demo, not perfect

-- emp having salary > 50000
select * from employees where salary > 50000;

select * from employees order by salary asc;
select * from employees order by salary desc;

select count(*) as emp_count from employees;
select count(employee_id) as emp_count from employees;

-- find by specific last name
select * from employees where last_name = 'Smith';

-- all emp in hr and order them by salary decreasing
select * from employees
	where department='HR'
	order by salary desc;


-- id,first name, lastname for salary more than 60000
select employee_id, first_name, last_name from employees where salary > 60000

-- first name starting with j
select * from employees where first_name like 'J%';

