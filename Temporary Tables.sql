/* Exercise #1:

Store the highest contract salary values of all male employees in a temporary table called male_max_salaries.*/

CREATE TEMPORARY TABLE male_max_salaries
SELECT s.emp_no, MAX(s.salary)
FROM salaries s
	JOIN employees e 
		ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no;



/* Exercise #2:

Write a query that, upon execution, allows you to check the result set contained in 
the male_max_salaries temporary table you created in the previous exercise.*/

SELECT * FROM male_max_salaries;