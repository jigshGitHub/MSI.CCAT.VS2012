/****** Object:  Table [dbo].[Tbl_ComplaintStatus]    Script Date: 09/05/2013 15:25:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintStatus]') AND type in (N'U'))
DROP TABLE [dbo].[Tbl_ComplaintStatus]
GO

/****** Object:  Table [dbo].[Tbl_ComplaintStatus]    Script Date: 09/05/2013 15:25:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tbl_ComplaintStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nchar](10) NOT NULL,
	[Meaning] [nchar](100) NULL,
 CONSTRAINT [PK_Tbl_ComplaintStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('NCRA','New Complaint Requiring Action');
GO
INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('NCIP','New Complaint In Progress');
GO
INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('AAI','Awaiting Additional Information');
GO
INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('SFOA','Submitted for Owner Action');
GO
INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('ORIP','Owner Response in Progress');
GO
INSERT INTO [dbo].[Tbl_ComplaintStatus]([Value],[Meaning]) VALUES('RC','Resolved Complaint');
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tbl_ComplaintMain_Tbl_ComplaintStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintStatus]
GO

Alter Table [dbo].[Tbl_ComplaintMain] Add [ComplaintStatusId] INT NULL;
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintStatus] FOREIGN KEY([ComplaintStatusId])
REFERENCES [dbo].[Tbl_ComplaintStatus] ([Id])
GO

ALTER TABLE [dbo].[Tbl_ComplaintMain] CHECK CONSTRAINT [FK_Tbl_ComplaintMain_Tbl_ComplaintStatus]
GO

Alter Table TBL_ComplaintMain Add [IsViewedByOwner] Bit NULL;
GO
Alter Table TBL_ComplaintMain Add [IsViewedByAgency] Bit NULL;
GO
Alter Table TBL_ComplaintMain Add [CreatedBy] UniqueIdentifier NULL;
GO
Alter Table TBL_ComplaintMain Add [UpdatedBy] UniqueIdentifier NULL;
GO
Alter Table TBL_ComplaintMain Add [CreatedDateTime] DateTime NULL;
GO
Alter Table TBL_ComplaintMain Add [UpdatedDateTime] DateTime NULL;
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[IsActive_Def]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tbl_ComplaintMain]'))
ALTER TABLE [dbo].[Tbl_ComplaintMain] DROP CONSTRAINT [IsActive_Def]
GO

Alter Table TBL_ComplaintMain Add [IsActive] Bit Null;
GO

ALTER TABLE TBL_ComplaintMain
ADD CONSTRAINT [IsActive_Def]
DEFAULT 1 FOR [IsActive] ;
GO

/****** Object:  StoredProcedure [dbo].[get_pagedDataSet]    Script Date: 09/06/2013 12:57:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[get_pagedDataSet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[get_pagedDataSet]
GO

/****** Object:  StoredProcedure [dbo].[get_pagedDataSet]    Script Date: 09/06/2013 12:57:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
GO


