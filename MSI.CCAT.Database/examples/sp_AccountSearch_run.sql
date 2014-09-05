
DECLARE @firstOrLastName VARCHAR(50)
DECLARE @accountNumber VARCHAR(50)
DECLARE @creditorName VARCHAR(150)
DECLARE @accountOriginal VARCHAR(25)
DECLARE @roleEntityValue VARCHAR(50)
DECLARE @role NVARCHAR(256)

SET @firstOrLastName = ''
SET @accountNumber = ''
SET @creditorName = ''
SET @accountOriginal = ''
SET @roleEntityValue = ''
SET @role = ''
--SET @roleEntityValue = 'DCI'
--SET @role = 'CollectionAgency'
--SET @roleEntityValue = '12'
--SET @role = 'DebtOwner'
--SET @accountNumber = '10375991'
--SET @accountOriginal = '3-301847621'
SET @creditorName = 'SPRINT SECONDS';

DECLARE @SQL NVARCHAR (MAX);
DECLARE @SELECTClause NVARCHAR(MAX);
DECLARE @WHEREClause NVARCHAR(MAX);
DECLARE @agencyId INT
SET @SELECTClause = 'SELECT * FROM TBL_ACCOUNT ';
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
	SET @WHEREClause = @WHEREClause + ' AND FirstName = ''' + @firstOrLastName + ''' OR LastName = ''' + @firstOrLastName + '';
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