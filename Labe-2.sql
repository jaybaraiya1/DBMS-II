--Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);
delete Department
delete Designation
delete Person

-----------------------------------------------Part-A-------------------------------------------------
----1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures. 


---INSERT FOR DEPARTMENT
create or alter procedure pr_Department_insert
		@DepartmentID INT ,
		@DepartmentName VARCHAR(100)
		
AS
BEGIN
		INSERT INTO Department(
		DepartmentID,
		DepartmentName
		)
		VALUES(
		@DepartmentID,
		@DepartmentName
		)
END

pr_Department_insert 1,'Admin'
pr_Department_insert 2,'IT'
pr_Department_insert 3,'HR'
pr_Department_insert 4,'Account'
select * from Department

---INSERT FOR DESIGNATION
create or alter procedure pr_Designation_insert
	@DesignationID INT ,
	@DesignationName VARCHAR(100)
		
AS
BEGIN
		INSERT INTO Designation(
		DesignationID,
		DesignationName 
		)
		VALUES(
		@DesignationID,
		@DesignationName 
		)
END
pr_Designation_insert 11,'Jobber'
pr_Designation_insert 12,'Welder'
pr_Designation_insert 13,'Clerk'
pr_Designation_insert 14,'Manager'
pr_Designation_insert 15,'CEO'
select * from Designation


---INSERT INTO PERTION
create or alter procedure pr_Person_insert
	
	@FirstName VARCHAR(100) ,
	@LastName VARCHAR(100) ,
	@Salary DECIMAL(8, 2),
	@JoiningDate DATETIME ,
	@DepartmentID INT,
	@DesignationID INT
		
AS
BEGIN
		INSERT INTO Person(
		
		FirstName,
		LastName,
		Salary,
		JoiningDate,
		DepartmentID,
		DesignationID
		)
		VALUES(
		
			@FirstName  ,
			@LastName  ,
			@Salary ,
			@JoiningDate ,
			@DepartmentID ,
			@DesignationID 
		)
END
EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12;
EXEC PR_PERSON_INSERT 'HARDIK','HINSU',18000,'1990-09-25',2,11;
EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11;
EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13;
EXEC PR_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-07-23',2,15;
EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL;
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15;

---------------table 
Select * From  Department
Select * From  Designation
Select * From  Person
---UPDATE FOR DEPARTMENT

create or alter procedure pr_Department_update
		@DepartmentID INT ,
		@DepartmentName VARCHAR(100)
	
as
begin
		update  Department
		set DepartmentName=@DepartmentName 
		where DepartmentID=@DepartmentID
end
Exec pr_Department_update  1,'Admin'

---update for Desingnation
Create or Alter Procedure pr_Desingnation_Update
	@DesignationID INT ,
	@DesignationName VARCHAR(100)
		
AS
BEGIN
		update  Designation
		set DesignationName=@DesignationName 
		where DesignationID=@DesignationID
		
END
Exec pr_Desingnation_Update  11,'Jobber'
----Update For Person
	create or alter procedure pr_Person_update
	
	@FirstName VARCHAR(100) ,
	@LastName VARCHAR(100) ,
	@Salary DECIMAL(8, 2),
	@JoiningDate DATETIME ,
	@DepartmentID INT,
	@DesignationID INT
		
AS
BEGIN
		Update Person
		Set FirstName=@FirstName
		Where DesignationID=@DesignationID
			and DepartmentID=@DepartmentID 
END
Exec pr_Person_update  'Rahul','ANSHU',56000,'1990-01-01',1,12;

-----delete from Department

create or alter procedure pr_Department_delete
		@DepartmentID INT 
	
as
begin
		delete from   Department
		where DepartmentID=@DepartmentID
end
Exec pr_Department_delete  2

--delete from Desingnation
Create or Alter Procedure pr_Desingnation_delete
	@DesignationID INT 
		
AS
BEGIN
		delete from  Designation
		where DesignationID=@DesignationID
		
END
Exec pr_Desingnation_delete  11
-----Delete from persion
	create or alter procedure pr_Person_delete
	
	@FirstName VARCHAR(100)
		
AS
BEGIN
		delete from  Person
		where FirstName=@FirstName
		
end
Exec pr_Person_delete  'Rahul'

		
--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY 
	Create or Alter Procedure pr_SELECTBYPRIMARYKEY
	
	as
	begin
	select Person.PersonID,Department.DepartmentID,Designation.DesignationID
	from Department join Person
	on Department.DepartmentID=Person.DepartmentID
	join Designation
	on Designation.DesignationID=Person.DesignationID
	end
	exec pr_SELECTBYPRIMARYKEY
--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list) 
	Create or Alter Procedure pr_Tabl
	as
	begin
	select * 
	from  Person left join Department
	on  Person.DepartmentID=Department.DepartmentID
	left join Designation
	on Person.DesignationID=Designation.DesignationID
	end
	exec pr_Tabl




--4. Create a Procedure that shows details of the first 3 persons.
	Create or Alter Procedure pr_first3_persons
	
	as
	begin
	select top 3  *
	from Department join Person
	on Department.DepartmentID=Person.DepartmentID
	join Designation
	on Designation.DesignationID=Person.DesignationID
	end
	exec pr_first3_persons

------------------------------------Part – B-------------------------------- 
--5. Create a Procedure that takes the department name as input and returns a table with all workers  working in that department.
	Create or alter Procedure pr_workers_department
				
		@DepartmentName VARCHAR(100)
	as
	begin
	select Person.FirstName,Person.LastName,Department.DepartmentName
	from  Department join Person
	on Department.DepartmentID=Person.DepartmentID
	where DepartmentName=@DepartmentName
	end
	exec pr_workers_department 'Admin'
--6. Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name. 
		Create or Alter Procedure pr_depart_designation
			@DepartmentName VARCHAR(100),
			@DesignationName VARCHAR(100)
	as
	begin
	select Person.FirstName,Person.Salary,Person.JoiningDate,Department.DepartmentName
	from  Person left join Department
	on Person.DepartmentID=Department.DepartmentID
	left join Designation
	on Person.DesignationID= Designation.DesignationID
	where DepartmentName=@DepartmentName
	or DesignationName=@DesignationName
	end
	exec pr_depart_designation 'Admin','Jobber'
--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name. 
		Create or Alter Procedure pr_first
			@FirstName VARCHAR(100)
	as
	begin
	select Person.*,Department.DepartmentName,Designation.DesignationName
	from  Person left join Department
	on Person.DepartmentID=Department.DepartmentID
	left join Designation
	on Person.DesignationID= Designation.DesignationID
	where FirstName=@FirstName
	
	end
	exec pr_first 'Hardik'
--8. Create Procedure which displays department wise maximum, minimum & total salaries. 
	Create or Alter Procedure pr_displays_salaries
	as
	begin
	select Department.DepartmentName,max(Person.Salary),min(Person.Salary),sum(Person.Salary)
	from   Department join Person 
	on Department.DepartmentID=Person.DepartmentID
	GROUP by DepartmentName
	end
	exec pr_displays_salaries

--9. Create Procedure which displays designation wise average & total salaries.
	Create or Alter Procedure pr_designation_salaries
	as
	begin
	select Designation.DesignationName,avg(Person.Salary),sum(Person.Salary)
	from   Designation join Person 
	on Designation.DesignationID=Person.DesignationID
	GROUP by DesignationName
	end
	exec pr_designation_salaries


	------------------------------------Part – C ---------------------------------
--10. Create Procedure that Accepts Department Name and Returns Person Count. 
	Create or Alter Procedure pr_10
		@DepartmentName Varchar (100) 
	as
	begin
	Select   count(Person.PersonID)
	from   Department join Person
	on Department.DepartmentID=Person.DepartmentID
	where DepartmentName=@DepartmentName
	end
	exec pr_10 'Admin'
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details
	Create or Alter Procedure pr_11
		@Salary Decimal (8,2)
	as
	begin
	Select  Person.FirstName,Department.DepartmentName,Designation.DesignationName
	from    Person left join Department 
	on      Person.DepartmentID= Department.DepartmentID
	left join    Designation
	on		Person.DesignationID=Designation.DesignationID
	where Salary>@Salary
	end
	exec pr_11 18000
--12. Create a procedure to find the department(s) with the highest total salary among all departments.
	Create or Alter Procedure pr_12

	as
	begin
	Select max(Person.Salary)
	from   Department join Person    
	on      Person.DepartmentID= Department.DepartmentID
		
	end
	exec pr_12
--13. Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department. 
			Create or Alter Procedure pr_13
			@DesignationName Varchar (100) 
	as
	begin
	Select Person.FirstName,Department.DepartmentName,Designation.DesignationName,Person.JoiningDate
	from   Designation join Person    
	on      Person.DesignationID= Designation.DesignationID
	join Department
	on    Person.DepartmentID=Department.DepartmentID
	where Person.JoiningDate>20-02-2004 
		
	end
	exec pr_13 'Welder'
--14. Create a procedure to list the number of workers in each department who do not have a designation assigned. 
Create or alter procedure pr_14
as
begin
select count(Person.PersonID),Department.DepartmentName
	from Person left join Designation
	on Person.DesignationID=Designation.DesignationID
	left join Department
	on Person.DepartmentID=Department.DepartmentID
	where Designation.DesignationID is null
	group by DepartmentName
end
exec pr_14
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.
	Create or Alter Procedure pr_15

	as
	begin
	Select *
	from  Person  left join  Department 
	on      Person.DepartmentID= Department.DepartmentID
	where Person.Salary>12000
	end
	exec pr_15