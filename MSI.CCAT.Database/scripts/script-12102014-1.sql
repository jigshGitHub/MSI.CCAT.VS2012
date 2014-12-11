BEGIN TRY
	BEGIN TRANSACTION
	
		DECLARE @pageMenuId INT
		INSERT INTO [dbo].[pageMenu] VALUES(1,'Filtered Complaints','Filtered Complaints','Filtered Complaints','','','/CCATDEV/Compliance/Home/FilteredComplaints','title=Filtered Complaints',0,0,0,NULL);
		
		SELECT @pageMenuId = @@IDENTITY

		UPDATE [dbo].[pageMenuGroup] SET pageMenuIds = pageMenuIds + ',' + CAST(@pageMenuId as NVARCHAR(5)) WHERE Caption = 'Complaint Tracking';


	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		PRINT 'Rolling back transaction';
		ROLLBACK TRANSACTION;
	END
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;


DROP FUNCTION [dbo].[fn_GetTableSplitString]
GO

Create FUNCTION [dbo].[fn_GetTableSplitString](  
    @sInputList VARCHAR(MAX) -- List of delimited items  
	,@sDelimiter CHAR(1)-- delimiter that separates items  
) RETURNS @List TABLE (item VARCHAR(100))  
  
BEGIN  
DECLARE @sItem VARCHAR(100)  
  
WHILE CHARINDEX(@sDelimiter,@sInputList,0) <> 0  
 BEGIN  
 SELECT  
  @sItem=RTRIM(LTRIM(SUBSTRING(@sInputList,1,CHARINDEX(@sDelimiter,@sInputList,0)-1))),  
  @sInputList=RTRIM(LTRIM(SUBSTRING(@sInputList,CHARINDEX(@sDelimiter,@sInputList,0)+LEN(@sDelimiter),LEN(@sInputList))))  
   
 IF LEN(@sItem) > 0  
  INSERT INTO @List SELECT @sItem  
 END  
  
IF LEN(@sInputList) > 0  
 INSERT INTO @List SELECT @sInputList -- Put the last item in  
RETURN  
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FilteredReportSearch]') AND type in (N'P', N'PC'))

DROP PROCEDURE [dbo].[sp_FilteredReportSearch]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create Procedure [dbo].[sp_FilteredReportSearch] (@OrderBy VARCHAR(MAX),@pageSize INT,@pageNo INT, @managerUserIds VARCHAR(MAX)='', @collectorUserIds VARCHAR(MAX), @userId VARCHAR(100))
AS

DECLARE	
@pageTop INT,
@pageBottom INT,
@sql VARCHAR(MAX),
@q VARCHAR(MAX),
@roleEntityValue VARCHAR(50),
@role VARCHAR(50),
@where VARCHAR(MAX)


SET @pageNo = @pageNo - 1    
SET @pageTop = (@pageNo * @pageSize) + 1  
SET @pageBottom = (@pageNo * @pageSize) + @pageSize

SELECT  @roleEntityValue = RoleEntityValue, @role = RoleName FROM [dbo].[vw_aspnet_membership] WHERE UserId = @userId;

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
			cm.OwnerResponseDate
			FROM Tbl_ComplaintMain cm
			INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
			INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
			INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
			INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId';

SET @where = ' WHERE cs.Value <> ''RC'' AND ag.Name = ''' + @roleEntityValue + '''';

IF LEN(@collectorUserIds) > 0 
BEGIN
	SET @where = @where + ' AND (cm.CreatedBy IN (SELECT * FROM dbo.[fn_GetTableSplitString](''' + @collectorUserIds + ''','','')))';
END
ELSE IF(LEN(@managerUserIds) > 0)
BEGIN
	SET @where = @where + ' AND cm.CreatedBy IN ( SELECT UserId FROM dbo.aspnet_Users WHERE ManagerId IN (SELECT * FROM dbo.[fn_GetTableSplitString](''' +  @managerUserIds + ''','','')))';
END


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


