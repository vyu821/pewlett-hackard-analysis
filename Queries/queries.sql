-- retirement eligibility
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- number of employees retiring
select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- create new table for retiring employees
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '195-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- joining departments and dept_manager tables
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

-- joining retirement_info and dept_emp tables
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_employees as de
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');

-- employee count by department number
select count(ce.emp_no), de.dept_no
from current_emp as ce
left join dept_employees as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- create new table for retiring employees with more info
select e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
inner join dept_employees as de
on (e.emp_no = de.emp_no)
where (e.birth_date between '195-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

-- list of managers per department
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
	on (dm.dept_no = d.dept_no)
inner join current_emp as ce
	on (dm.emp_no = ce.emp_no);

-- retirees with department column
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_emp as ce
inner join dept_employees as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no);

-- sales dept retirees
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
into sales_retirees
from retirement_info as ri
inner join dept_info as di
on (ri.emp_no = di.emp_no)
where di.dept_name in ('Sales');

-- sales and development dept retirees
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	di.dept_name
into sales_development_retirees
from retirement_info as ri
inner join dept_info as di
on (ri.emp_no = di.emp_no)
where di.dept_name in ('Sales', 'Development');