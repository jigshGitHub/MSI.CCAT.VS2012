
/****** Object:  StoredProcedure [dbo].[sp_GetAccountsByAgency]    Script Date: 09/04/2014 22:30:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetAccountsByAgency]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_GetAccountsByAgency]
GO


/****** Object:  StoredProcedure [dbo].[sp_GetAccountsByAgency]    Script Date: 09/04/2014 22:30:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[sp_GetAccountsByAgency](@id INT)
AS
Select * From Tbl_Account Where AgencyId = @id;
GO


