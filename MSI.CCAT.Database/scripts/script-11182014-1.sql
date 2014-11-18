USE [CCATDBDev]
GO

/****** Object:  StoredProcedure [dbo].[sp_AccountSearch]    Script Date: 11/18/2014 8:15:57 AM ******/
DROP PROCEDURE [dbo].[sp_AccountSearch]
GO

/****** Object:  StoredProcedure [dbo].[sp_AccountSearch]    Script Date: 11/18/2014 8:15:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[sp_AccountSearch](

@firstOrLastName VARCHAR(50) = ''

, @accountNumber VARCHAR(50) = ''

, @creditorName VARCHAR(150) = ''

, @accountOriginal VARCHAR(25) = ''

, @phoneNumber VARCHAR(50) = ''

, @roleEntityValue VARCHAR(50) = ''

, @role NVARCHAR(256) = ''

, @orderBy VARCHAR(MAX) = 'LastName, FirstName ASC'  -- Required 

, @pageSize INT = 25

, @pageNo INT = 0 )

AS

BEGIN
	DECLARE @SQL VARCHAR(MAX),
	@pageTop INT,
	@pageBottom INT,
	@Q VARCHAR(MAX),
	@SELECTClause NVARCHAR(MAX),
	@WHEREClause NVARCHAR(MAX),
	@agencyId INT	     


	SET @SELECTClause = ' SELECT * FROM vw_Account ';

	SET @WHEREClause = ' WHERE 1=1 ';

	
	IF (@role = 'CollectionAgency' OR @role = 'AgencyCollector' OR @role = 'AgencyCompliance' OR @role = 'AgencyManager')

	BEGIN

		PRINT @role;

		IF LEN(@roleEntityValue) > 0 

	BEGIN

		SELECT @agencyId =  AgencyId FROM Tbl_Agency WHERE Name = @roleEntityValue 
		--OR AgencyId = @roleEntityValue

		SET @WHEREClause = @WHEREClause + ' AND AgencyId = ' + CAST(@agencyId AS NVARCHAR(10));

	END

	END


	IF @role = 'DebtOwner'

	BEGIN

		PRINT @role;

		IF LEN(@roleEntityValue) > 0 

		BEGIN

			SET @WHEREClause = @WHEREClause + ' AND OwnerId = ' + @roleEntityValue;

		END

	END

	IF LEN(@firstOrLastName) > 0 

	BEGIN

		SET @WHEREClause = @WHEREClause + ' AND (FirstName = ''' + @firstOrLastName + ''' OR LastName = ''' + @firstOrLastName + ''')';

	END

	IF LEN(@accountNumber) > 0 

	BEGIN

		SET @WHEREClause = @WHEREClause + ' AND AccountNumber = ''' + @accountNumber + '''';

	END

	IF LEN(@creditorName) > 0 

	BEGIN

		SET @WHEREClause = @WHEREClause + ' AND CreditorName = ''' + @creditorName + '''';

	END

	IF LEN(@accountOriginal) > 0 

	BEGIN

		SET @WHEREClause = @WHEREClause + ' AND AccountOriginal = ''' + @accountOriginal + '''';

	END
		
	IF LEN(@phoneNumber) > 0 

	BEGIN

		SET @WHEREClause = @WHEREClause + ' AND (HomePhone LIKE ''' + @phoneNumber + '%'' OR WorkPhone = ''' + @phoneNumber + '%'' OR MobilePhone = ''' + @phoneNumber + '%'')';

	END

	SET @SQL = @SELECTClause + @WHEREClause;

	If @pageNo > 0 AND @pageSize > 0
	BEGIN
		SET @pageNo = @pageNo - 1    
		SET @pageTop = (@pageNo * @pageSize) + 1  
		SET @pageBottom = (@pageNo * @pageSize) + @pageSize
	END
	
	--Casting to int is required in following select clause
	--Look for this article
	--http://mythicalcode.com/2013/10/30/the-specified-cast-from-a-materialized-system-int64-type-to-the-system-int32-type-is-not-valid/
	SET @SQL = 'SELECT ROW_NUMBER() OVER (ORDER BY  LastName, FirstName) AS RowIndex, _MYQ.* FROM ('+@SQL+') _MYQ'
	SET @Q = '
		WITH CTE_pageResult AS (' + CHAR(13) + @SQL + CHAR(13) + ')'
		+'
		SELECT
				(SELECT cast(COUNT(*) as int)  FROM CTE_pageResult) AS TotalCount,
				[AccountNumber],
				[CreditorName],
				[AccountOriginal],
				[LastName],
				[FirstName],
				[City],
				[Address],
				[Zip],
				[HomePhone],
				[WorkPhone],
				[MobilePhone],
				[LastFourSSN],
				[DebtPurchaseBalance],
				[DebtCurrentBalance],
				[CreatedOn],
				[CreatedBy],
				[UpdatedOn],
				[UpdatedBy],
				[StateId],
				[AgencyId],
				[OwnerId],
				[LawFirmId],
				[CreditIssuerId],
				[CollectorUserName],
				[Cur],
				[Thirty],
				[Sixty],
				[Ninety],
				[OneTwenty],
				[Address2],
				[ST],
				[LastPaymentDate],
				[IsActive],
				[Agency],
				[State]  ';
	
	SET @Q = @Q + '	FROM CTE_pageResult';

	IF @pageTop > 0 
	BEGIN 
		SET @Q = @Q + ' WHERE RowIndex BETWEEN ' + CAST(@pageTop AS VARCHAR(10)) + ' AND ' + CAST(@pageBottom AS VARCHAR(10))
	END
	
	PRINT @Q
	EXEC (@Q)	    
END

--EXEC [dbo].[sp_AccountSearch] @firstOrLastName='Howard',@roleEntityValue='DCI', @role='CollectionAgency', @phoneNumber = '770', @pageSize = 50, @pageNo = 1
--EXEC [dbo].[sp_AccountSearch] @accountNumber='21681789',@roleEntityValue='DCI', @role='CollectionAgency', @pageSize = 50, @pageNo = 1
--EXEC [dbo].[sp_AccountSearch] @accountOriginal='534122935542', @roleEntityValue='DCI', @role='CollectionAgency', @pageSize = 50, @pageNo = 1



GO


