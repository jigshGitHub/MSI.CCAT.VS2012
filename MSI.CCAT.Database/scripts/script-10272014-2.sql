IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vw_Account]') AND type in (N'V'))
	DROP VIEW [dbo].[vw_Account]
GO

Create View [dbo].[vw_Account]
AS

SELECT NULL As TotalCount, a.*, ag.Name As [Agency], s.Value as [State] FROM Tbl_Account a 
LEFT JOIN Tbl_Agency ag ON ag.AgencyId = a.AgencyId
LEFT JOIN Tbl_States s ON s.Id = a.StateId;