-- =============================================
-- Author:		eklanfar
-- Create date: 30.08.2021.
-- Description:	Install default activity statuses
-- =============================================
CREATE PROCEDURE [setup].[Application_Install_ActivityStatus]
    @confirm INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @confirm <> 1
            RAISERROR('Not confirmed! Confirmed it with 1', 16, 1);

        INSERT INTO dbo.ActivityStatus (
                                           id,
                                           [status]
                                       )
        VALUES (1,      -- id - tinyint 
                N'LOAN' -- status - nvarchar(50)
            );

        INSERT INTO dbo.ActivityStatus (
                                           id,
                                           [status]
                                       )
        VALUES (2,        -- id - tinyint 
                N'RETURN' -- status - nvarchar(50)
            );

    END TRY
    BEGIN CATCH

        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);

    END CATCH;
END;