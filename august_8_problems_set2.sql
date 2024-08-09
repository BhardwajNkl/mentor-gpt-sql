use GPT_practice_set_august8;

-- find firstname, lastname and departmentname of all employees: note there is a column for department in employees as well.
-- A. using cartesian product of tables
select first_name, last_name, department_name 
	from employees, departments 
	where department = department_name;

-- B. using join syntax
select first_name, last_name, department_name
	from employees join departments on employees.department = departments.department_name;


-- count employees per department: using only the employees table
select department, count(*) as employee_count
	from employees
	group by department;

-- average salary per department
select department, avg(salary) as department_avg_salary
	from employees
	group by department;

-- departments with more than one employee
select department as department_having_more_than_one_employee, count(*) as emp_count
	from employees
	group by department
	having count(*)>1;


-- employees in IT department having salary greater than 60k
select *
	from employees
	where department = 'IT' and salary > 60000;

-- max salary given
select max(salary) as max_salary from employees;

-- employees getting more salary than average salary
-- A
select * from employees where salary > (select avg(salary) from employees);

-- B


-- maximum salary employee(s)
-- A. using sub query
select *
	from employees
	where salary = (select max(salary) from employees);

-- B. assuming we need only one record(even if multiple max salary people exist)
select top 1 * from employees
	order by salary desc;
-- CHECK ELEGANT SOLUTIONS

-- departments with total salary above 10000
select department as department_with_total_salary_more_than_1lakh
	from employees
	group by department having sum(salary)>100000;

-- select employees that get salary between 50 to 70k
-- A
select * from employees
	where salary>=50000 and salary <= 70000;
-- B
select * from employees
	where salary between 50000 and 70000;



-- [SEEN SOLUTIONS]
-- 1. finding employees with max salary: we already know subqery solution. now use below methods
-- A. USING CTE
with max_salary_cte as ( select max(salary) as max_salary from employees)
select * from employees where salary = (select max_salary from max_salary_cte);

-- or also you can join/product the cte
with max_salary_cte as ( select max(salary) as max_salary from employees)
select * from employees, max_salary_cte  where salary=max_salary;


-- B. using dense_rank() window function:
	--IT SOLVES THE GENERAL PROBLEM OF FINDIN Kth HIGHEST SALARIED EMPLOYEES[however, that can be solved using CTE/subquery as well]
	-- first see the output of the below, then you will understant:
		-- both below functions assign ranks to records.
			-- dense means all same salaries will get same rank.
			-- but row number does not care abouth this, it provides a new rank/rownumber
	select *, DENSE_RANK() over (order by salary desc) as salary_rank from employees;
	select *, row_number() over (order by salary desc) as row_number from employees;

	-- now, using the dense rank, we can get all those who get the rank 1
	select employee_id, first_name, last_name, salary from (
			select *, DENSE_RANK() over (order by salary desc) as salary_rank from employees
	) as ranked_table where salary_rank = 1;


--- EXTRA : FINDING 2nD MAX SALARY EMPLOYEES
	-- we can use subqueries. but not easy for greater ranks such as 10th highest. use dense rank method.
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);


with ranked_table as (select *, DENSE_RANK() over (order by salary desc) as salary_rank from employees)
select employee_id, first_name, last_name, salary from ranked_table where salary_rank = 2;