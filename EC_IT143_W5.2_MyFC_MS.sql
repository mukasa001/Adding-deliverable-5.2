/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_MyFC_MS
PURPOSE: Answer four analytical questions about the MyFC community data set

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     03/10/2026   MS            1. Built this script for EC IT143 – Final Project 5.2

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions about the MyFC data set.
Three questions were written by me; one was written by classmate Eunice.
All answers use the answer-focused style (clear question → clear SQL answer).
Tables used: tblPlayerDim, tblPlayerFact, tblTeamDim
******************************************************************************************************************/

USE EC_IT143_DA;
GO

/*--------------------------------------------------------------------------------
Q1 (Author: Mukasa Sadick – Head Coach stakeholder)
How many players are currently assigned to each team, and what is the average 
month-to-date salary for players on each team?  
I need the team code, player count, and average mtd_salary.
--------------------------------------------------------------------------------*/
-- A1
SELECT 
    t.t_code                        AS TeamCode,
    COUNT(DISTINCT p.pl_id)         AS PlayerCount,
    AVG(f.mtd_salary)               AS Avg_MTD_Salary
FROM MyFC.dbo.tblPlayerDim AS p
INNER JOIN MyFC.dbo.tblPlayerFact AS f
    ON p.pl_id = f.pl_id
INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON p.t_id = t.t_id
GROUP BY t.t_code
ORDER BY t.t_code;
GO

/*--------------------------------------------------------------------------------
Q2 (Author: Mukasa Sadick – Team Manager stakeholder)
Which players have the highest month-to-date salary, and which team do they 
belong to?  I need player name, team code, and mtd_salary ordered highest to lowest.
--------------------------------------------------------------------------------*/
-- A2
SELECT 
    p.pl_name                       AS PlayerName,
    t.t_code                        AS TeamCode,
    f.mtd_salary                    AS MTD_Salary
FROM MyFC.dbo.tblPlayerDim AS p
INNER JOIN MyFC.dbo.tblPlayerFact AS f
    ON p.pl_id = f.pl_id
INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON p.t_id = t.t_id
ORDER BY f.mtd_salary DESC;
GO

/*--------------------------------------------------------------------------------
Q3 (Author: Mukasa Sadick – Salary Analyst stakeholder)
What is the total month-to-date salary cost for each team?  
I need the team code and the sum of mtd_salary.
--------------------------------------------------------------------------------*/
-- A3
SELECT 
    t.t_code                        AS TeamCode,
    SUM(f.mtd_salary)               AS Total_MTD_Salary
FROM MyFC.dbo.tblPlayerDim AS p
INNER JOIN MyFC.dbo.tblPlayerFact AS f
    ON p.pl_id = f.pl_id
INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON p.t_id = t.t_id
GROUP BY t.t_code
ORDER BY Total_MTD_Salary DESC;
GO

/*--------------------------------------------------------------------------------
Q4 (Author: Eunice – classmate question)
What is the total month-to-date salary (mtd_salary) for each team, 
and which team has the highest total player salary?
--------------------------------------------------------------------------------*/
-- A4
SELECT 
    t.t_code                        AS TeamCode,
    SUM(f.mtd_salary)               AS Total_MTD_Salary
FROM MyFC.dbo.tblPlayerDim AS p
INNER JOIN MyFC.dbo.tblPlayerFact AS f
    ON p.pl_id = f.pl_id
INNER JOIN MyFC.dbo.tblTeamDim AS t
    ON p.t_id = t.t_id
GROUP BY t.t_code
ORDER BY Total_MTD_Salary DESC;   -- highest total appears first
GO