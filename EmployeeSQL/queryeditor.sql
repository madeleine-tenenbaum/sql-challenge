-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/LzfPgU
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(5)   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar(255)   NOT NULL,
    "last_name" varchar(255)   NOT NULL,
    "sex" varchar(255)   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Departments" (
    "dept_no" varchar(6)   NOT NULL,
    "dept_name" varchar(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

DROP TABLE "Salaries";

CREATE TABLE "Salaries" (
    "salary_id" serial  NOT NULL,
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "salary_id"
     )
);

CREATE TABLE "Employee_Departments" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(6)   NOT NULL,
    CONSTRAINT "pk_Employee_Departments" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" varchar(5)   NOT NULL,
    "title" varchar(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Department_Managers" (
    "dept_no" varchar(6)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_Department_Managers" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employee_Departments" ADD CONSTRAINT "fk_Employee_Departments_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employee_Departments" ADD CONSTRAINT "fk_Employee_Departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--Titles
--Employees
--Salaries
--Departments
--Employee_Departments
--Department_Managers


--select * from "Titles";
--select * from "Employees";
--select * from "Salaries";
--select * from "Departments";
--select * from "Employee_Departments";
--select * from "Department_Managers";


--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
INNER JOIN "Salaries" ON
"Employees".emp_no="Salaries".emp_no;


--List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date like '%1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT  "Department_Managers".dept_no, "Departments".dept_name, "Department_Managers".emp_no, "Employees".last_name, "Employees".first_name
FROM "Department_Managers"
   INNER JOIN "Departments" ON "Department_Managers".dept_no= "Departments".dept_no 
   INNER JOIN "Employees" ON "Employees".emp_no="Department_Managers".emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT  "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employee_Departments"
    INNER JOIN "Employees" ON "Employee_Departments".emp_no="Employees".emp_no
	INNER JOIN "Departments" ON "Employee_Departments".dept_no= "Departments".dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM "Employees"
WHERE last_name like 'B%' and first_name='Hercules';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT  "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
	INNER JOIN "Employee_Departments" ON ("Employees".emp_no="Employee_Departments".emp_no)
	INNER JOIN "Departments" ON ("Employee_Departments".dept_no= "Departments".dept_no)
WHERE "Departments".dept_name='Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT  "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
	INNER JOIN "Employee_Departments" ON ("Employees".emp_no="Employee_Departments".emp_no)
	INNER JOIN "Departments" ON ("Employee_Departments".dept_no= "Departments".dept_no)
WHERE "Departments".dept_name='Sales'
union
SELECT  "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
	INNER JOIN "Employee_Departments" ON ("Employees".emp_no="Employee_Departments".emp_no)
	INNER JOIN "Departments" ON ("Employee_Departments".dept_no= "Departments".dept_no)
WHERE "Departments".dept_name='Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.*/ 

SELECT last_name, COUNT(last_name) AS names_count
FROM "Employees"
GROUP BY last_name 
ORDER BY names_count, last_name DESC;


	  
