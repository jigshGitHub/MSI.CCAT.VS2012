USE [CCATDB]
GO
/****** Object:  ForeignKey [FK_Tbl_QuestionBank_Tbl_Module]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_QuestionBank_Tbl_Module]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]'))
ALTER TABLE [dbo].[Tbl_QuestionBank] DROP CONSTRAINT [FK_Tbl_QuestionBank_Tbl_Module]
GO
/****** Object:  ForeignKey [FK_Tbl_Response_Tbl_QuestionBank]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Response_Tbl_QuestionBank]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]'))
ALTER TABLE [dbo].[Tbl_QuestionResponse] DROP CONSTRAINT [FK_Tbl_Response_Tbl_QuestionBank]
GO
/****** Object:  Table [dbo].[Tbl_QuestionResponse]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Response_Tbl_QuestionBank]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]'))
ALTER TABLE [dbo].[Tbl_QuestionResponse] DROP CONSTRAINT [FK_Tbl_Response_Tbl_QuestionBank]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_QuestionResponse]
GO
/****** Object:  StoredProcedure [dbo].[MSI_GetMenuDetails]    Script Date: 06/11/2013 00:13:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSI_GetMenuDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[MSI_GetMenuDetails]
GO
/****** Object:  Table [dbo].[Tbl_QuestionBank]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_QuestionBank_Tbl_Module]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]'))
ALTER TABLE [dbo].[Tbl_QuestionBank] DROP CONSTRAINT [FK_Tbl_QuestionBank_Tbl_Module]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_QuestionBank]
GO
/****** Object:  Table [dbo].[Tbl_QuestionModule]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionModule]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_QuestionModule]
GO
/****** Object:  Table [dbo].[pageMenu]    Script Date: 06/11/2013 00:13:07 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pageMenu_isNewWindow]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isNewWindow]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pageMenu_isModal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isModal]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pageMenu_inIFRAME]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_inIFRAME]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenu]') AND type in (N'U'))
DROP TABLE [dbo].[pageMenu]
GO
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 06/11/2013 00:13:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenuGroup]') AND type in (N'U'))
DROP TABLE [dbo].[pageMenuGroup]
GO
/****** Object:  Table [dbo].[module]    Script Date: 06/11/2013 00:13:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[module]') AND type in (N'U'))
DROP TABLE [dbo].[module]
GO
/****** Object:  Table [dbo].[module]    Script Date: 06/11/2013 00:13:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[module]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[module](
	[moduleId] [int] IDENTITY(1,1) NOT NULL,
	[pageMenuGroups] [nvarchar](1000) NULL,
 CONSTRAINT [PK_module] PRIMARY KEY NONCLUSTERED 
(
	[moduleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[module] ON
INSERT [dbo].[module] ([moduleId], [pageMenuGroups]) VALUES (1, N'1,2,4')
INSERT [dbo].[module] ([moduleId], [pageMenuGroups]) VALUES (2, N'3')
SET IDENTITY_INSERT [dbo].[module] OFF
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 06/11/2013 00:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenuGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pageMenuGroup](
	[pageMenuGroupId] [int] IDENTITY(1,1) NOT NULL,
	[appId] [int] NULL,
	[name] [nvarchar](50) NULL,
	[caption] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[iconPath] [nvarchar](250) NULL,
	[iconClass] [nvarchar](50) NULL,
	[pageMenuIds] [varchar](100) NULL,
 CONSTRAINT [PK_pageMenuGroup] PRIMARY KEY CLUSTERED 
(
	[pageMenuGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[pageMenuGroup] ON
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (1, 1, N'Dashboard Overview', N'Dashboard', NULL, NULL, NULL, N'1')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (2, 1, N'Compliance Self-Assessment', N'Self Assessment', NULL, NULL, NULL, N'2,3,4,5,6,7,8')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (3, 1, N'Audit and Risk Mitigation', N'Audit & Risk Mitigation', NULL, NULL, NULL, N'9')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (4, 1, N'Compliance Tracking', N'Compliance Tracking', NULL, NULL, NULL, N'10')
SET IDENTITY_INSERT [dbo].[pageMenuGroup] OFF
/****** Object:  Table [dbo].[pageMenu]    Script Date: 06/11/2013 00:13:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pageMenu](
	[pageMenuId] [int] IDENTITY(1,1) NOT NULL,
	[appId] [int] NULL,
	[name] [nvarchar](100) NOT NULL,
	[shortCaption] [nvarchar](50) NOT NULL,
	[longCaption] [nvarchar](250) NOT NULL,
	[description] [nvarchar](max) NULL,
	[iconPath] [nvarchar](250) NULL,
	[pagePath] [nvarchar](250) NULL,
	[pageParams] [nvarchar](500) NULL,
	[isNewWindow] [bit] NULL CONSTRAINT [DF_pageMenu_isNewWindow]  DEFAULT ((0)),
	[isModal] [bit] NULL CONSTRAINT [DF_pageMenu_isModal]  DEFAULT ((0)),
	[inIFRAME] [bit] NULL CONSTRAINT [DF_pageMenu_inIFRAME]  DEFAULT ((0)),
	[aElementIdentifier] [varchar](100) NULL,
 CONSTRAINT [PK_pageMenu] PRIMARY KEY CLUSTERED 
(
	[pageMenuId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[pageMenu] ON
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (1, 1, N'Dashboard Overview', N'Dashboard', N'Overview', NULL, NULL, N'/CCATDev//Dashboard/Home/Overview', NULL, 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (2, 1, N'Entity Business Model', N'Module 1: Entity Business Model', N'Module 1:Entity Business Model', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=1', N'title=Module1', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (3, 1, N'Communications in Connection with Debt Collection', N'Module 2: Communications with Debt Collection', N'Communications in Connection with Debt Collection', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=2', N'title=Module2', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (4, 1, N'Information Sharing & Privacy', N'Module 3: Information Sharing & Privacy', N'Fundraising Overview (#2)', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=3', N'title=Module3', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (5, 1, N'Consumer Companies & Resolutions', N'Module 4: Consumer Companies & Resolutions', N'Import', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=4', N'title=Module4', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (6, 1, N'Equal Credit Opportunity Act', N'Module 5: Equal Credit Opportunity Act', N'Merge', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=5', N'title=Module5', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (7, 1, N'Litigation Practices & Repossession', N'MOdule 6: Litigation Practices & Repossession', N'Tasks/Calls', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=6', N'title=Module6', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (8, 1, N'Payment Processing and Account Maintenance', N'Module 7: Payment Processing & Account Maintenance', N'Thank You', NULL, NULL, N'/CCATDev/Assessment/Home/Index?moduleid=7', N'title=Module7', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (9, 1, N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', NULL, NULL, N'/Audit/ManageRisk', N'title=ManageRisk', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (10, 1, N'Tracking', N'Compliance Tracking', N'Compliance Tracking', NULL, NULL, N'/CCATDev/Compliance/Home/Create', N'title=Tracking', 0, 0, 0, N'')
SET IDENTITY_INSERT [dbo].[pageMenu] OFF
/****** Object:  Table [dbo].[Tbl_QuestionModule]    Script Date: 06/11/2013 00:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionModule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tbl_QuestionModule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_Tbl_Module] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_QuestionModule] ON
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (1, N'Entity Business Model', 1, CAST(0x0000A1C2011BBC82 AS DateTime), N'System', 1)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (2, N'Communications in Connection with Debt Collection', 1, CAST(0x0000A1C2011BE96B AS DateTime), N'System', 2)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (3, N'Information Sharing & Privacy', 1, CAST(0x0000A1C2011C25A4 AS DateTime), N'System', 3)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (4, N'Consumer Companies & Resolutions', 1, CAST(0x0000A1C2011C4A1F AS DateTime), N'System', 4)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (5, N'Equal Credit Opportunity Act', 1, CAST(0x0000A1C2011C5E65 AS DateTime), N'System', 5)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (6, N'Litigation Practices & Repossession', 1, CAST(0x0000A1C2011C8E3A AS DateTime), N'System', 6)
INSERT [dbo].[Tbl_QuestionModule] ([Id], [Name], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (7, N'Payment Processing and Account Maintenance', 1, CAST(0x0000A1C2011CFF8A AS DateTime), N'System', 7)
SET IDENTITY_INSERT [dbo].[Tbl_QuestionModule] OFF
/****** Object:  Table [dbo].[Tbl_QuestionBank]    Script Date: 06/11/2013 00:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tbl_QuestionBank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SrNo] [varchar](50) NULL,
	[Text] [varchar](500) NULL,
	[ToolTipText] [varchar](1000) NULL,
	[ModuleId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_Tbl_QuestionBank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_QuestionBank] ON
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (1, N'1.1', N'Does your entity fall within the general definition of "debt collector"?', NULL, 1, 1, CAST(0x0000A1C201238A30 AS DateTime), N'System', 1)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (2, N'1.2', N'Does your organization perform or engage in the following activities:', NULL, 1, 1, CAST(0x0000A1C2012413AA AS DateTime), N'System', 2)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (3, N'1.2.1', N'Regularly collects, or attempts to collect, consumer debts for another person or institution', NULL, 1, 1, CAST(0x0000A1C2012465C8 AS DateTime), N'System', 3)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (4, N'1.2.2', N'Uses interstate commerce or the mail in a business the principal purpose of which is consumer debt collection', NULL, 1, 1, CAST(0x0000A1C20124AC31 AS DateTime), N'System', 4)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (5, N'1.2.3', N'Uses a name other than its own when collecting its own consumer debts - - OR', NULL, 1, 1, CAST(0x0000A1C20124E89F AS DateTime), N'System', 5)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (6, N'1.2.4', N'Seeks to collect on a consumer debt it owns that was already in default at the time it acquired it (15 U.S.C. 1692A(6))', NULL, 1, 1, CAST(0x0000A1C20125F24E AS DateTime), N'System', 6)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (7, N'1.3', N'Does your organization collect on consumer accounts using its own name for any of the following?', NULL, 1, 1, CAST(0x0000A1C201262814 AS DateTime), N'System', 7)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (8, N'1.3.1', N'Debts it originated for itself', NULL, 1, 1, CAST(0x0000A1C201268B56 AS DateTime), N'System', 8)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (9, N'1.3.2', N'Debts that were not in default when they were obtained', NULL, 1, 1, CAST(0x0000A1C20126A7DB AS DateTime), N'System', 9)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (10, N'1.3.3', N'Debts that were obtained as security for a commercial credit transaction', NULL, 1, 1, CAST(0x0000A1C20126CE15 AS DateTime), N'System', 10)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (11, N'1.3.4', N'Debts incidental to a bona fide fiduciary relationship or escrow arrangement', NULL, 1, 1, CAST(0x0000A1C20126F3C2 AS DateTime), N'System', 11)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (12, N'1.4', N'Does an officer or employee of your organization collect depts owed to your company in the company''s own name?', NULL, 1, 1, CAST(0x0000A1C201273F38 AS DateTime), N'System', 12)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (13, N'1.5', N'Does your organization collect on debts regularly for other institutions to which it is related by common ownership or corporate control if the entity only does so for persons to whom it is so related or affiliated and the entity''s principal business is not the collection of debts?', NULL, 1, 1, CAST(0x0000A1C201280886 AS DateTime), N'System', 13)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (14, N'1.6', N'Is your business entity affiliated with any other entities, and if so, please select the nature of the affiliates business activities, including whether any of the affiliates engage in debt collection.', NULL, 1, 1, CAST(0x0000A1C2012AF6A4 AS DateTime), N'System', 14)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (15, N'1.7', N'Does your entity or affiliate use any service providers in conducting its debt collection activities?  If so, please provide the following', NULL, 1, 1, CAST(0x0000A1C2012B1E18 AS DateTime), N'System', 15)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (16, N'1.7.1', N'Identify the type of the service providers', NULL, 1, 1, CAST(0x0000A1C2012B3D54 AS DateTime), N'System', 16)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (17, N'1.7.2', N'Identify whether they are affiliated with the entity', NULL, 1, 1, CAST(0x0000A1C2012B55CC AS DateTime), N'System', 17)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (18, N'1.7.3', N'Identify what services they perform', NULL, 1, 1, CAST(0x0000A1C2012B7498 AS DateTime), N'System', 18)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (19, N'1.7.4', N'Assess whether the entity performs any of the following tasks:', NULL, 1, 1, CAST(0x0000A1C2012B9272 AS DateTime), N'System', 19)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (20, N'1.7.4.1', N'Requests and reviews the service providers'' policies, procedures, internal controls, and training materials to ensure that the service providers conduct appropriate training and oversight of employees or agents that have consumer contact or compliance responsibilities.', NULL, 1, 1, CAST(0x0000A1C2012BF945 AS DateTime), N'System', 20)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (21, N'1.7.4.2', N'Does the service provider inform, as appropriate and enforceable consequences for violating any compliance-related responsibilities?', NULL, 1, 1, CAST(0x0000A1C2012C1A9E AS DateTime), N'System', 21)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (22, N'1.7.4.3', N'Establishes internal controls and on-going monitoring to determine whether its service providers are complying with Federal consumer financial law', NULL, 1, 1, CAST(0x0000A1C2012C42A2 AS DateTime), N'System', 22)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (23, N'1.7.4.4', N'Takes prompt action to address fully any problems identified through the monitoring process, including terminating the relationship where appropriate', NULL, 1, 1, CAST(0x0000A1C2012C7E51 AS DateTime), N'System', 23)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (24, N'1.8', N'Does your company have an organizational chart that indicates the reporting structure and the responsibilities of key managers for debt collection activities?', NULL, 1, 1, CAST(0x0000A1C2012CA5E7 AS DateTime), N'System', 24)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (25, N'1.9', N'Does your company have documented information regarding the qualifications, experience levels, and training programs that the company requires or uses for staff who interact with consumers?', NULL, 1, 1, CAST(0x0000A1C2012CD7BB AS DateTime), N'System', 25)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (26, N'1.10', N'Does your company perform annual evaluations of compensation practices and programs?', NULL, 1, 1, CAST(0x0000A1C2012CF3E1 AS DateTime), N'System', 26)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (27, N'1.11', N'Does your company evaluate the quality and impact of controls on the compensation program?', NULL, 1, 1, CAST(0x0000A1C2012D353D AS DateTime), N'System', 27)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (28, N'1.12', N'To the extent that your company''s compensation program creates incentives for behaviors or practices that result in heightened risk to consumers, does it also include disciplinary procedures such as reductions in compensation or termination if an employee is fount to engage in such risky behaviors or practices?', NULL, 1, 1, CAST(0x0000A1C2012D60D8 AS DateTime), N'System', 28)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (30, N'2.1', N'Do representatives from your company place debt collection calls without meaningful disclosure of its identity (except for the sole purpose of acquiring location information)?', NULL, 2, 1, CAST(0x0000A1C2012E7234 AS DateTime), N'System', 1)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (31, N'2.2', N'Do representatives from your company disclose in your first written communication with consumers they are attempting to collect a debt on that any informaiton obtained will be used for that purpose?', NULL, 2, 1, CAST(0x0000A1C2012EF11E AS DateTime), N'System', 2)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (32, N'2.3', N'If the intial communication is oral, do debt collectors also disclose the same infromation in the initial oral communication or subsequent communications to debtors?', NULL, 2, 1, CAST(0x0000A1C2012F226B AS DateTime), N'System', 3)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (33, N'2.4', N'Have debt collectors from your organization misrepresented their identity or authorization by any of the following:', NULL, 2, 1, CAST(0x0000A1C201311E9D AS DateTime), N'System', 4)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (34, N'2.4.1', N'Using any business, company, or organization name other than the true name of the debt collector''s business, company, or organization?', NULL, 2, 1, CAST(0x0000A1C201314AE2 AS DateTime), N'System', 5)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (35, N'2.4.2', N'Misrepresenting that it is vouced for, bonded by, or affiliated with the United States or any State, including by using any badge, uniform, or fascimile?', NULL, 2, 1, CAST(0x0000A1C2013166F6 AS DateTime), N'System', 6)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (36, N'2.4.3', N'Representing or implying that an individual debt collector is an attorney?', NULL, 2, 1, CAST(0x0000A1C201317CC9 AS DateTime), N'System', 6)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (37, N'2.4.4', N'Representing that it operates or is employed by a consumer reporting agency?', NULL, 2, 1, CAST(0x0000A1C201319AA9 AS DateTime), N'System', 7)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (38, N'2.4.5', N'Using or distributing any written communication that creates a false impression as to its source, authorization, or approval, or that simulates or is falsely represented to be a government document (15 U.S.C. 1692e(9)); - - OR', NULL, 2, 1, CAST(0x0000A1C20131BEBF AS DateTime), N'System', 8)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (39, N'2.4.6', N'Using any forms that falsely imply that someone other than the creditor is participating in the collection activities.  If so, determine the source of the forms (15 U.S.C. 1692j).', NULL, 2, 1, CAST(0x0000A1C20131DA24 AS DateTime), N'System', 9)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (40, N'2.5', N'Do your debt collectors make any false representations regarding the nature of the communications, for example by:', NULL, 2, 1, CAST(0x0000A1C20131FF12 AS DateTime), N'System', 10)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (41, N'2.5.1', N'Falsely representing or implying that documents are legal process; - - - OR', NULL, 2, 1, CAST(0x0000A1C201321E05 AS DateTime), N'System', 11)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (42, N'2.5.2', N'Falsely representing that document are not legal process forms, or that documents do not require action by the consumer?', NULL, 2, 1, CAST(0x0000A1C2013241D4 AS DateTime), N'System', 12)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (43, N'3.1', N'Does your organization originate debt, purchase debt, or collect on behalf of another party that owns the debt?', NULL, 3, 1, CAST(0x0000A1C2013293DB AS DateTime), N'System', 1)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (44, N'3.2', N'For the debt that your organization originated or purchased and on which you collected or are collecting, does your firm use the Privacy of Consumer Financial Information examination procedues to assess compliance with the applicable requirements?', NULL, 3, 1, CAST(0x0000A1C20132B049 AS DateTime), N'System', 2)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (45, N'3.3', N'For debt that your organization does not own but collects or attempts to collect on behalf of another party, does your firm use the Privacy of Consumer Financial Information examination procedures to assess compliance with the "reuse and redisclosure" limitations?', NULL, 3, 1, CAST(0x0000A1C20132D59C AS DateTime), N'System', 3)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (46, N'3.4', N'Regarding RCRA and Regulation V, does your organization obtain consumer reports from any consumer reporting agency?', NULL, 3, 1, CAST(0x0000A1C20132EEE6 AS DateTime), N'System', 4)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (47, N'3.5', N'Does your firm use the FCRA examination procedures to assess its compliance with the requirements on users of consumer reports?', NULL, 3, 1, CAST(0x0000A1C20133194A AS DateTime), N'System', 5)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (48, N'3.5.1', N'Does your firm train employees regarding use of consumer reports?', NULL, 3, 1, CAST(0x0000A1C20133310F AS DateTime), N'System', 6)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (49, N'3.5.2', N'Does your firm use the reports for any impermissible purpose?', NULL, 3, 1, CAST(0x0000A1C201334793 AS DateTime), N'System', 7)
INSERT [dbo].[Tbl_QuestionBank] ([Id], [SrNo], [Text], [ToolTipText], [ModuleId], [IsActive], [CreatedOn], [CreatedBy], [DisplayOrder]) VALUES (50, N'3.5.3', N'Does your firm comply with duties of users regarding the addressing of discrepancies?', NULL, 3, 1, CAST(0x0000A1C2013360B6 AS DateTime), N'System', 8)
SET IDENTITY_INSERT [dbo].[Tbl_QuestionBank] OFF
/****** Object:  StoredProcedure [dbo].[MSI_GetMenuDetails]    Script Date: 06/11/2013 00:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSI_GetMenuDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create Procedure [dbo].[MSI_GetMenuDetails]
  @appId int
AS
  
  
SELECT	DISTINCT
		W.pageMenuGroupId, M.pageMenuId, 
		CASE WHEN PATINDEX(CAST(M.pageMenuId AS VARCHAR(10))+'',%'', W.pageMenuIds)>0 
				THEN PATINDEX(CAST(M.pageMenuId AS VARCHAR(10))+'',%'', W.pageMenuIds)
			 WHEN PATINDEX(''%''+CAST(M.pageMenuId AS VARCHAR(10)), W.pageMenuIds)>0 
				THEN PATINDEX(''%''+CAST(M.pageMenuId AS VARCHAR(10)), W.pageMenuIds)				
			 WHEN PATINDEX(''%,''+CAST(M.pageMenuId AS VARCHAR(10))+'',%'', W.pageMenuIds)>0 
				THEN PATINDEX(''%,''+CAST(M.pageMenuId AS VARCHAR(10))+'',%'', W.pageMenuIds)
			 ELSE 99 END AS listOrder
	FROM	pageMenu M
			INNER JOIN pageMenuGroup W ON 
					W.pageMenuIds LIKE CAST(M.pageMenuId AS VARCHAR(10))		-- Itself
					OR W.pageMenuIds LIKE CAST(M.pageMenuId AS VARCHAR(10))+'',%''		-- If a starting element
					OR W.pageMenuIds LIKE ''%,''+CAST(M.pageMenuId AS VARCHAR(10))		-- If an ending element
					OR W.pageMenuIds LIKE ''%,''+CAST(M.pageMenuId AS VARCHAR(10))+'',%''	-- If a middle element

			--INNER JOIN accessElement E ON E.aElementIdentifier = M.aElementIdentifier
			--INNER JOIN auth A ON E.aElementId = A.aElementId AND A.accessRightId>0
			--INNER JOIN userGroup UG ON UG.userGroupId = A.userGroupId
			--INNER JOIN access AC ON UG.userGroupId = AC.userGroupId
			--INNER JOIN project P ON P.projectId = AC.projectId
			--INNER JOIN aspnet_Users U ON U.userId = AC.userId
	WHERE	W.appId = @appId
			--	AND E.appId = @appId
			--	AND P.appId = @appId 
			--AND UG.userGroupId = @userGroupId 
			--AND P.projectId = @projectId

	ORDER BY W.pageMenuGroupId,
			 listOrder
' 
END
GO
/****** Object:  Table [dbo].[Tbl_QuestionResponse]    Script Date: 06/11/2013 00:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tbl_QuestionResponse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](500) NULL,
	[QuestionId] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Tbl_Response] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_QuestionResponse] ON
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (141, N'1', 1, CAST(0x0000A1CB0096B570 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', CAST(0x0000A1CB009761E0 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (142, NULL, 2, CAST(0x0000A1CB0096B571 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (143, NULL, 3, CAST(0x0000A1CB0096B572 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (144, NULL, 4, CAST(0x0000A1CB0096B573 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (145, NULL, 5, CAST(0x0000A1CB0096B573 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (146, NULL, 6, CAST(0x0000A1CB0096B574 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (147, N'4', 7, CAST(0x0000A1CB0096B575 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', CAST(0x0000A1CB009771D0 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (148, NULL, 8, CAST(0x0000A1CB0096B576 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (149, NULL, 9, CAST(0x0000A1CB0096B577 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (150, NULL, 10, CAST(0x0000A1CB0096B579 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (151, NULL, 11, CAST(0x0000A1CB0096B579 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (152, NULL, 12, CAST(0x0000A1CB0096B57A AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (153, NULL, 13, CAST(0x0000A1CB0096B57B AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (154, NULL, 14, CAST(0x0000A1CB0096B57C AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (155, NULL, 15, CAST(0x0000A1CB0096B57D AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (156, NULL, 16, CAST(0x0000A1CB0096B57E AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (157, NULL, 17, CAST(0x0000A1CB0096B57F AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (158, NULL, 18, CAST(0x0000A1CB0096B580 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (159, NULL, 19, CAST(0x0000A1CB0096B580 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (160, NULL, 20, CAST(0x0000A1CB0096B581 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (161, NULL, 21, CAST(0x0000A1CB0096B584 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (162, NULL, 22, CAST(0x0000A1CB0096B585 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (163, NULL, 23, CAST(0x0000A1CB0096B587 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (164, NULL, 24, CAST(0x0000A1CB0096B589 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (165, NULL, 25, CAST(0x0000A1CB0096B58B AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (166, NULL, 26, CAST(0x0000A1CB0096B58D AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (167, NULL, 27, CAST(0x0000A1CB0096B58E AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (168, NULL, 28, CAST(0x0000A1CB0096B590 AS DateTime), N'16157be1-9e4b-4930-9da7-5bd123c05078', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (169, NULL, 1, CAST(0x0000A1CB00979879 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (170, NULL, 2, CAST(0x0000A1CB0097987C AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (171, NULL, 3, CAST(0x0000A1CB0097987D AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (172, NULL, 4, CAST(0x0000A1CB0097987F AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (173, NULL, 5, CAST(0x0000A1CB00979880 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (174, NULL, 6, CAST(0x0000A1CB00979881 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (175, NULL, 7, CAST(0x0000A1CB00979883 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (176, NULL, 8, CAST(0x0000A1CB00979885 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (177, NULL, 9, CAST(0x0000A1CB00979886 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (178, NULL, 10, CAST(0x0000A1CB0097988A AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (179, NULL, 11, CAST(0x0000A1CB0097988B AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (180, NULL, 12, CAST(0x0000A1CB0097988C AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (181, NULL, 13, CAST(0x0000A1CB0097988D AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (182, NULL, 14, CAST(0x0000A1CB0097988E AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (183, NULL, 15, CAST(0x0000A1CB0097988F AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (184, NULL, 16, CAST(0x0000A1CB0097988F AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (185, NULL, 17, CAST(0x0000A1CB00979890 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (186, NULL, 18, CAST(0x0000A1CB00979891 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (187, NULL, 19, CAST(0x0000A1CB00979892 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (188, N'2', 20, CAST(0x0000A1CB00979893 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', CAST(0x0000A1D2000E354E AS DateTime), N'359253a6-8901-4229-b210-81430f48403d')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (189, N'2', 21, CAST(0x0000A1CB00979894 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', CAST(0x0000A1D100B4610F AS DateTime), N'359253a6-8901-4229-b210-81430f48403d')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (190, NULL, 22, CAST(0x0000A1CB00979894 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (191, NULL, 23, CAST(0x0000A1CB00979895 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (192, NULL, 24, CAST(0x0000A1CB00979896 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (193, NULL, 25, CAST(0x0000A1CB00979897 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (194, NULL, 26, CAST(0x0000A1CB00979898 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (195, N'0', 27, CAST(0x0000A1CB00979898 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', CAST(0x0000A1D100B4F84A AS DateTime), N'359253a6-8901-4229-b210-81430f48403d')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (196, N'5', 28, CAST(0x0000A1CB00979899 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', CAST(0x0000A1CB0097B2C3 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (197, NULL, 30, CAST(0x0000A1CF017C5798 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (198, NULL, 31, CAST(0x0000A1CF017C5865 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (199, NULL, 32, CAST(0x0000A1CF017C5868 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (200, NULL, 33, CAST(0x0000A1CF017C586B AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (201, NULL, 34, CAST(0x0000A1CF017C586D AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (202, NULL, 35, CAST(0x0000A1CF017C586F AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (203, NULL, 36, CAST(0x0000A1CF017C5871 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (204, NULL, 37, CAST(0x0000A1CF017C5873 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (205, NULL, 38, CAST(0x0000A1CF017C5875 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (206, NULL, 39, CAST(0x0000A1CF017C5877 AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (207, NULL, 40, CAST(0x0000A1CF017C587A AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (208, NULL, 41, CAST(0x0000A1CF017C587C AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (209, NULL, 42, CAST(0x0000A1CF017C587D AS DateTime), N'359253a6-8901-4229-b210-81430f48403d', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (210, NULL, 1, CAST(0x0000A1D6018B0395 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (211, NULL, 2, CAST(0x0000A1D6018B0451 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (212, NULL, 3, CAST(0x0000A1D6018B0454 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (213, NULL, 4, CAST(0x0000A1D6018B0456 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (214, NULL, 5, CAST(0x0000A1D6018B0459 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (215, NULL, 6, CAST(0x0000A1D6018B045E AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (216, NULL, 7, CAST(0x0000A1D6018B0463 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (217, NULL, 8, CAST(0x0000A1D6018B0466 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (218, NULL, 9, CAST(0x0000A1D6018B0467 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (219, NULL, 10, CAST(0x0000A1D6018B0468 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (220, NULL, 11, CAST(0x0000A1D6018B046E AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (221, NULL, 12, CAST(0x0000A1D6018B046F AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (222, NULL, 13, CAST(0x0000A1D6018B0470 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (223, NULL, 14, CAST(0x0000A1D6018B0471 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (224, NULL, 15, CAST(0x0000A1D6018B0472 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (225, NULL, 16, CAST(0x0000A1D6018B0474 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (226, NULL, 17, CAST(0x0000A1D6018B0475 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (227, NULL, 18, CAST(0x0000A1D6018B0476 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (228, NULL, 19, CAST(0x0000A1D6018B0477 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (229, NULL, 20, CAST(0x0000A1D6018B0479 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (230, NULL, 21, CAST(0x0000A1D6018B047A AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (231, NULL, 22, CAST(0x0000A1D6018B047B AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (232, NULL, 23, CAST(0x0000A1D6018B047D AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (233, NULL, 24, CAST(0x0000A1D6018B047E AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (234, NULL, 25, CAST(0x0000A1D6018B047F AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (235, NULL, 26, CAST(0x0000A1D6018B0480 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (236, NULL, 27, CAST(0x0000A1D6018B0481 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (237, NULL, 28, CAST(0x0000A1D6018B0483 AS DateTime), N'206e20f5-f4b8-4d21-87cf-efc674dee97f', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (238, NULL, 1, CAST(0x0000A1D900AA24E4 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (239, NULL, 2, CAST(0x0000A1D900AA2729 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (240, NULL, 3, CAST(0x0000A1D900AA272E AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (241, NULL, 4, CAST(0x0000A1D900AA2733 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (242, NULL, 5, CAST(0x0000A1D900AA2733 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (243, NULL, 6, CAST(0x0000A1D900AA2737 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (244, NULL, 7, CAST(0x0000A1D900AA2737 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (245, NULL, 8, CAST(0x0000A1D900AA273C AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (246, NULL, 9, CAST(0x0000A1D900AA273C AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (247, NULL, 10, CAST(0x0000A1D900AA273C AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (248, NULL, 11, CAST(0x0000A1D900AA2741 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (249, NULL, 12, CAST(0x0000A1D900AA2741 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (250, NULL, 13, CAST(0x0000A1D900AA2745 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (251, NULL, 14, CAST(0x0000A1D900AA2745 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (252, NULL, 15, CAST(0x0000A1D900AA274A AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (253, NULL, 16, CAST(0x0000A1D900AA274A AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (254, NULL, 17, CAST(0x0000A1D900AA274F AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (255, NULL, 18, CAST(0x0000A1D900AA274F AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (256, NULL, 19, CAST(0x0000A1D900AA2754 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (257, NULL, 20, CAST(0x0000A1D900AA2754 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (258, N'3', 21, CAST(0x0000A1D900AA2758 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', CAST(0x0000A1D90113E9BE AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (259, N'N/A', 22, CAST(0x0000A1D900AA2758 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', CAST(0x0000A1D90114043A AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115')
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (260, NULL, 23, CAST(0x0000A1D900AA275D AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (261, NULL, 24, CAST(0x0000A1D900AA275D AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (262, NULL, 25, CAST(0x0000A1D900AA2762 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (263, NULL, 26, CAST(0x0000A1D900AA2762 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (264, NULL, 27, CAST(0x0000A1D900AA2766 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (265, NULL, 28, CAST(0x0000A1D900AA2766 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (266, NULL, 30, CAST(0x0000A1D900AA3D4D AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (267, NULL, 31, CAST(0x0000A1D900AA3D4F AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (268, NULL, 32, CAST(0x0000A1D900AA3D51 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (269, NULL, 33, CAST(0x0000A1D900AA3D56 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (270, NULL, 34, CAST(0x0000A1D900AA3D58 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (271, NULL, 35, CAST(0x0000A1D900AA3D5A AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (272, NULL, 36, CAST(0x0000A1D900AA3D5C AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (273, NULL, 37, CAST(0x0000A1D900AA3D5E AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (274, NULL, 38, CAST(0x0000A1D900AA3D60 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (275, NULL, 39, CAST(0x0000A1D900AA3D62 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (276, NULL, 40, CAST(0x0000A1D900AA3D64 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (277, NULL, 41, CAST(0x0000A1D900AA3D66 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (278, NULL, 42, CAST(0x0000A1D900AA3D69 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (279, NULL, 43, CAST(0x0000A1D900AA40DC AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (280, NULL, 44, CAST(0x0000A1D900AA40E0 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (281, NULL, 45, CAST(0x0000A1D900AA40E2 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (282, NULL, 46, CAST(0x0000A1D900AA40E7 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (283, NULL, 47, CAST(0x0000A1D900AA40EC AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (284, NULL, 48, CAST(0x0000A1D900AA40F1 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (285, NULL, 49, CAST(0x0000A1D900AA40F6 AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
INSERT [dbo].[Tbl_QuestionResponse] ([Id], [Value], [QuestionId], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (286, NULL, 50, CAST(0x0000A1D900AA40FB AS DateTime), N'9a0bee10-1bbd-45ad-81fc-c1e5a70d2115', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tbl_QuestionResponse] OFF
/****** Object:  ForeignKey [FK_Tbl_QuestionBank_Tbl_Module]    Script Date: 06/11/2013 00:13:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_QuestionBank_Tbl_Module]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]'))
ALTER TABLE [dbo].[Tbl_QuestionBank]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_QuestionBank_Tbl_Module] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Tbl_QuestionModule] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_QuestionBank_Tbl_Module]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionBank]'))
ALTER TABLE [dbo].[Tbl_QuestionBank] CHECK CONSTRAINT [FK_Tbl_QuestionBank_Tbl_Module]
GO
/****** Object:  ForeignKey [FK_Tbl_Response_Tbl_QuestionBank]    Script Date: 06/11/2013 00:13:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Response_Tbl_QuestionBank]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]'))
ALTER TABLE [dbo].[Tbl_QuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Response_Tbl_QuestionBank] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Tbl_QuestionBank] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_Response_Tbl_QuestionBank]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_QuestionResponse]'))
ALTER TABLE [dbo].[Tbl_QuestionResponse] CHECK CONSTRAINT [FK_Tbl_Response_Tbl_QuestionBank]
GO
