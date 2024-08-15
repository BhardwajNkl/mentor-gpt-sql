-- 1. rank employees by salary within each department
use GPT_practice_set_august14;

select *, DENSE_RANK() over(partition by department order by salary desc) as salary_rank
	from employees;


-- 2. commulative salary by department 


-- 3. employee with highest salary in every department: can be written using CTE as well.

select employee_id, first_name, last_name, department, salary, manager_id, hire_date
	from
	(
		select *, DENSE_RANK() over(partition by department order by salary desc) as salary_rank
			from employees
	) as highest_salary_emp_table

	where salary_rank=1;

-- 4. top 2 highest paid employees in every department: using rownumber because assuming we need top 2 only even if there are multiple employees within top 2.

with myview as (
	select *, ROW_NUMBER() over (partition by department order by salary desc) as row_number
		from employees
) select *
	from myview
	where row_number<=2;


-- 5. difference between employee salary and highest salary in department
with myview as (
	select *, max(salary) over (partition by department) as dept_max_salary
		from employees
	)
select employee_id, first_name, last_name, salary, department, dept_max_salary-salary as salary_difference
		from myview;

-- 6. average salary over last 2 hires in each department
	-- solution: first get last 2 hires in each department. then get average on that table.
with table_showing_latest_hire_number as (
	select *, ROW_NUMBER() over(partition by department order by hire_date desc) as latest_hire_number
		from employees
	)

	-- THE BELOW QUERY WILL SHOW THE LAST 2 HIRES WITHIN EACH DEPARTMENT. BUT WE ARE NOT INTERESTED IN SHOWING THAT, WE CAN COMPUTE AND SHOW THE DEPARTMENT AVERAGE.
-- select *
--	from table_showing_latest_hire_number
--	where latest_hire_number <= 2;

select department, avg(salary) as department_avg_salary_for_last_2_hires
	from table_showing_latest_hire_number
	where latest_hire_number<= 2
	group by department;

