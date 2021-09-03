-- =============================================
-- Author:		eklanfar
-- Create date: 29.08.2021.
-- Description:	Create new user
-- =============================================
CREATE PROCEDURE [dbo].[User_Create]
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @dateOfBirth DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        INSERT INTO dbo.[User] (
                                   firstName,
                                   lastName,
                                   dateOfBirth,
                                   deleted,
                                   ctime,
                                   mtime
                               )
        VALUES (@firstName,        -- firstName - nvarchar(50)
                @lastName,         -- lastName - nvarchar(50)
                @dateOfBirth,      -- dateOfBirth - date
                0,                 -- deleted - bit
                CURRENT_TIMESTAMP, -- ctime - datetime
                CURRENT_TIMESTAMP  -- mtime - datetime
            );

        -- get id of newly inserted user
        DECLARE @userId INT = SCOPE_IDENTITY();

        SELECT id,
               firstName,
               lastName,
               dateOfBirth
        FROM   dbo.[User]
        WHERE  id = @userId;

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