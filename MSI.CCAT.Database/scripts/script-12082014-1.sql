BEGIN TRY
	BEGIN TRANSACTION
	
		INSERT INTO [dbo].[Tbl_ComplaintStatus] ([Value],[Meaning]) VALUES ('BLANK','BLANK Complaint');
		INSERT INTO [dbo].[Tbl_ComplaintStatus] ([Value],[Meaning]) VALUES ('ACR','Awaiting Complaint Resolution');

		DECLARE @pageMenuId INT
		INSERT INTO [dbo].[pageMenu] VALUES(1,'Awaiting Complaint Resolution','Awaiting Complaint Resolution','Awaiting Complaint Resolution','','','/Compliance/Home/ComplianceReport?reportType=ACR','title=ACR',0,0,0,NULL);
		
		SELECT @pageMenuId = @@IDENTITY

		UPDATE [dbo].[pageMenuGroup] SET pageMenuIds = pageMenuIds + ',' + CAST(@pageMenuId as NVARCHAR(5)) WHERE Caption = 'Complaint Tracking';


	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		PRINT 'Rolling back transaction';
		ROLLBACK TRANSACTION;
	END
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;