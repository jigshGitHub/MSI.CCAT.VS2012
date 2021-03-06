/****** Object:  Table [dbo].[TBL_CHART]    Script Date: 08/06/2013 05:58:33 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_EnableRotation]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_EnableRotation]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_ShowLegend]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_ShowLegend]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_ShowLabels]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_ShowLabels]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_Active]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_LastUpdatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_LastUpdatedDate]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TBL_CHART_LastCreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TBL_CHART] DROP CONSTRAINT [DF_TBL_CHART_LastCreatedDate]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TBL_CHART]') AND type in (N'U'))
DROP TABLE [dbo].[TBL_CHART]
GO
/****** Object:  Table [dbo].[TBL_CHART]    Script Date: 08/06/2013 05:58:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TBL_CHART]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TBL_CHART](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeOfChart] [varchar](100) NOT NULL,
	[Caption] [varchar](500) NOT NULL,
	[SWFile] [varchar](500) NOT NULL,
	[ChartID] [varchar](500) NOT NULL,
	[NumberSuffix] [char](1) NULL,
	[SNumberSuffix] [char](1) NULL,
	[XaxisName] [varchar](500) NULL,
	[YaxisName] [varchar](500) NULL,
	[CanvasBgColor] [char](6) NULL,
	[BgColor] [char](6) NULL,
	[CanvasBgAlpha] [varchar](10) NULL,
	[BgAlpha] [varchar](10) NULL,
	[PieRadius] [varchar](10) NULL,
	[EnableRotation] [char](1) NULL CONSTRAINT [DF_TBL_CHART_EnableRotation]  DEFAULT ((0)),
	[ShowLegend] [char](1) NULL CONSTRAINT [DF_TBL_CHART_ShowLegend]  DEFAULT ((0)),
	[ShowLabels] [char](1) NULL CONSTRAINT [DF_TBL_CHART_ShowLabels]  DEFAULT ((0)),
	[PlotGradientColor] [char](6) NULL,
	[DrillLevelChartIDs] [varchar](max) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_TBL_CHART_Active]  DEFAULT ((1)),
	[LastUpdatedDate] [datetime] NULL CONSTRAINT [DF_TBL_CHART_LastUpdatedDate]  DEFAULT (getdate()),
	[LastCreatedDate] [datetime] NULL CONSTRAINT [DF_TBL_CHART_LastCreatedDate]  DEFAULT (getdate()),
	[LastUpdatedBy] [uniqueidentifier] NULL,
	[LastCreatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TBL_CHART] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_CHART] ON
INSERT [dbo].[TBL_CHART] ([Id], [TypeOfChart], [Caption], [SWFile], [ChartID], [NumberSuffix], [SNumberSuffix], [XaxisName], [YaxisName], [CanvasBgColor], [BgColor], [CanvasBgAlpha], [BgAlpha], [PieRadius], [EnableRotation], [ShowLegend], [ShowLabels], [PlotGradientColor], [DrillLevelChartIDs], [IsActive], [LastUpdatedDate], [LastCreatedDate], [LastUpdatedBy], [LastCreatedBy]) VALUES 
(2, N'Chart', N'Assessment Results', N'MSColumn3D.swf', N'AssessmentResults', NULL, NULL, NULL, NULL, N'FFFFFF', N'FFFFFF', N'100', N'100', NULL, N'0', N'0', N'0', NULL, NULL, 1, CAST(0x0000A10400DA8E80 AS DateTime), CAST(0x0000A10400DA8E80 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[TBL_CHART] OFF
