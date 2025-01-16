-- Create Department Table 
CREATE TABLE Department ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE 
); -- Create Designation Table 
CREATE TABLE Designation ( 
DesignationID INT PRIMARY KEY, 
DesignationName VARCHAR(100) NOT NULL UNIQUE 
); -- Create Person Table 
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
select * from Department
select * from Department
select * from Person
--1. Write a function to print "hello world". 
create or alter function fn_Hellow()
returns varchar(50)
as
begin
		return 'Hello World!'
end
select dbo.fn_Hellow()
--2. Write a function which returns addition of two numbers. 
create or alter function fn_sum
   (@number1 int,
    @number2  int
    )
	returns int
as
begin
		return @number1+@number2
end
select dbo.fn_sum (2,5)

--3. Write a function to check whether the given number is ODD or EVEN. 
create or alter function fn_oddeven (@number int )
	returns varchar(50)
as
begin		
       if (@number%2=0)
	     return 'EVEN'
	   else
	     return 'ODD'

	return 'invelid'
end
select dbo.fn_oddeven(23)

--4. Write a function which returns a table with details of a person whose first name starts with B. 
create or alter function fn_name_b_1()
returns table
as
	return(select distinct FirstName from Person where FirstName like 'B%' )

select FirstName from dbo.fn_name_b_1()
--5. Write a function which returns a table with unique first names from the person table. 
create or alter function fn_Lab_45()
returns table
as		
	return(select distinct FirstName from Person )
select * from dbo.fn_Lab_45()
--6. Write a function to print number from 1 to N. (Using while loop) 
create or alter function fn_print_numbeer(@n int)
returns varchar(50)
as
begin		
	declare @ans varchar(500),@i int
	set @i=2
	set @ans =1
	while(@i<=@n)
	begin
		set @ans=@ans+cast(@i as varchar(500))
		set @i=@i+1
	end
	return @ansend
select dbo.fn_print_numbeer(5)
--7. Write a function to find the factorial of a given integer. 
create or alter function fn_print_factorial(@n int)
returns int
as
begin		
	declare @ans varchar(500),@i int
	set @i=1
	set @ans =1
	while(@i<=@n)
	begin
		set @ans=@ans*@i
		set @i=@i+1
	end
	return @ans
end
select dbo.fn_print_factorial(5)
--ex. Write a function which returns a table with details of a person whose first name given by user 
create or alter function fn_ex_name( @FirstName)
returns table
as
begin
	return(select  FirstName from Person where left(FirstName,1)=@FirstName)
end
select FirstName from dbo.fn_ex_name(A)
select * from Person
