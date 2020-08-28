-- Deliverable 1, # of retiring employees by title
select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into retirement_titles
from employees as e
inner join titles as ti
on (e.emp_no = ti.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- # of employees by most recent job title who are about to retire
select count(title),
	title
into retiring_titles
from unique_titles
group by title
order by count desc;

-- Deliverable 2, employees eligible for mentorship program
select distinct on(e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
into mentorship_eligibility
from employees as e
inner join dept_employees as de
on (e.emp_no = de.emp_no)
inner join titles as ti
on (e.emp_no = ti.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and (de.to_date = '9999-01-01')
order by e.emp_no;

