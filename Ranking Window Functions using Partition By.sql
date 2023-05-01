/* Write a query that provides row numbers for all workers from the "employees" table, partitioning the data by 
their first names and ordering each partition by their employee number in ascending order.*/

SELECT emp_no,
		first_name,
		ROW_NUMBER() OVER w AS row_num
FROM employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);


# Find out the lowest salary value each employee has ever signed a contract for. Once again, to obtain the desired output, use a subquery containing a window function. 
# This time, however, introduce the window specification in the field list of the given subquery.

SELECT a.emp_no,
       MIN(salary) AS min_salary FROM (
SELECT emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num
FROM salaries) a
GROUP BY emp_no;


/*Find out the second-lowest salary value each employee has ever signed a contract for. 
  To obtain the desired output, use a subquery containing a window function, as well as a window specification
  introduced with the help of the WINDOW keyword. Moreover, obtain the desired result set without using 
  a GROUP BY clause in the outer query.*/

SELECT a.emp_no,
		a.salary as min_salary FROM (
SELECT emp_no, salary, ROW_NUMBER() OVER w AS row_num
FROM salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=2;

/* Write a query that ranks the salary values in descending order of all contracts signed by employees 
 numbered between 10500 and 10600 inclusive. Let equal salary values for one and the same employee 
 bear the same rank. Also, allow gaps in the ranks obtained for their subsequent rows.
 Use a join on the “employees” and “salaries” tables to obtain the desired result.*/

SELECT	e.emp_no,
		RANK() OVER w as employee_salary_ranking,
		s.salary
FROM employees e
	JOIN salaries s 
		ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);



/* Write a query that ranks the salary values in descending order of the following contracts from 
 the "employees" database: 
           - contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
           - contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
 In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.
 Use a join on the “employees” and “salaries” tables to obtain the desired result.*/

SELECT	e.emp_no,
		DENSE_RANK() OVER w as employee_salary_ranking,
		s.salary,
		e.hire_date,
		s.from_date,
		(YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM employees e
	JOIN salaries s 
		ON s.emp_no = e.emp_no
AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);