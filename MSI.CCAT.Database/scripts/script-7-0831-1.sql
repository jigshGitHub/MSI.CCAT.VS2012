-- For Tbl_QuestionModule

ALTER TABLE [dbo].[Tbl_QuestionModule] ADD [Recommendation] [varchar](1000) NULL

-- New States table


CREATE TABLE [dbo].[Tbl_States](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [varchar](2) NULL,
 CONSTRAINT [PK_Tbl_States] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_States] ON
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (1, N'Virginia', N'VA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (2, N'Texas', N'TX')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (3, N'Ohio', N'OH')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (4, N'Maryland', N'MD')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (5, N'West Virginia', N'WV')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (6, N'New York', N'NY')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (7, N'Nevada', N'NV')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (8, N'California', N'CA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (9, N'Alabama', N'AL')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (10, N'Alaska', N'AK')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (11, N'Arizona', N'AZ')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (12, N'Arkansas', N'AS')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (13, N'Colorado', N'CO')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (14, N'Connecticut', N'CT')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (15, N'Delaware', N'DE')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (16, N'Florida', N'FL')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (17, N'Georgia', N'GA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (18, N'Hawaii', N'HW')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (19, N'Idaho', N'ID')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (20, N'Illinois', N'IL')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (21, N'Indiana', N'IN')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (22, N'Iowa', N'IA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (23, N'Kansas', N'KS')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (24, N'Kentuky', N'KY')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (25, N'Louisiana', N'LN')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (26, N'Maine', N'MN')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (27, N'Massachusetts', N'MA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (28, N'Michigan', N'MI')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (29, N'Minnesota', N'MN')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (30, N'Mississippi', N'MS')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (31, N'Missouri', N'MI')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (32, N'Montana', N'MO')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (33, N'Nebraska', N'NA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (34, N'New Hampshire', N'NH')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (35, N'New Jersey', N'NJ')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (36, N'New Mexico', N'NM')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (37, N'North Carolina', N'NC')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (38, N'North Dakota', N'ND')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (39, N'Oklahoma', N'OK')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (40, N'Oregon', N'OR')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (41, N'Pennsylvania', N'PA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (42, N'Rhode Island', N'RI')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (43, N'South Carolina', N'SC')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (44, N'South Dakota', N'SD')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (45, N'Tennessee', N'TN')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (46, N'Utah', N'UT')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (47, N'Vermont', N'VT')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (48, N'Washington', N'WA')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (49, N'Wisconsin', N'WI')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (50, N'Wyoming', N'WY')
INSERT [dbo].[Tbl_States] ([Id], [Name], [Value]) VALUES (51, N'District Of Columbia', N'DC')
SET IDENTITY_INSERT [dbo].[Tbl_States] OFF


-- Other lookup Tables

CREATE TABLE [dbo].[Tbl_OwnerResponses](
	[OwnerResponseId] [int] IDENTITY(1,1) NOT NULL,
	[Response] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_OwnerResponses] PRIMARY KEY CLUSTERED 
(
	[OwnerResponseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_OwnerResponses] ON
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (1, N'Closed ', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (2, N'Closed with explanation', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (3, N'Closed with monetary relief', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (4, N'Closed with non-monetary relief', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (5, N'Closed with relief', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (6, N'Closed without relief', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (7, N'In Progress', 1, CAST(0x0000A22A00000000 AS DateTime), N'System')
INSERT [dbo].[Tbl_OwnerResponses] ([OwnerResponseId], [Response], [IsActive], [CreatedOn], [CreatedBy]) VALUES (8, N'Untimely response', 1, CAST(0x0000A22A00000000 AS DateTime), N'Systesm')
SET IDENTITY_INSERT [dbo].[Tbl_OwnerResponses] OFF
/****** Object:  Table [dbo].[Tbl_FinalActionSteps]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_FinalActionSteps](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Step] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_FinalActionsteps] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_FinalActionSteps] ON
INSERT [dbo].[Tbl_FinalActionSteps] ([Id], [Step]) VALUES (1, N'Review with Owner')
INSERT [dbo].[Tbl_FinalActionSteps] ([Id], [Step]) VALUES (2, N'Submit another complaint')
INSERT [dbo].[Tbl_FinalActionSteps] ([Id], [Step]) VALUES (3, N'Close with disagreement noted')
SET IDENTITY_INSERT [dbo].[Tbl_FinalActionSteps] OFF
/****** Object:  Table [dbo].[Tbl_DebtorProducts]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_DebtorProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_DebtorProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_DebtorProducts] ON
INSERT [dbo].[Tbl_DebtorProducts] ([Id], [Product]) VALUES (1, N'Credit Card')
INSERT [dbo].[Tbl_DebtorProducts] ([Id], [Product]) VALUES (2, N'Automobile')
INSERT [dbo].[Tbl_DebtorProducts] ([Id], [Product]) VALUES (3, N'Mortgage')
SET IDENTITY_INSERT [dbo].[Tbl_DebtorProducts] OFF
/****** Object:  Table [dbo].[Tbl_DebtorContactTime]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_DebtorContactTime](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Time] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_DebtorContactTime] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_DebtorContactTime] ON
INSERT [dbo].[Tbl_DebtorContactTime] ([Id], [Time]) VALUES (1, N'Morning Only')
INSERT [dbo].[Tbl_DebtorContactTime] ([Id], [Time]) VALUES (2, N'Afternoon Only')
INSERT [dbo].[Tbl_DebtorContactTime] ([Id], [Time]) VALUES (3, N'Daytime Only')
INSERT [dbo].[Tbl_DebtorContactTime] ([Id], [Time]) VALUES (4, N'Evening Only')
INSERT [dbo].[Tbl_DebtorContactTime] ([Id], [Time]) VALUES (5, N'Weekend Only')
SET IDENTITY_INSERT [dbo].[Tbl_DebtorContactTime] OFF
/****** Object:  Table [dbo].[Tbl_DebtorContactMethods]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_DebtorContactMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Method] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_DebtorContactMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_DebtorContactMethods] ON
INSERT [dbo].[Tbl_DebtorContactMethods] ([Id], [Method]) VALUES (1, N'Home Phone')
INSERT [dbo].[Tbl_DebtorContactMethods] ([Id], [Method]) VALUES (2, N'Work Phone')
INSERT [dbo].[Tbl_DebtorContactMethods] ([Id], [Method]) VALUES (3, N'Cell Phone')
SET IDENTITY_INSERT [dbo].[Tbl_DebtorContactMethods] OFF
/****** Object:  Table [dbo].[Tbl_ComplaintReceivedBy]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_ComplaintReceivedBy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Media] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_ComplaintReceviedBy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_ComplaintReceivedBy] ON
INSERT [dbo].[Tbl_ComplaintReceivedBy] ([Id], [Media]) VALUES (1, N'Phone')
INSERT [dbo].[Tbl_ComplaintReceivedBy] ([Id], [Media]) VALUES (2, N'Fax')
INSERT [dbo].[Tbl_ComplaintReceivedBy] ([Id], [Media]) VALUES (3, N'Email')
INSERT [dbo].[Tbl_ComplaintReceivedBy] ([Id], [Media]) VALUES (4, N'Postal Mail')
SET IDENTITY_INSERT [dbo].[Tbl_ComplaintReceivedBy] OFF
/****** Object:  Table [dbo].[Tbl_ComplaintIssues]    Script Date: 08/30/2013 19:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_ComplaintIssues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MSI_ComplaintIssues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_ComplaintIssues] ON
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (1, N'Advertising & marketing')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (2, N'Application processing delay')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (3, N'APR or interest rate')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (4, N'Arbitration')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (5, N'Balance transfer')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (6, N'Balance transfer fee')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (7, N'Bankruptcy')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (8, N'Billing disputes')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (9, N'Billing statement')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (10, N'Closing/Cancelling account')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (11, N'Collection debt dispute')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (12, N'Collection practices')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (13, N'Credit card/debt protection')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (14, N'Credit determination')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (15, N'Credit reporting')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (16, N'Customer service')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (17, N'Customer relations')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (18, N'Delinquent account')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (19, N'Forbearance')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (20, N'Identity theft / fraud')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (21, N'Late fee')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (22, N'Other')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (23, N'Over limit fee')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (24, N'Payoff process')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (25, N'Privacy')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (26, N'Sale of account')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (27, N'Transaction issue')
INSERT [dbo].[Tbl_ComplaintIssues] ([Id], [Name]) VALUES (28, N'Unsolicited issuance of credit card')
SET IDENTITY_INSERT [dbo].[Tbl_ComplaintIssues] OFF

-- Add rows in the Roles table

   INSERT INTO [dbo].[aspnet_Roles] (ApplicationId,RoleName,LoweredRoleName) VALUES ('E828C431-2E74-4EB1-ACD3-C608526DF1CE','CollectionAgency','collectionagency')
   INSERT INTO [dbo].[aspnet_Roles] (ApplicationId,RoleName,LoweredRoleName) VALUES ('E828C431-2E74-4EB1-ACD3-C608526DF1CE','CollectionLawfirm','collectionlawfirm')
   INSERT INTO [dbo].[aspnet_Roles] (ApplicationId,RoleName,LoweredRoleName) VALUES ('E828C431-2E74-4EB1-ACD3-C608526DF1CE','CreditIssuer','creditissuer')
   INSERT INTO [dbo].[aspnet_Roles] (ApplicationId,RoleName,LoweredRoleName) VALUES ('E828C431-2E74-4EB1-ACD3-C608526DF1CE','DebtOwner','debtowner')
   INSERT INTO [dbo].[aspnet_Roles] (ApplicationId,RoleName,LoweredRoleName) VALUES ('E828C431-2E74-4EB1-ACD3-C608526DF1CE','Admin','admin')

-- Tbl_Owner

CREATE TABLE [dbo].[Tbl_Owner](
	[OwnerId] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NULL,
	[City] [varchar](50) NULL,
	[StateId] [int] NULL,
	[Name] [varchar](150) NULL,
	[Address] [varchar](150) NULL,
	[Zipcode] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[OwnerContact_LastName] [varchar](150) NULL,
	[OwnerContact_FirstName] [varchar](150) NULL,
	[OwnerContact_Email] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_Owner] PRIMARY KEY CLUSTERED 
(
	[OwnerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_Owner]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Owner_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Owner] CHECK CONSTRAINT [FK_Tbl_Owner_Tbl_States]
GO
   

-- Credit Issuer

CREATE TABLE [dbo].[Tbl_CreditIssuer](
	[CreditIssuerId] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NULL,
	[City] [varchar](50) NULL,
	[StateId] [int] NULL,
	[OwnerId] [int] NULL,
	[CreditorName] [varchar](50) NULL,
	[Address] [varchar](150) NULL,
	[Zipcode] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[Contact_LastName] [varchar](150) NULL,
	[Contact_FirstName] [varchar](150) NULL,
	[Contact_Email] [varchar](150) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_CreditIssuer] PRIMARY KEY CLUSTERED 
(
	[CreditIssuerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Tbl_Owner] ([OwnerId])
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer] CHECK CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_Owner]
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_CreditIssuer] CHECK CONSTRAINT [FK_Tbl_CreditIssuer_Tbl_States]
GO


-- Law firm


CREATE TABLE [dbo].[Tbl_LawFirm](
	[LawFirmId] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NULL,
	[City] [varchar](50) NULL,
	[StateId] [int] NULL,
	[OwnerId] [int] NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](150) NULL,
	[Zipcode] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[Contact_LastName] [varchar](150) NULL,
	[Contact_FirstName] [varchar](150) NULL,
	[Contact_Email] [varchar](150) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_LawFirm] PRIMARY KEY CLUSTERED 
(
	[LawFirmId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_LawFirm]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_LawFirm_Tbl_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Tbl_Owner] ([OwnerId])
GO

ALTER TABLE [dbo].[Tbl_LawFirm] CHECK CONSTRAINT [FK_Tbl_LawFirm_Tbl_Owner]
GO

ALTER TABLE [dbo].[Tbl_LawFirm]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_LawFirm_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_LawFirm] CHECK CONSTRAINT [FK_Tbl_LawFirm_Tbl_States]
GO


-- For Agency

CREATE TABLE [dbo].[Tbl_Agency](
	[AgencyId] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NULL,
	[City] [varchar](50) NULL,
	[StateId] [int] NULL,
	[OwnerId] [int] NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](150) NULL,
	[Zipcode] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[AgencyContact_LastName] [varchar](150) NULL,
	[AgencyContact_FirstName] [varchar](150) NULL,
	[AgencyContact_Email] [varchar](150) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_Agency] PRIMARY KEY CLUSTERED 
(
	[AgencyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_Agency]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Agency_Tbl_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Tbl_Owner] ([OwnerId])
GO

ALTER TABLE [dbo].[Tbl_Agency] CHECK CONSTRAINT [FK_Tbl_Agency_Tbl_Owner]
GO

ALTER TABLE [dbo].[Tbl_Agency]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Agency_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Agency] CHECK CONSTRAINT [FK_Tbl_Agency_Tbl_States]
GO


-- Account

CREATE TABLE [dbo].[Tbl_Account](
	[AccountNumber] [varchar](25) NOT NULL,
	[CreditorName] [varchar](150) NULL,
	[AccountOriginal] [varchar](25) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Address] [varchar](150) NULL,
	[Zip] [varchar](50) NULL,
	[HomePhone] [varchar](50) NULL,
	[WorkPhone] [varchar](50) NULL,
	[MobilePhone] [varchar](50) NULL,
	[LastFourSSN] [varchar](50) NULL,
	[DebtPurchaseBalance] [money] NULL,
	[DebtCurrentBalance] [money] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[StateId] [int] NULL,
	[AgencyId] [int] NULL,
	[OwnerId] [int] NULL,
	[LawFirmId] [int] NULL,
	[CreditIssuerId] [int] NULL,
 CONSTRAINT [PK_Tbl_Account12] PRIMARY KEY CLUSTERED 
(
	[AccountNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_Agency] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Tbl_Agency] ([AgencyId])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_Agency]
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_CreditIssuer] FOREIGN KEY([CreditIssuerId])
REFERENCES [dbo].[Tbl_CreditIssuer] ([CreditIssuerId])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_CreditIssuer]
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_LawFirm] FOREIGN KEY([LawFirmId])
REFERENCES [dbo].[Tbl_LawFirm] ([LawFirmId])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_LawFirm]
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Tbl_Owner] ([OwnerId])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_Owner]
GO

ALTER TABLE [dbo].[Tbl_Account]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Account12_Tbl_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_States] ([Id])
GO

ALTER TABLE [dbo].[Tbl_Account] CHECK CONSTRAINT [FK_Tbl_Account12_Tbl_States]
GO


-- Complaint Main


CREATE TABLE [dbo].[Tbl_ComplaintMain](
	[ComplaintId] [nvarchar](50) NOT NULL,
	[ComplaintDate] [datetime] NULL,
	[ReceivedByMethodId] [int] NULL,
	[IssuesId] [int] NULL,
	[ComplaintNotes] [varchar](max) NULL,
	[ComplaintDocument] [varchar](max) NULL,
	[ComplaintSubmittedToAgencyYN] [bit] NULL,
	[ComplaintSubmittedToAgencyDate] [datetime] NULL,
	[MoreInfoReqdFromDebtorYN] [bit] NULL,
	[MoreInfoRequestedDate] [datetime] NULL,
	[MoreInfoRequested] [varchar](max) NULL,
	[MoreInfoReceivedFromDebtorYN] [bit] NULL,
	[MoreInfoReceivedDate] [datetime] NULL,
	[MoreInfoReceived] [varchar](max) NULL,
	[ComplaintSubmittedToOwnerYN] [bit] NULL,
	[ComplaintSubmittedDate] [datetime] NULL,
	[TimeToSubmitDays] [int] NULL,
	[DebtOwnerProcessDocument] [varchar](max) NULL,
	[MoreInfoFromAgencyYN] [bit] NULL,
	[MoreInfoFromAgencyRequestedDate] [datetime] NULL,
	[MoreInfoFromAgencyRequested] [varchar](max) NULL,
	[MoreInfoFromAgencyReceivedYN] [bit] NULL,
	[MoreInfoFromAgencyReceivedDate] [datetime] NULL,
	[MoreInfoFromAgencyReceived] [varchar](max) NULL,
	[OwnerResponseId] [int] NULL,
	[OwnerResponseDate] [datetime] NULL,
	[OwnerResponseDays] [int] NULL,
	[AgencyResponseToDebtorDate] [datetime] NULL,
	[TotalResponseTimeDays] [int] NULL,
	[DebtorAgreeYN] [bit] NULL,
	[NeedFurtherActionYN] [bit] NULL,
	[FinalActionStepId] [int] NULL,
	[DebtorIdentityVerifiedYN] [bit] NULL,
	[DebtorContactMethodId] [int] NULL,
	[DebtorContactTimeId] [int] NULL,
	[DebtorProductId] [int] NULL,
	[DisputeDebtYN] [bit] NULL,
	[DisputeDebtAmountYN] [bit] NULL,
	[DisputeDebtDueDateYN] [bit] NULL,
	[AccountNumber] [varchar](25) NULL,
 CONSTRAINT [PK_Tbl_ComplaintMain] PRIMARY KEY CLUSTERED 
(
	[ComplaintId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintIssues] FOREIGN KEY([IssuesId])
REFERENCES [dbo].[Tbl_ComplaintIssues] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintIssues]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintReceivedBy] FOREIGN KEY([ReceivedByMethodId])
REFERENCES [dbo].[Tbl_ComplaintReceivedBy] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintReceivedBy]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorContactMethods] FOREIGN KEY([DebtorContactMethodId])
REFERENCES [dbo].[Tbl_DebtorContactMethods] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorContactMethods]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorContactTime] FOREIGN KEY([DebtorContactTimeId])
REFERENCES [dbo].[Tbl_DebtorContactTime] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorContactTime]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorProducts] FOREIGN KEY([DebtorProductId])
REFERENCES [dbo].[Tbl_DebtorProducts] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_DebtorProducts]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_FinalActionSteps] FOREIGN KEY([FinalActionStepId])
REFERENCES [dbo].[Tbl_FinalActionSteps] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_FinalActionSteps]
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_OwnerResponses] FOREIGN KEY([OwnerResponseId])
REFERENCES [dbo].[Tbl_OwnerResponses] ([OwnerResponseId])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_OwnerResponses]
GO


