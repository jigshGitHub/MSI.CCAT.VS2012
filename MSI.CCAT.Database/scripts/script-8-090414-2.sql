USE [CCATDEVDB]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Agency_Tbl_States]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_States]'))
ALTER TABLE [dbo].[Tbl_States] DROP CONSTRAINT [FK_Tbl_Agency_Tbl_States]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_CreditIssuer_Tbl_States]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_States]'))
ALTER TABLE [dbo].[Tbl_States] DROP CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_States]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_LawFirm_Tbl_States]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_States]'))
ALTER TABLE [dbo].[Tbl_States] DROP CONSTRAINT [FK_Tbl_LawFirm_Tbl_States]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Owner_Tbl_States]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_States]'))
ALTER TABLE [dbo].[Tbl_States] DROP CONSTRAINT [FK_Tbl_Owner_Tbl_States]
GO


ALTER TABLE [dbo].[Tbl_Agency]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Agency_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Agency] CHECK CONSTRAINT [FK_Tbl_Agency_Tbl_States]
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer]  WITH NOCHECK ADD  CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer] CHECK CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_States]
GO

ALTER TABLE [dbo].[Tbl_LawFirm]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_LawFirm_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_LawFirm] CHECK CONSTRAINT [FK_Tbl_LawFirm_Tbl_States]
GO

ALTER TABLE [dbo].[Tbl_Owner]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Owner_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Owner] CHECK CONSTRAINT [FK_Tbl_Owner_Tbl_States]
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH NOCHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_States]
GO

