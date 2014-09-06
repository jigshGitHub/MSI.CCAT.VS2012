/****** Object:  StoredProcedure [dbo].[sp_AccountSearch]    Script Date: 09/05/2014 15:19:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AccountSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_AccountSearch]
GO



/****** Object:  StoredProcedure [dbo].[sp_AccountSearch]    Script Date: 09/05/2014 15:19:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[sp_AccountSearch](
@firstOrLastName VARCHAR(50) = ''
, @accountNumber VARCHAR(50) = ''
, @creditorName VARCHAR(150) = ''
, @accountOriginal VARCHAR(25) = ''
, @roleEntityValue VARCHAR(50) = ''
, @role NVARCHAR(256) = '')
AS

--SET @firstOrLastName = ''
--SET @accountNumber = ''
--SET @creditorName = ''
--SET @accountOriginal = ''
--SET @roleEntityValue = ''
--SET @role = ''
--SET @roleEntityValue = 'DCI'
--SET @role = 'CollectionAgency'
--SET @roleEntityValue = '12'
--SET @role = 'DebtOwner'
--SET @accountNumber = '10375991'
--SET @accountOriginal = '3-301847621'
--SET @creditorName = 'SPRINT SECONDS';

DECLARE @SQL NVARCHAR (MAX);
DECLARE @SELECTClause NVARCHAR(MAX);
DECLARE @WHEREClause NVARCHAR(MAX);
DECLARE @agencyId INT

CREATE TABLE #tempTbl_Account(
	[AccountNumber] [varchar](25) NOT NULL,
	[CreditorName] [varchar](150) NULL,
	[AccountOriginal] [varchar](25) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Address] [varchar](150) NULL,
	[Zip] [varchar](50) NULL,
	[HomePhone] [varchar](50) NULL,
	[WorkPhone] [varchar](50) NULL,
	[MobilePhone] [varchar](50) NULL,
	[LastFourSSN] [varchar](50) NULL,
	[DebtPurchaseBalance] [money] NULL,
	[DebtCurrentBalance] [money] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[StateId] [int] NULL,
	[AgencyId] [int] NULL,
	[OwnerId] [int] NULL,
	[LawFirmId] [int] NULL,
	[CreditIssuerId] [int] NULL,
	[CollectorUserName] [varchar](50) NULL,
	[Cur] [money] NULL,
	[Thirty] [money] NULL,
	[Sixty] [money] NULL,
	[Ninety] [money] NULL,
	[OneTwenty] [money] NULL,
	[Address2] [varchar](50) NULL,
	[ST] [varchar](3) NULL,
	[LastPaymentDate] [date] NULL,
	[IsActive] [bit] NULL
) 



SET @SELECTClause = 'INSERT INTO #tempTbl_Account SELECT * FROM TBL_ACCOUNT ';
SET @WHEREClause = 'WHERE 1=1 ';
    
IF @role = 'CollectionAgency'
BEGIN
	PRINT @role;
	IF LEN(@roleEntityValue) > 0 
	BEGIN
		SELECT @agencyId =  AgencyId FROM Tbl_Agency WHERE Name = @roleEntityValue
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
	SET @WHEREClause = @WHEREClause + ' AND FirstName = ''' + @firstOrLastName + ''' OR LastName = ''' + @firstOrLastName + '''';
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

SET @SQL = @SELECTClause + @WHEREClause 
PRINT @SQL

EXEC sp_executesql @SQL

SELECT * FROM #tempTbl_Account;

DROP TABLE #tempTbl_Account;
GO