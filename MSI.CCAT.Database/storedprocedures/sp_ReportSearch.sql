USE [CCATDBDev]
GO

/****** Object:  StoredProcedure [dbo].[sp_ReportSearch]    Script Date: 2/18/2015 1:32:28 PM ******/
DROP PROCEDURE [dbo].[sp_ReportSearch]
GO

/****** Object:  StoredProcedure [dbo].[sp_ReportSearch]    Script Date: 2/18/2015 1:32:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_ReportSearch] (@OrderBy VARCHAR(MAX),@pageSize INT,@pageNo INT, @where VARCHAR(MAX), @userId VARCHAR(100))
AS

DECLARE	
-- @where VARCHAR(MAX), @userId VARCHAR(100),
@pageTop INT,
@pageBottom INT,
@sql VARCHAR(MAX),
@q VARCHAR(MAX),
@managerId  VARCHAR(100),
@roleEntityValue VARCHAR(50),
@role VARCHAR(50)


--SET @userId = '5B0036B0-245B-4C55-90E4-37EB123771F3';
--SET @where  = ' WHERE cs.Value = ''NCRA'' ';


SET @pageNo = @pageNo - 1    
SET @pageTop = (@pageNo * @pageSize) + 1  
SET @pageBottom = (@pageNo * @pageSize) + @pageSize

SELECT  @managerId = ManagerId, @roleEntityValue = RoleEntityValue, @role = RoleName FROM [dbo].[vw_aspnet_membership] WHERE UserId = @userId;


PRINT '@managerId=' + @managerId;
PRINT '@roleEntityValue=' + @roleEntityValue;
PRINT '@role=' + @role;

IF (@role = 'CollectionAgency' OR @role = 'DebtOwner' OR @role = 'AgencyCollector' OR @role = 'AgencyManager' OR @role = 'AgencyCompliance')
BEGIN

	IF (@role = 'CollectionAgency' OR @role = 'AgencyCollector' OR @role = 'AgencyManager' OR @role = 'AgencyCompliance')
	BEGIN
		
		SET @where = @where + ' AND ag.Name = ''' + @roleEntityValue + '''';

		IF (@role = 'AgencyCollector' OR @role = 'AgencyManager')
		BEGIN
			SELECT  @managerId = ManagerId FROM dbo.aspnet_users WHERE UserId = @userId;

			IF @managerId IS NULL
			BEGIN
				PRINT '@managerId IS NULL'
				SET @where = @where + ' AND (cm.CreatedBy = ''' + @userId + ''' OR cm.CreatedBy IN ( SELECT UserId FROM dbo.aspnet_Users WHERE ManagerId = ''' +  @userId + '''))';
			END
			ELSE
			BEGIN
				PRINT '@managerId IS NOT NULL'
				SET @where = @where + ' AND (cm.CreatedBy = ''' + @userId + ''' OR cm.CreatedBy IN ( SELECT UserId FROM dbo.aspnet_Users WHERE ManagerId = ''' +  @managerId + '''))';
			END

		END 

	END
	ELSE IF (@role = 'DebtOwner')
		SET @where = @where + ' AND act.OwnerId =  ''' + @roleEntityValue + '';

END
	     
SET @sql = 'SELECT  
			cm.ComplaintId,
			cm.AccountNumber,  
			ISNULL (act.LastName,'''') as LastName, 
			ISNULL(act.FirstName,'''') as FirstName,
			ISNULL(act.LastFourSSN,'''') as LastFourSSN,
			-- Field no 28
			CONVERT(varchar(20),cm.ComplaintDate,101) as ComplaintDate,
			-- Field no 36
			CONVERT(varchar(20),cm.MoreInfoRequestedDate,101) as DateRequested,
			-- Field no 42
			CONVERT(varchar(20),cm.ComplaintSubmittedDate,101) as DateSubmitted,
			CONVERT(varchar(20),cm.MoreInfoFromAgencyRequestedDate,101) as AgencyRequestDate,
			CONVERT(varchar(20),cm.AgencyResponseToDebtorDate,101) as ResolvedDate,
			ci.Name as ComplaintIssue,
			cm.TotalResponseTimeDays,0 as ResponseTimeDays,
			ag.Name AS AgencyId,            
			cm.OwnerResponseDate,
			v.FirstName AS UpdatedByFirstName, 
			v.LastName AS UpdatedByLastName,
			cm.UpdatedDateTime
			FROM Tbl_ComplaintMain cm 
			LEFT JOIN [dbo].[vw_aspnet_membership] v ON v.UserId = cm.UpdatedBy
			INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
			INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
			INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
			INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId';


SET @sql = @sql + @where ;
	
SET @SQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS rowNo, _MYQ.* FROM ('+@SQL+') _MYQ'
SET @Q = '
WITH CTE_pageResult AS (' + CHAR(13) + @SQL + CHAR(13) + ')'
+'
SELECT
	(SELECT COUNT(*) FROM CTE_pageResult) AS count_, 
		* 
		FROM CTE_pageResult
		WHERE rowNo BETWEEN ' + CAST(@pageTop AS VARCHAR(10)) + ' AND ' + CAST(@pageBottom AS VARCHAR(10))
PRINT @Q
EXEC (@Q)	

GO

