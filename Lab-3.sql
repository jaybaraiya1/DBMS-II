CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
); 
CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); -- Create Projects Table 
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); 
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

Select  * from Departments
Select  * from Employee
Select  * from Projects
---------Part – A -----------------
--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based on this you must give EmployeeID, DOB, Gender & Hiredate.  
Create or Alter Procedure Pr_01
		@FirstName Varchar(100)=null ,
		@LastName Varchar(100)=null
as
begin
		Select FirstName,EmployeeID,DoB,HireDate,Gender  from Employee
		Where FirstName=@FirstName or
		      LastName=@LastName
end
exec Pr_01 'Jane','Smith'
-- if use (=null) in @FirstName Varchar(100)=null 
--then if do not inser the valuse in exec then it all so run lick
--Create or Alter Procedure Pr_01
--		@FirstName Varchar(100)=null ,
--		@LastName Varchar(100)=null
--as
--begin
--		Select FirstName,EmployeeID,DoB,HireDate,Gender  from Employee
--		Where FirstName=@FirstName or
--		      LastName=@LastName
--end
--exec Pr_01 'Jane'
----exec Pr_01  @LastName='Smith'
--2. Create a Procedure that will accept Department Name and based on that gives employees list who belongs to that department. 
Create or Alter Procedure Pr_02
		@DepartmentName Varchar(100) 
as
begin
		Select *  from Departments join Employee
		on Departments.DepartmentID=Employee.DepartmentID
		Where DepartmentName=@DepartmentName
end
exec Pr_02 'Finance'

--3.  Create a Procedure that accepts Project Name & Department Name and based on that you must give all the project related details.  
Create or Alter Procedure Pr_03
		@ProjectName Varchar(100),
		@DepartmentName Varchar(100) 
as
begin
		Select *  from Projects left join Departments 
		on Projects.DepartmentID=Departments.DepartmentID
		Where ProjectName=@ProjectName and
			  DepartmentName=@DepartmentName
end
exec Pr_03 'Project Alpha ','IT'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those employee list comes in output.  
--Create or Alter Procedure Pr_04
--		@Salary INT 
--as
--begin
		
--		Select *  from Employee 
--		--Where Salary between  and   @Salary=70000
--		Where Salary between @Salary-50000  and   @Salary+50000
--end

Create or Alter Procedure Pr_04
	@first int,
	@second int
as
begin
	Select * from Employee
	where Salary between @first and
	@second 

exec Pr_04  1000,70000
--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date
Create or Alter Procedure Pr_05
	@HireDate Date
as
begin
	Select * from Employee
	where HireDate=@HireDate
end
exec Pr_05 '2012-07-18'
--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served.  
create or alter procedure pr_6
	@Gender Varchar(50)
as
begin
	select * from Employee
	where left(Gender,1)=@Gender
end
exec pr_6 M
--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come.  
create or alter procedure pr_7
	@FirstName Varchar(100)=null,
	@DepartmentName Varchar(100)=null
as
begin
	select * from Employee join Departments
	on Employee.DepartmentID=Departments.DepartmentID
	where (Employee.FirstName=@FirstName) or (Departments.DepartmentName=@DepartmentName)
end
exec pr_7 jane

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will get all the departments with all data.  
create or alter procedure pr_8
@location varchar(100)
as
begin
	select * from Departments
	where Location like '%' + @location + '%'
end
exec pr_8 m

--Part – C 
--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project related data.  

create or alter procedure pr_date
@sdate datetime,
@ldate datetime
as
begin
	select * from Projects
	where StartDate=@sdate and EndDate=@ldate
end

pr_date '2023-03-15','2024-03-14 '

--10. Create a procedure in which user will enter project name & location and based on that you must provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. 
create or alter proc PR_Projects_AllDetails
	@ProjectName varchar(100),
	@Location varchar(100)
as
begin
	SELECT p.ProjectName,p.StartDate,p.EndDate,d.DepartmentName,CONCAT(e.FirstName, ' ', e.LastName) AS ManagerName,d.Location
    FROM Projects p JOIN Departments d 
	ON p.DepartmentID = d.DepartmentID
    JOIN Employee e 
	ON d.ManagerID = e.EmployeeID
    WHERE 
        p.ProjectName = @ProjectName AND
        d.Location = @Location; 
end

	PR_Projects_AllDetails 'Project Beta', 'San Franc