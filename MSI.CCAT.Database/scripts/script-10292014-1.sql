
BEGIN TRY
	BEGIN TRANSACTION

		
	EXEC dbo.aspnet_Roles_CreateRole'CCATWeb','AgencyCollector';
	
	EXEC dbo.aspnet_Roles_CreateRole 'CCATWeb','AgencyManager';
	
	EXEC dbo.aspnet_Roles_CreateRole 'CCATWeb','AgencyCompliance';
	
	ALTER TABLE dbo.aspnet_Users ADD ManagerId uniqueidentifier NULL;
		
	ALTER TABLE dbo.aspnet_Users  WITH CHECK ADD FOREIGN KEY(ManagerId)
	REFERENCES [dbo].[aspnet_Users] ([UserId]);
	
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


