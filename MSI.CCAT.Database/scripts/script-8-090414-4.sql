
/****** Object:  Table [dbo].[Tbl_ComplaintType]    Script Date: 09/12/2014 22:23:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintType]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_ComplaintType]
GO


CREATE TABLE [dbo].[Tbl_ComplaintType](
	[Id] [int] NOT NULL IDENTITY(1,1),
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tbl_ComplaintType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE Tbl_ComplaintMain ADD ComplaintTypeID INT;


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_ComplaintMain_Tbl_ComplaintType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintType]
GO


ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintType] FOREIGN KEY([ComplaintTypeID])
REFERENCES [dbo].[Tbl_ComplaintType] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintType]
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('ADL Prelit');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('AG');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('BBB');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('CFPB');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('Filed Lawsuit');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('NYDOCA');
GO

INSERT INTO [CCATDB].[dbo].[Tbl_ComplaintType]([Name])  VALUES ('OFR');
GO