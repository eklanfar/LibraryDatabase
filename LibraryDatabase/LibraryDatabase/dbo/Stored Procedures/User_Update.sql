-- =============================================
-- Author:		eklanfar
-- Create date: 29.08.2021.
-- Description:	Update user
-- =============================================
CREATE PROCEDURE [dbo].[User_Update]
    @id INT,
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @dateOfBirth DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
                          SELECT *
                          FROM   dbo.[User]
                          WHERE  id = @id AND
                                 deleted = 0
                      )
            RAISERROR('UserNotFound', 16, 1);

        UPDATE dbo.[User]
        SET    firstName = @firstName,
               lastName = @lastName,
               dateOfBirth = @dateOfBirth,
               mtime = CURRENT_TIMESTAMP
        WHERE  id = @id;

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