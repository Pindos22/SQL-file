--1. Create database
USE master
IF EXISTS (SELECT * FROM sys.databases WHERE Name='EmployeeDB')
DROP DATABASE EmployeeDB
GO

CREATE DATABASE EmployeeDB
GO

USE EmployeeDB
GO

--2. Create tables and constraints
CREATE TABLE Department (
    DepartId INT PRIMARY KEY,
    DepartName VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Employee (
    EmpCode CHAR(6) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Birthday SMALLDATETIME NOT NULL,
    Gender BIT DEFAULT 1,
    Address VARCHAR(100),
    DepartID INT,
    Salary MONEY,
    FOREIGN KEY (DepartID) REFERENCES Department(DepartID)
)
GO

--3. Insert into above tables at least 3 records per table [3 marks].
INSERT INTO Department (DepartId, DepartName, Description) VALUES
(1, 'Human Resources', 'Handles recruitment, training, and employee welfare.'),
(2, 'Finance', 'Manages financial planning, analysis, and reporting.'),
(3, 'IT', 'Responsible for technology infrastructure and support.'),
(4, 'Marketing', 'Focuses on market research, advertising, and promotions.'),
(5, 'Sales', 'Handles sales strategies, client relations, and revenue generation.');
GO

INSERT INTO Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary) VALUES
('E001', 'John', 'Doe', '1985-05-15', 1, '123 Elm St, Springfield', 1, 55000.00),
('E002', 'Jane', 'Smith', '1990-07-22', 0, '456 Oak St, Springfield', 2, 60000.00),
('E003', 'Mike', 'Johnson', '1982-10-30', 1, '789 Pine St, Springfield', 3, 70000.00),
('E004', 'Emily', 'Williams', '1988-12-01', 0, '135 Maple St, Springfield', 4, 65000.00),
('E005', 'Chris', 'Brown', '1995-03-12', 1, '246 Cedar St, Springfield', 5, 50000.00);
GO

--4. Increase the salary for all employees by 10% [1 mark].
UPDATE Employee
SET Salary = Salary * 1.10;
GO

--5. Using ALTER TABLE statement to add constraint on Employee table to ensure that
--salary always greater than 0 [2 marks].
ALTER TABLE Employee
ADD CONSTRAINT chk_salary_positive
CHECK (Salary > 0);
GO