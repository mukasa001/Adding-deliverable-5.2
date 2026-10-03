/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_Simpsons_MS
PURPOSE: Answer four analytical questions about the Simpsons community data set

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     03/10/2026   MS            1. Built this script for EC IT143 – Final Project 5.2

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions about the Simpsons / Springfield data set.
All four questions were written by me (no classmate questions were submitted 
against this particular data set).
Table used: Family_Data
******************************************************************************************************************/

USE EC_IT143_DA;
GO

/*--------------------------------------------------------------------------------
Q1 (Author: Mukasa Sadick – Plant Manager stakeholder)
How many family members work in each department?  
I need the department name and the count of members.
--------------------------------------------------------------------------------*/
-- A1
SELECT 
    Department                      AS DepartmentName,
    COUNT(*)                        AS MemberCount
FROM SimpsonsDB.dbo.Family_Data
GROUP BY Department
ORDER BY MemberCount DESC;
GO

/*--------------------------------------------------------------------------------
Q2 (Author: Mukasa Sadick – HR Supervisor stakeholder)
Which employees have the job title of Nuclear Safety Inspector, 
and who is their manager?  I need full name, job title, and manager.
--------------------------------------------------------------------------------*/
-- A2
SELECT 
    CONCAT(First_Name, ' ', Last_Name) AS FullName,
    Job_Title                       AS JobTitle,
    Manager                         AS Manager
FROM SimpsonsDB.dbo.Family_Data
WHERE Job_Title = 'Nuclear Safety Inspector'
ORDER BY FullName;
GO

/*--------------------------------------------------------------------------------
Q3 (Author: Mukasa Sadick – Department Head stakeholder)
What is the distribution of employees by status (Active, Hardly Working, etc.) 
within each department?  I need department, status, and count of members.
--------------------------------------------------------------------------------*/
-- A3
SELECT 
    Department                      AS DepartmentName,
    Status                          AS EmployeeStatus,
    COUNT(*)                        AS MemberCount
FROM SimpsonsDB.dbo.Family_Data
GROUP BY Department, Status
ORDER BY Department, MemberCount DESC;
GO

/*--------------------------------------------------------------------------------
Q4 (Author: Mukasa Sadick – Operational Manager stakeholder)
Which departments have the highest number of employees, and what are the 
most common job titles in those departments?
--------------------------------------------------------------------------------*/
-- A4  (two-part answer)

-- Part A: Departments ranked by headcount
SELECT 
    Department                      AS DepartmentName,
    COUNT(*)                        AS EmployeeCount
FROM SimpsonsDB.dbo.Family_Data
GROUP BY Department
ORDER BY EmployeeCount DESC;
GO

-- Part B: Most common job titles inside the largest departments
SELECT 
    Department                      AS DepartmentName,
    Job_Title                       AS JobTitle,
    COUNT(*)                        AS TitleCount
FROM SimpsonsDB.dbo.Family_Data
WHERE Department IN (
    SELECT TOP 3 Department
    FROM SimpsonsDB.dbo.Family_Data
    GROUP BY Department
    ORDER BY COUNT(*) DESC
)
GROUP BY Department, Job_Title
ORDER BY DepartmentName, TitleCount DESC;
GO