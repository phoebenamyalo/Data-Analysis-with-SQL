# Write a query that upon execution, assigns a row number to all managers we have information 
# for in the "employees" database (regardless of their department).

SELECT emp_no,
	   dept_no,
	   ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM dept_manager;

# Write a query that upon execution, assigns a sequential number for each employee number
# registered in the "employees" table. Partition the data by the employee's first name and order it 
# by their last name in ascending order (for each partition).

SELECT emp_no,
       first_name,
       last_name,
       ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num
FROM employees;


# Obtain a result set containing the salary values each manager has signed a contract for.
SELECT dm.emp_no,
		salary,
		ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
		ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   
FROM dept_manager dm
	JOIN salaries s 
    ON dm.emp_no = s.emp_no;
    
