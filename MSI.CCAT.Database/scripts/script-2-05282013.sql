USE [CCATDB]
GO
/****** Object:  StoredProcedure [dbo].[MSI_GetMenuDetails]    Script Date: 05/28/2013 16:54:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSI_GetMenuDetails]') AND type in (N'U'))
DROP PROCEDURE [dbo].[MSI_GetMenuDetails]
GO
/****** Object:  Table [dbo].[pageMenu]    Script Date: 05/28/2013 16:54:07 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[constraintName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isNewWindow]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[constraintName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isModal]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[constraintName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_inIFRAME]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenu]') AND type in (N'U'))
DROP TABLE [dbo].[pageMenu]
GO
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 05/28/2013 16:54:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenuGroup]') AND type in (N'U'))
DROP TABLE [dbo].[pageMenuGroup]
GO
/****** Object:  Table [dbo].[module]    Script Date: 05/28/2013 16:54:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[module]') AND type in (N'U'))
DROP TABLE [dbo].[module]
GO
/****** Object:  Table [dbo].[module]    Script Date: 05/28/2013 16:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[module](
	[moduleId] [int] IDENTITY(1,1) NOT NULL,
	[pageMenuGroups] [nvarchar](1000) NULL,
 CONSTRAINT [PK_module] PRIMARY KEY NONCLUSTERED 
(
	[moduleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[module] ON
INSERT [dbo].[module] ([moduleId], [pageMenuGroups]) VALUES (2, N'1,2,4')
INSERT [dbo].[module] ([moduleId], [pageMenuGroups]) VALUES (3, N'3')
SET IDENTITY_INSERT [dbo].[module] OFF
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 05/28/2013 16:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[pageMenuGroup] ON
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (1, 1, N'Dashboard Overview', N'Dashboard', NULL, NULL, NULL, N'1')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (2, 1, N'Compliance Self-Assessment', N'Self Assessment', NULL, NULL, NULL, N'2,3,4,6,7,8,9')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (3, 1, N'Audit and Risk Mitigation', N'Audit & Risk Mitigation', NULL, NULL, NULL, N'10')
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (4, 1, N'Compliance Tracking', N'Compliance Tracking', NULL, NULL, NULL, N'22')
SET IDENTITY_INSERT [dbo].[pageMenuGroup] OFF
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pageMenu]') AND type in (N'U'))
DROP TABLE [dbo].[pageMenu]
GO
/****** Object:  Table [dbo].[pageMenu]    Script Date: 05/28/2013 16:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[pageMenu] ON
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (1, 1, N'Dashboard Overview', N'Dashboard', N'Overview', NULL, NULL, N'/Dashboard/Overview', NULL, 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (2, 1, N'Entity Business Model', N'Module 1: Entity Business Model', N'Module 1:Entity Business Model', NULL, NULL, N'/Question/Module1', N'title=Module1', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (3, 1, N'Communications in Connection with Debt Collection', N'Module 2: Communications with Debt Collection', N'Communications in Connection with Debt Collection', NULL, NULL, N'/Question/Module2', N'title=Module2', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (4, 1, N'Information Sharing & Privacy', N'Module 3: Information Sharing & Privacy', N'Fundraising Overview (#2)', NULL, NULL, N'/Question/Module3', N'title=Module3', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (6, 1, N'Consumer Companies & Resolutions', N'Module 4: Consumer Companies & Resolutions', N'Import', NULL, NULL, N'/Question/Module4', N'title=Module4', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (7, 1, N'Equal Credit Opportunity Act', N'Module 5: Equal Credit Opportunity Act', N'Merge', NULL, NULL, N'/Question/Module5', N'title=Module5', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (8, 1, N'Litigation Practices & Repossession', N'MOdule 6: Litigation Practices & Repossession', N'Tasks/Calls', NULL, NULL, N'/Question/Module6', N'title=Module6', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (9, 1, N'Payment Processing and Account Maintenance', N'Module 7: Payment Processing & Account Maintenance', N'Thank You', NULL, NULL, N'/Question/Module7', N'title=Module7', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (10, 1, N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', NULL, NULL, N'/Audit/ManageRisk', N'title=ManageRisk', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (22, 1, N'Tracking', N'Compliance Tracking', N'Compliance Tracking', NULL, NULL, N'/Compliance/Tracking', N'title=Tracking', 0, 0, 0, N'')
SET IDENTITY_INSERT [dbo].[pageMenu] OFF
/****** Object:  StoredProcedure [dbo].[spName]    Script Date: 05/28/2013 22:44:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSI_GetMenuDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[MSI_GetMenuDetails]
GO
/****** Object:  StoredProcedure [dbo].[MSI_GetMenuDetails]    Script Date: 05/28/2013 16:54:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[MSI_GetMenuDetails]
  @appId int
AS
  
  
SELECT	DISTINCT
		W.pageMenuGroupId, M.pageMenuId, 
		CASE WHEN PATINDEX(CAST(M.pageMenuId AS VARCHAR(10))+',%', W.pageMenuIds)>0 
				THEN PATINDEX(CAST(M.pageMenuId AS VARCHAR(10))+',%', W.pageMenuIds)
			 WHEN PATINDEX('%'+CAST(M.pageMenuId AS VARCHAR(10)), W.pageMenuIds)>0 
				THEN PATINDEX('%'+CAST(M.pageMenuId AS VARCHAR(10)), W.pageMenuIds)				
			 WHEN PATINDEX('%,'+CAST(M.pageMenuId AS VARCHAR(10))+',%', W.pageMenuIds)>0 
				THEN PATINDEX('%,'+CAST(M.pageMenuId AS VARCHAR(10))+',%', W.pageMenuIds)
			 ELSE 99 END AS listOrder
	FROM	pageMenu M
			INNER JOIN pageMenuGroup W ON 
					W.pageMenuIds LIKE CAST(M.pageMenuId AS VARCHAR(10))		-- Itself
					OR W.pageMenuIds LIKE CAST(M.pageMenuId AS VARCHAR(10))+',%'		-- If a starting element
					OR W.pageMenuIds LIKE '%,'+CAST(M.pageMenuId AS VARCHAR(10))		-- If an ending element
					OR W.pageMenuIds LIKE '%,'+CAST(M.pageMenuId AS VARCHAR(10))+',%'	-- If a middle element

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
GO
