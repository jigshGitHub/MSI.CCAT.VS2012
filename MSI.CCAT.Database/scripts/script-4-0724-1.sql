
/****** Object:  StoredProcedure [dbo].[sp_IntegrateNewQuestions]    Script Date: 07/24/2013 16:29:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_IntegrateNewQuestions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_IntegrateNewQuestions]
GO


/****** Object:  StoredProcedure [dbo].[sp_IntegrateNewQuestions]    Script Date: 07/24/2013 16:29:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--exec [sp_IntegrateNewQuestions] 50, 1;
CREATE Procedure [dbo].[sp_IntegrateNewQuestions](
	@questionId int, @moduleId int
)
AS
BEGIN
	declare @createdBy uniqueidentifier

	--SELECT qb.ModuleId, qr.[CreatedBy]
	--FROM [dbo].[Tbl_QuestionResponse] qr
	--INNER JOIN [dbo].[Tbl_QuestionBank] qb on qb.id = qr.QuestionId 
	--Group by qb.ModuleId, qr.CreatedBy 
	  
	DECLARE data CURSOR FOR
	SELECT qb.ModuleId, qr.[CreatedBy]
	FROM [dbo].[Tbl_QuestionResponse] qr
	INNER JOIN [dbo].[Tbl_QuestionBank] qb on qb.id = qr.QuestionId WHERE qb.ModuleId = @moduleId
	Group by qb.ModuleId, qr.CreatedBy 
	OPEN data;

	FETCH NEXT FROM data
	INTO @moduleId, @createdBy

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--print @createdBy
		
		
		INSERT [dbo].[Tbl_QuestionResponse] ( [QuestionId], [CreatedOn], [CreatedBy]) 
		VALUES (@questionId, GETDATE(),@createdBy);

		FETCH NEXT FROM data
		INTO @moduleId, @createdBy
	END
		
	CLOSE data;
	DEALLOCATE data;

	Return 0;
END

GO

