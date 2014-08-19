
/****** Object:  StoredProcedure [dbo].[sp_GetAccounts]    Script Date: 08/18/2014 22:16:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetAccounts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_GetAccounts]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetAccountsByNumber]    Script Date: 08/18/2014 22:16:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetAccountsByNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_GetAccountsByNumber]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetAccounts]    Script Date: 08/18/2014 22:16:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[sp_GetAccounts]
As
Select * From Tbl_Account;
GO

/****** Object:  StoredProcedure [dbo].[sp_GetAccountsByNumber]    Script Date: 08/18/2014 22:16:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[sp_GetAccountsByNumber](@accountNumber VARCHAR(25))
AS
Select * From Tbl_Account Where AccountNumber = @accountNumber;
GO


