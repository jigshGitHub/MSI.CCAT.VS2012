-- Create New Table

CREATE TABLE [dbo].[Tbl_QuestionDeficient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserResponseValue] [varchar](500) NOT NULL UNIQUE NONCLUSTERED,
	[IsDeficient] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_QuestionDeficient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_QuestionDeficient] ON
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (1, '1', 1, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (2, '2', 1, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (3, '3', 1, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (4, '4', 0, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (5, '5', 0, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
INSERT [dbo].[Tbl_QuestionDeficient] ([Id], [UserResponseValue], [IsDeficient], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy]) VALUES (6, 'N/A', 0, CAST(0x0000A20F00000000 AS DateTime), N'System', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tbl_QuestionDeficient] OFF



-- Add two new columns in Existing table

ALTER TABLE Tbl_QuestionModule ADD [IndustryAverage] [varchar](10) NULL
GO
ALTER TABLE Tbl_QuestionModule ADD [QuetionQuantity] int NULL
GO

-- set IndustryAverage Value for each Module

Update Tbl_QuestionModule Set IndustryAverage = '75%', QuetionQuantity = 59 where ID = 1
Update Tbl_QuestionModule Set IndustryAverage = '80%', QuetionQuantity = 45 where ID = 2
Update Tbl_QuestionModule Set IndustryAverage = '75%', QuetionQuantity = 49 where ID = 3
Update Tbl_QuestionModule Set IndustryAverage = '70%', QuetionQuantity = 49 where ID = 4
Update Tbl_QuestionModule Set IndustryAverage = '75%', QuetionQuantity = 14 where ID = 5
Update Tbl_QuestionModule Set IndustryAverage = '70%', QuetionQuantity = 7 where ID = 6
Update Tbl_QuestionModule Set IndustryAverage = '75%', QuetionQuantity = 17 where ID = 7



