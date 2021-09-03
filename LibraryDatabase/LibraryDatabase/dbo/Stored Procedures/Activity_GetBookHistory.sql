-- =============================================
-- Author:		eklanfar
-- Create date: 30.08.2021.
-- Description:	Get book loan history for it's copies
-- =============================================
CREATE PROCEDURE [dbo].[Activity_GetBookHistory]
    @bookId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS (
                          SELECT *
                          FROM   dbo.Book
                          WHERE  id = @bookId AND
                                 deleted = 0
                      )
            RAISERROR('BookNotFound', 16, 1);

        SELECT     u.firstName,
                   u.lastName,
                   a.bookCopyId,
                   a.dateFrom,
                   a.returnDate,
                   a.expirationDate
        FROM       dbo.Activity a
        INNER JOIN dbo.BookCopy bc ON bc.id = a.bookCopyId AND
                                      bc.bookId = @bookId
        INNER JOIN dbo.[User] u ON u.id = a.userId;

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