IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_ComplaintMain_Tbl_Account]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_ComplaintMain_Tbl_Agency]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Agency]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] ADD [AgencyID] [int] NOT NULL
GO 


ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account] FOREIGN KEY([AccountNumber])
REFERENCES [dbo].[Tbl_Account] ([AccountNumber])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Agency] FOREIGN KEY([AgencyID])
REFERENCES [dbo].[Tbl_Agency] ([AgencyID])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Agency]
GO


