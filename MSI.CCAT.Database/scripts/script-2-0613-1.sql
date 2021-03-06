USE [CCATDB]
GO
/****** Object:  Table [dbo].[pageMenu]    Script Date: 06/12/2013 16:41:03 ******/
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isNewWindow]
GO
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_isModal]
GO
ALTER TABLE [dbo].[pageMenu] DROP CONSTRAINT [DF_pageMenu_inIFRAME]
GO
DROP TABLE [dbo].[pageMenu]
GO
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 06/12/2013 16:41:03 ******/
DROP TABLE [dbo].[pageMenuGroup]
GO
/****** Object:  Table [dbo].[pageMenuGroup]    Script Date: 06/12/2013 16:41:03 ******/
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
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES (4, 1, N'Compliance Tracking', N'Compliance Tracking', NULL, NULL, NULL, N'22,23,24,25,26,27,28,29,31')
SET IDENTITY_INSERT [dbo].[pageMenuGroup] OFF
/****** Object:  Table [dbo].[pageMenu]    Script Date: 06/12/2013 16:41:03 ******/
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
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (1, 1, N'Dashboard Overview', N'Dashboard', N'Overview', NULL, NULL, N'/Dashboard/Home/Overview', NULL, 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (2, 1, N'Entity Business Model', N'Module 1: Entity Business Model', N'Module 1:Entity Business Model', NULL, NULL, N'/Assessment/Home?moduleId=1', N'title=Module1', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (3, 1, N'Communications in Connection with Debt Collection', N'Module 2: Communications with Debt Collection', N'Communications in Connection with Debt Collection', NULL, NULL, N'/Assessment/Home?moduleId=2', N'title=Module2', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (4, 1, N'Information Sharing & Privacy', N'Module 3: Information Sharing & Privacy', N'Fundraising Overview (#2)', NULL, NULL, N'/Assessment/Home?moduleId=3', N'title=Module3', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (6, 1, N'Consumer Companies & Resolutions', N'Module 4: Consumer Companies & Resolutions', N'Import', NULL, NULL, N'/Assessment/Home?moduleId=4', N'title=Module4', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (7, 1, N'Equal Credit Opportunity Act', N'Module 5: Equal Credit Opportunity Act', N'Merge', NULL, NULL, N'/Assessment/Home?moduleId=5', N'title=Module5', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (8, 1, N'Litigation Practices & Repossession', N'MOdule 6: Litigation Practices & Repossession', N'Tasks/Calls', NULL, NULL, N'/Assessment/Home?moduleId=6', N'title=Module6', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (9, 1, N'Payment Processing and Account Maintenance', N'Module 7: Payment Processing & Account Maintenance', N'Thank You', NULL, NULL, N'/Assessment/Home?moduleId=7', N'title=Module7', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (10, 1, N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', N'Audit & Risk Mitigation', NULL, NULL, N'/Audit/ManageRisk', N'title=ManageRisk', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (22, 1, N'Tracking', N'Compliance Dashboard', N'Compliance Dashboard', NULL, NULL, N'/Compliance/Home', N'title=Tracking', 0, 0, 0, N'')
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (23, 1, N'Create Complaint', N'Create Complaint For Agency Action', N'Create Complaint', NULL, NULL, N'/Compliance/Home/Create', N'title=CreateComplaint', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (24, 1, N'New Complaint Requiring Action', N'New Complaint Requiring Action', N'New Complaint Requiring Action', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=NCRA', N'title=NCRA', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (25, 1, N'New Complaint in Progress', N'New Complaint in Progress', N'New Complaint in Progress', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=NCP', N'titile=NCP', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (26, 1, N'Awaiting Additional Information', N'Awaiting Additional Information', N'Awaiting Additional Information', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=AAI', N'title=AAI', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (27, 1, N'Submitted for Owner Action', N'Submitted for Owner Action', N'Submitted for Owner Action', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=SOA', N'title=SOA', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (28, 1, N'Owner Response in Progress', N'Owner Response in Progress', N'Owner Response in Progress', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=ORP', N'title=ORP', 0, 0, 0, NULL)
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES (31, 1, N'Resolved Complaints', N'Resolved Complaints', N'Resolved Complaints', NULL, NULL, N'/Compliance/Home/ComplianceReport?reportType=RC', N'title=RC', 0, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[pageMenu] OFF

GO

USE [dbPCS]
GO
/****** Object:  StoredProcedure [dbo].[spName]    Script Date: 05/28/2013 22:44:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[get_pagedDataSet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[get_pagedDataSet]
GO

Create  PROCEDURE [dbo].[get_pagedDataSet](
	@SQL VARCHAR(MAX),		-- Required
	@OrderBy VARCHAR(MAX),  -- Required (eg. 'LGIFT DESC, LNAME, FNAME')
	@pageSize INT,    
	@pageNo INT) 
AS
BEGIN	
	DECLARE	
		@pageTop INT,
		@pageBottom INT       
	   
	SET @pageNo = @pageNo - 1    
	SET @pageTop = (@pageNo * @pageSize) + 1  
	SET @pageBottom = (@pageNo * @pageSize) + @pageSize
	     
	DECLARE @Q VARCHAR(MAX)
	
	SET @SQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS rowNo, _MYQ.* FROM ('+@SQL+') _MYQ'
	SET @Q = '
		WITH CTE_pageResult AS (' + CHAR(13) + @SQL + CHAR(13) + ')'
		+'
		SELECT
			(SELECT COUNT(*) FROM CTE_pageResult) AS count_, 
			 * 
			 FROM CTE_pageResult
			 WHERE rowNo BETWEEN ' + CAST(@pageTop AS VARCHAR(10)) + ' AND ' + CAST(@pageBottom AS VARCHAR(10))
	--PRINT @Q
	EXEC (@Q)	
END