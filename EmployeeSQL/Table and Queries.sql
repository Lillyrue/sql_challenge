CREATE TABLE Titles (
    title_id VARCHAR(20) NOT NULL,
    title VARCHAR(50) NOT NULL,
    PRIMARY KEY (title_id)
);

SELECT * FROM Titles;

CREATE TABLE Employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(20) NOT NULL,
    birth_date VARCHAR(15) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(10) NOT NULL,
    hire_date VARCHAR(15) NOT NULL,
    PRIMARY KEY (emp_no)
);

SELECT * FROM Employees;

CREATE TABLE Salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL
);

SELECT * FROM Salaries;

CREATE TABLE Departments (
    dept_no VARCHAR(20) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_no)
);

SELECT * FROM Departments;

CREATE TABLE Department_Managers (
    dept_no VARCHAR(30) NOT NULL,
    emp_no INT NOT NULL,
	Primary key (dept_no, emp_no)
);

SELECT * FROM Department_Managers;

CREATE TABLE Department_Employees (
    emp_no INT NOT NULL,
    dept_no VARCHAR(30) NOT NULL,
	Primary key (emp_no, dept_no)
);

SELECT * FROM Department_Employees;

ALTER TABLE Salaries
ADD Primary key (emp_no);

ALTER TABLE Employees
ADD Foreign Key (emp_title_id)
REFERENCES Titles(title_id);

ALTER TABLE Salaries
ADD Foreign Key (emp_no)
REFERENCES Employees(emp_no);

ALTER TABLE Department_Managers
ADD Foreign Key (dept_no)
REFERENCES Departments(dept_no);

ALTER TABLE Department_Managers
ADD Foreign Key (emp_no)
REFERENCES Employees(emp_no);

ALTER TABLE Department_Employees
ADD Foreign Key (emp_no)
REFERENCES Employees(emp_no);

ALTER TABLE Department_Employees
ADD Foreign Key (dept_no)
REFERENCES Departments(dept_no);

--List the employee number, last name, first name, sex, and salary of each employee
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Employees
INNER JOIN Salaries
ON Employees.emp_no = Salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date LIKE '%1986';

--List the manager of each department along with their department number, department name, employee number, last name, and first name 
SELECT Departments.dept_no, Departments.dept_name, Employees.emp_no, Employees.last_name, Employees.first_name
FROM Departments
INNER JOIN Department_Managers
ON Departments.dept_no = Department_Managers.dept_no
INNER JOIN Employees
ON Department_Managers.emp_no = Employees.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT Department_Employees.dept_no, Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Department_Employees
INNER JOIN Employees
ON Department_Employees.emp_no = Employees.emp_no
INNER JOIN Departments
ON Department_Employees.dept_no = Departments.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name LIKE 'Hercules' and last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name 
SELECT Departments.dept_name, Department_Employees.emp_no, Employees.last_name, Employees.first_name
FROM Departments
JOIN Department_Employees
ON Departments.dept_no = Department_Employees.dept_no
JOIN Employees
ON Department_Employees.emp_no = Employees.emp_no
WHERE dept_name LIKE 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT Departments.dept_name, Department_Employees.emp_no, Employees.last_name, Employees.first_name
FROM Departments
JOIN Department_Employees
ON Departments.dept_no = Department_Employees.dept_no
JOIN Employees
ON Department_Employees.emp_no = Employees.emp_no
WHERE dept_name IN ('Sales','Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*) AS frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;