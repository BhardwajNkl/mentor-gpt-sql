-- use GPT_practice_set_august9

-- problem 1: employees with no department
select * from employees where department is null;

-- problem 2: departments with no emp
	-- approach: right join on department name.
			-- it ensures all departments will be available even if there is no employee match.
			-- now, get count for each department and show those having 0 employees
	
select department_id, department_name
	from employees right join departments on employees.department=departments.department_name
	group by department_id, department_name
	having count(employee_id)=0;

-- PROBLEM 2: better simple: SEEN SOLUTION
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_name = e.department
WHERE e.department IS NULL;


-- PROBLEM 3:  count employees by department, including those department that have no employees
	-- almost the same question. lets change the order of join this time and achive the result using left join.
select departments.department_name, count(employees.employee_id) as number_of_employees
	from departments left join employees on departments.department_name = employees.department
	group by departments.department_name;

-- PROBLEM 4: department with highest total salary: no need to join. still joining[in cases, you may just have id of department in employees]
--	LOOK FOR A BETTER SHORT SOLUTION
with t as (
		select department_name, sum(salary) as total_salary,  DENSE_RANK() over (order by sum(salary) desc) as department_salary_rank
			from departments left join employees on departments.department_name = employees.department
			group by department_name
		)

select * from t where department_salary_rank=1

-- SEEN SOLUTION: subquery
SELECT department_name, total_salary
FROM (
    SELECT 
        department_name, 
        SUM(salary) AS total_salary,  
        DENSE_RANK() OVER (ORDER BY SUM(salary) DESC) AS department_salary_rank
    FROM departments 
    LEFT JOIN employees ON departments.department_name = employees.department
    GROUP BY department_name
) AS ranked_departments
WHERE department_salary_rank = 1;



-- PROBLEM 5: list employees with salary above their department average
with mytable as (
	select department_name, avg(salary) as average_dept_salary
		from departments join employees on departments.department_name = employees.department
		group by department_name
)
select employees.*, mytable.average_dept_salary
	from employees join mytable on employees.department = mytable.department_name
	where employees.salary > mytable.average_dept_salary;
-- SEEN SOLUTION: CTE CONVERT INTO SUBQUERY

-- PROBLEM 6: list employees and their managers
select t1.*, t2.first_name+' '+t2.last_name as manager_name
	from employees as t1 left join employees as t2 on t1.manager_id = t2.employee_id;


-- PROBLEM 7: departments with 3 or more employees
select d.department_name, count(e.employee_id) as emp_count
	from departments as d left join employees as e on d.department_name = e.department
	group by d.department_name
	having count(e.employee_id)>=3;
-- SEEN SOLUTION: can use inner join instead of left join. because we dont need nulls when we want to find dep with 3 or more

-- PROBLEM 8: percent of employees in each department:
	-- CHECK. INCORRECT
select count(employee_id) as total_emp_count from employees;
select d.department_name, count(e.employee_id) as emp_count, (COUNT(e.employee_id) * 100.0 / (select COUNT(*) from employees)) as emp_percentage
	from departments as d left join employees as e on d.department_name=e.department
	group by d.department_name;


-- PROBLEM 9: LONGEST TENURE employees: tenure = present day - join day
	-- SEEN SOLUTION
select top 1 *, DATEDIFF(DAY, hire_date, GETDATE()) as tenure_days
	from employees
	order by tenure_days desc;


-- PROBLEM 10: rank employees by salary within each department
	-- SEEN SOLUTION
select *, DENSE_RANK() over (partition by department order by salary desc) as emp_rank
	from employees;

