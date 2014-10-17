IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[viewname]') AND type in (N'V'))
	DROP VIEW [dbo].[viewname]
GO



/****** Object:  Table [dbo].[tableName]    Script Date: 05/28/2013 22:43:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tableName]') AND type in (N'U'))
DROP TABLE [dbo].[tableName]
GO


/****** Object:  StoredProcedure [dbo].[spName]    Script Date: 05/28/2013 22:44:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spName]
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[constraintName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tableName] DROP CONSTRAINT [constraintName]
END

