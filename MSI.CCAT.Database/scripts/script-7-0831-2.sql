IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_ComplaintMain_Tbl_Account]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account] FOREIGN KEY([AccountNumber])
REFERENCES [dbo].[Tbl_Account] ([AccountNumber])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_Account]
GO

INSERT [dbo].[pageMenu] ([appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) 
VALUES (1, N'Manage Users', N'Manage Users', N'Manage Users', NULL, NULL, N'/Account/ManageUsers', NULL, 0, 0, 0, NULL);
GO

INSERT [dbo].[pageMenuGroup] ([appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) 
VALUES (1, N'Manage Users', N'Manage Users', NULL, NULL, NULL, N'33');
GO

INSERT [dbo].[module] ([pageMenuGroups]) VALUES (N'6');
GO

ALTER TABLE [dbo].[Tbl_QuestionModule] Drop Column [Recommendation]
GO

ALTER TABLE [dbo].[Tbl_QuestionBank] ADD [Recommendation] [varchar](1000) NULL
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_ModulesForRoles]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_ModulesForRoles]
GO

CREATE TABLE [dbo].[Tbl_ModulesForRoles](
 [ModuleId] [int] NOT NULL,
 [RoleName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Tbl_ModulesForRoles] PRIMARY KEY CLUSTERED 
(
 [ModuleId] ASC,
 [RoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (1, 'Admin');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (1, 'CollectionAgency');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (1, 'CollectionLawfirm');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (1, 'CreditIssuer');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (1, 'DebtOwner');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (2, 'Admin');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (2, 'CollectionAgency');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (2, 'CollectionLawfirm');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (2, 'CreditIssuer');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (2, 'DebtOwner');
INSERT [dbo].[Tbl_modulesForRoles] ([ModuleId], [RoleName]) VALUES (3, 'Admin');


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSI_GetLeftSideMenu]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[MSI_GetLeftSideMenu]
GO

Create  Procedure [dbo].[MSI_GetLeftSideMenu]
@roleName varchar(50) 
AS
select distinct m.moduleId, m.pageMenuGroups from module m join tbl_modulesForRoles mr
on m.moduleId = mr.ModuleId where Upper(mr.RoleName) = @roleName
GO