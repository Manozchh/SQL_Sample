WITH CTE AS(
   SELECT [EmployeeID], [JobTitle], [Salary],
       RN = ROW_NUMBER()OVER(PARTITION BY EmployeeID ORDER BY EmployeeID)
   FROM dbo.EmployeeSalary
)
DELETE FROM CTE WHERE RN > 1

SELECT * 
FROM Employeedemograph

SELECT LastName from Employeedemograph

SELECT top(5) * 
from Employeedemograph


/* 
Select statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/


SELECT DISTINCT(Gender)
FROM Employeedemograph

SELECT Count(FirstName) AS NameCount
FROM Employeedemograph

SELECT MAX(Salary) AS HighestSalary
FROM EmployeeSalary

SELECT MIN(Salary) AS LowestSalary
FROM EmployeeSalary


/* When we are in master database the we need to specify the database with .dbo notation 
*/
SELECT * 
FROM SQL_Tutorial.dbo.EmployeeSalary

SELECT *
FROM Employeedemograph
WHERE Age <= 32 AND Gender = 'Male'

SELECT * 
FROM Employeedemograph
WHERE FirstName = 'kevin'

 we want all the info other than kevin

SELECT * 
FROM Employeedemograph
WHERE FirstName <> 'kevin'

/*
 where statement
 =, <>, <, >, And, or, like, Null, Not Null, In

*/

-- we want info of all female and info of male whose age is less than 32
SELECT * 
FROM Employeedemograph
WHERE Age < 32 or Gender = 'Female'


-- info of employee whose name starts with a
SELECT * 
FROM Employeedemograph
WHERE FirstName like 'a%'

-- info of people whose name contains letter 's' anywhere in their lastname
SELECT * 
FROM Employeedemograph
WHERE lastName like '%s%'

SELECT * 
FROM Employeedemograph
WHERE FirstName is null

--'IN' in where statement is like multiple '=' 

SELECT * 
FROM Employeedemograph
WHERE FirstName in ('alex', 'kevin', 'toby')

/*
 Group by , Order by
*/
SELECT Gender, COUNT(Gender)
FROM Employeedemograph
GROUP BY Gender

SELECT Gender, Age, COUNT(Gender)
FROM Employeedemograph
GROUP BY Gender, Age

SELECT * 
FROM Employeedemograph
ORDER BY Age, FirstName


/*
 Inner Joins, Full/Left/Right Outer Joins
*/

SELECT * 
FROM Employeedemograph inner join EmployeeSalary on Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID

SELECT Employeedemograph.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM Employeedemograph inner join EmployeeSalary on Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID

-- If we want to see all the data from both table then we use 'Full Outer Join'

SELECT Employeedemograph.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQL_tutorial.dbo.Employeedemograph Full Outer join  SQL_tutorial.dbo.EmployeeSalary 
ON Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID

SELECT Employeedemograph.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQL_tutorial.dbo.Employeedemograph LEFT Outer join  SQL_tutorial.dbo.EmployeeSalary 
ON Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID

/* SQL CASE Expression example */

SELECT FirstName, LastName, Age, 
CASE
	WHEN age = 38 THEN 'stanley'
	WHEN Age >= 35 THEN 'old'
	WHEN age > 29 THEN 'adult'
	ELSE 'young'
END AS agetext
FROM Employeedemograph 
WHERE age is not null
ORDER BY Age;

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle  = 'Salesman' THEN salary + (salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + ( Salary * .5)
	WHEN JobTitle = 'HR' THEN Salary +( Salary * .4)
	ELSE Salary + (Salary * .3)
END AS salary_afterraise
FROM Employeedemograph join
EmployeeSalary on 
Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID


/* HAVING CLAUSE */

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeSalary 
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1
ORDER BY JobTitle


SELECT JobTitle, Avg(salary)
FROM EmployeeSalary 
WHERE JobTitle is not null
GROUP BY JobTitle
HAVING AVG(salary) > 45000
ORDER BY JobTitle

/* Updating and deleting table */
 
SELECT * 
FROM Employeedemograph
ORDER BY EmployeeID

UPDATE Employeedemograph
SET EmployeeID = 1014 
WHERE FirstName ='Holly' and LastName ='Flax'

UPDATE Employeedemograph
SET age = 27 , Gender = 'Female'
WHERE FirstName ='Holly' and LastName ='Flax'

UPDATE Employeedemograph
SET Age = 30 
WHERE EmployeeID = 1013

/* partition by clause */

SELECT FirstName, LastName, Gender, Salary, COUNT(gender)
OVER ( PARTITION BY gender) AS Total_gender
FROM Employeedemograph join EmployeeSalary
on Employeedemograph.EmployeeID = EmployeeSalary.EmployeeID


SELECT gender, COUNT(gender) FROM Employeedemograph 
group by Gender

/* CTEs 
Common table expression. A temporary named result set that you can reference.
*/

WITH cte_employee AS
( SLECT FirstName, LastName, Gender, Salary, 
 COUNT(gender) OVER (PARTITION BY gender) AS total_gender,
 AVG(salary) over (PARTITION BY gender) AS avg_gender_salary
 from Employeedemograph join employeesalary on 
 employeedemograph.employeeid = employeesalary.employeeid
)
SELECT * FROM cte_employee

-- STRING FUNCTION

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

SELECT * FROM EmployeeErrors
-- Using Trim, Ltrim, Rtrim

SELECT employeeid FROM EmployeeErrors

SELECT employeeid, TRIM(employeeid) AS idtrim  -- removes extra whitespace from both left and righthand side
FROM EmployeeErrors


SELECT employeeid, LTRIM(employeeid) AS idtrim -- removes whitespace of leftside
from EmployeeErrors

SELECT employeeid, RTRIM(employeeid) AS idtrim
FROM EmployeeErrors

SELECT TRIM(employeeid) AS employeeid FROM EmployeeErrors

---- Using replace

SELECT lastname, REPLACE(lastname, '- fired', '') as lastnamefixed -- replace(col_name, 'valueyouwanttoreplace', 'newvalue') as new_name
FROM EmployeeErrors

-- Using substring

SELECT firstname, SUBSTRING(firstname, 1,3) --substring(col_name, startingindex of_string,totalnumberofcharacter_from the starting index)
FROM EmployeeErrors

SELECT firstname, SUBSTRING(firstname, 3,3)
FROM EmployeeErrors

SELECT * FROM EmployeeErrors
SELECT * FROM employeedemograph 

SELECT  err.FirstName 
FROM EmployeeErrors err join Employeedemograph dem
on err.FirstName = dem.FirstName


SELECT  SUBSTRING(err.FirstName, 1, 3), SUBSTRING(dem.FirstName,1, 3)
FROM EmployeeErrors err join Employeedemograph dem
on SUBSTRING(err.FirstName, 1,3) = SUBSTRING(dem.FirstName,1,3)

-- we use substring mostly for fuzzy matching on
--LastName
--Gender
--age
--dob

--USING UPPER AND LOWER 

SELECT firstname, LOWER(firstname)
FROM EmployeeErrors

SELECT firstname, UPPER(firstname)
FROM EmployeeErrors

SELECT firstname, CONCAT(UPPER(left(firstname,1)),LOWER(right(firstname, LEN(firstname)-1)))
FROM  EmployeeErrors

/*

STORED PROCEDURE

*/

CREATE PROCEDURE test
AS 
SELECT * FROM Employeedemograph

CREATE PROCEDURE Temp_Employee
AS
CREATE table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT into #temp_employee
SELECT JobTitle, COUNT(jobtitle), AVG(age), AVG(salary)
FROM Employeedemograph dem 
join EmployeeSalary sal 
  on dem.EmployeeID=sal.EmployeeID
GROUP BY JobTitle

SELECT * FROM #temp_employee

EXEC TempEmployee

/*

SUBQUERY

*/

--Subquery in Select
SELECT employeeid, salary, (SELECT AVG(salary) FROM EmployeeSalary) AS AllAvgsalary
FROM EmployeeSalary

-- How to do it with Partition By
SELECT employeeid, salary, AVG(salary) OVER() AS AllAvgsalary
FROM EmployeeSalary

-- Subquery in From

SELECT a.EmployeeID, AllAvgsalary
From ( SELECT employeeid, salary, AVG(salary) OVER() AS AllAvgsalary
        FROM EmployeeSalary) a


-- Subquery in Where

SELECT employeeid, jobtitle, salary
FROM EmployeeSalary
WHERE EmployeeID in (
          SELECT EmployeeID
		  FROM Employeedemograph
		  WHERE age > 30)