INSERT INTO [CCATDB].[dbo].[Tbl_Account]
([AccountNumber],[CreditorName] ,[AccountOriginal] ,[LastName] ,[FirstName] ,[Address],[City],[Zip] ,[HomePhone] ,[WorkPhone] ,[MobilePhone] ,[LastFourSSN] ,[DebtPurchaseBalance] ,[DebtCurrentBalance] ,[CreatedOn] ,[CreatedBy] ,[UpdatedOn] ,[UpdatedBy])
SELECT 
v.[ACCOUNT] ,v.[CreditorName] ,v.[OriginalAccount] ,v.[LastName] ,v.[FirstName] ,v.[ADDRESS1] + ' ' + v.[ADDRESS2] ,
v.[CITY]  ,v.[Zip] ,v.[PHONE_HOME] ,v.[PHONE_WORK] ,v.[PHONE_CELL],v.[SSN] ,v.[PurchasePrice] ,v.[Balance] ,GETDATE() ,'SYSTEM' ,GETDATE() ,'SYSTEM'
FROM [CascadeDB].[dbo].[vwAccounts] v
--INNER JOIN [CCATDB].[dbo].Tbl_States s on v.[STATE] = s.Value

