IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_Tbl_ComplaintMain_aspnet_users]') AND type = 'F')
BEGIN
	ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_aspnet_users]
END
GO

ALTER TABLE TBL_ComplaintMain ADD AgencyCollectorUserId UniqueIdentifier NULL;
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_aspnet_users] FOREIGN KEY([AgencyCollectorUserId])
REFERENCES [dbo].[aspnet_users] ([UserId])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_aspnet_users]
GO

INSERT INTO [dbo].[Tbl_ModulesForRoles]([ModuleId],[RoleName]) VALUES(7,'AgencyCollector')
GO

INSERT INTO [dbo].[Tbl_ModulesForRoles]([ModuleId],[RoleName]) VALUES(7,'AgencyCompliance')
GO

INSERT INTO [dbo].[Tbl_ModulesForRoles]([ModuleId],[RoleName]) VALUES(7,'AgencyManager')
GO



