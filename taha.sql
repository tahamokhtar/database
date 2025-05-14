create database taha;
CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number INT NOT NULL,
    department_id INT NOT NULL,
    job_title VARCHAR(100),
    salary NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL UNIQUE,
    start_date DATE,
    end_date DATE,
    budget NUMERIC(15,2)
);
CREATE TABLE EmployeeProjects (
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);
CREATE ROLE hr_user LOGIN PASSWORD 'hr_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON Departments TO hr_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON Employees TO hr_user;
CREATE ROLE pm_user LOGIN PASSWORD 'pm_password';
GRANT SELECT ON Employees TO pm_user;
GRANT SELECT, INSERT, UPDATE ON Projects TO pm_user;
GRANT SELECT, INSERT ON EmployeeProjects TO pm_user;
INSERT INTO Departments (department_name) VALUES
('Human Resources'),
('Engineering'),
('Sales'),
('Customer Service'),
('Marketing'),
('Finance'),
('Legal'),
('IT Support'),
('Research and Development'),
('Operations');

INSERT INTO Employees (first_name, last_name, birth_date, hire_date, email, phone_number, department_id, job_title, salary) VALUES
('Ahmed', 'Ali', '1985-02-15', '2010-06-01', 'ahmed.ali@telecom.com', '01234567890', 2, 'Network Engineer', 6500.00),
('Sara', 'Hassan', '1990-08-21', '2015-03-15', 'sara.hassan@telecom.com', '01234567891', 3, 'Sales Executive', 4800.00),
('Mohamed', 'Youssef', '1982-12-05', '2008-11-30', 'mohamed.youssef@telecom.com', '01234567892', 1, 'HR Manager', 8500.00),
('Laila', 'Khaled', '1993-07-17', '2018-01-20', 'laila.khaled@telecom.com', '01234567893', 4, 'Customer Support Specialist', 4500.00),
('Omar', 'Fahmy', '1978-05-10', '2005-02-28', 'omar.fahmy@telecom.com', '01234567894', 2, 'Senior Engineer', 9000.00),
('Nadia', 'Samir', '1987-03-22', '2012-09-10', 'nadia.samir@telecom.com', '01234567895', 5, 'Marketing Specialist', 5400.00),
('Tamer', 'Ibrahim', '1991-11-11', '2016-05-18', 'tamer.ibrahim@telecom.com', '01234567896', 6, 'Finance Analyst', 6000.00),
('Dina', 'Mahmoud', '1989-09-30', '2013-07-07', 'dina.mahmoud@telecom.com', '01234567897', 7, 'Legal Advisor', 7200.00),
('Yousef', 'Naguib', '1995-06-13', '2019-11-25', 'yousef.naguib@telecom.com', '01234567898', 8, 'IT Support Technician', 4000.00),
('Mona', 'Sherif', '1984-04-19', '2009-04-15', 'mona.sherif@telecom.com', '01234567899', 9, 'Research Scientist', 8000.00);

INSERT INTO Projects (project_name, start_date, end_date, budget) VALUES
('5G Network Expansion', '2022-01-01', '2023-12-31', 2000000),
('Customer Portal Development', '2021-06-15', '2022-12-31', 750000),
('Marketing Campaign Q1', '2023-01-01', '2023-03-31', 100000),
('Billing System Upgrade', '2022-03-01', '2023-01-30', 500000),
('Employee Training Program', '2023-04-01', '2023-05-31', 25000),
('Network Security Enhancement', '2023-02-01', '2023-09-30', 150000),
('New Product Launch', '2022-11-15', '2023-04-30', 300000),
('Customer Satisfaction Survey', '2023-01-10', '2023-02-28', 15000),
('Data Center Migration', '2022-08-01', '2023-06-30', 1000000),
('Mobile App Revamp', '2022-10-01', '2023-05-31', 400000);

INSERT INTO EmployeeProjects (employee_id, project_id, assigned_date) VALUES
(1, 1, '2022-01-10'),
(5, 1, '2022-02-15'),
(2, 3, '2023-01-05'),
(3, 5, '2023-04-02'),
(4, 8, '2023-01-15'),
(6, 3, '2023-01-15'),
(7, 4, '2022-04-20'),
(8, 6, '2023-02-10'),
(9, 9, '2022-08-10'),
(10, 10, '2022-10-05'),
(1, 6, '2023-02-20'),
(5, 9, '2022-08-20');

-- Step 7: Sample SQL Queries

-- 1. Search for employees whose job title contains 'Engineer' (text search)
SELECT employee_id, first_name, last_name, job_title
FROM Employees
WHERE job_title ILIKE '%Engineer%'
ORDER BY last_name ASC;

-- 2. Aggregate function: Find average salary per department
SELECT d.department_name, AVG(e.salary) AS average_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

-- 3. Retrieve projects with budget greater than 500,000 ordered by budget descending
SELECT project_name, budget
FROM Projects
WHERE budget > 500000
ORDER BY budget DESC;

-- 4. Count number of employees assigned to each project
SELECT p.project_name, COUNT(ep.employee_id) AS num_employees
FROM Projects p
LEFT JOIN EmployeeProjects ep ON p.project_id = ep.project_id
GROUP BY p.project_name
ORDER BY num_employees DESC;

-- 5. List employees hired after 2015, sorted by hire date ascending
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date > '2015-01-01'
ORDER BY hire_date ASC;
