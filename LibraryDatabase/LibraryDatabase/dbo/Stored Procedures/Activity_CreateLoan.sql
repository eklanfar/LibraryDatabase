-- =============================================
-- Author:		eklanfar
-- Create date: 29.08.2021.
-- Description:	Create loan activity for specified user and book copies
-- =============================================
CREATE PROCEDURE [dbo].[Activity_CreateLoan]
    @userId INT,
    @bookCopiesJson NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        DECLARE @id INT,
                @blocked BIT;

        -- temp table for book copies
        DECLARE @bookCopiesTable TABLE
        (
            bookCopyId BIGINT,
            dateFrom DATETIME,
            expirationDate DATETIME
        );


        SELECT @id = id
        FROM   dbo.[User]
        WHERE  id = @userId AND
               deleted = 0;

        IF @id IS NULL
            RAISERROR('UserNotFound', 16, 1);

        -- fill table with chosen book copies
        INSERT INTO @bookCopiesTable (
                                         bookCopyId,
                                         dateFrom,
                                         expirationDate
                                     )
        SELECT bct.bookCopyId,
               bct.dateFrom,
               bct.expirationDate
        FROM
               OPENJSON(@bookCopiesJson)
               WITH (
                        bookCopyId BIGINT,
                        dateFrom DATETIME,
                        expirationDate DATETIME
                    ) AS bct;

        IF NOT EXISTS (
                          SELECT     *
                          FROM       dbo.BookCopy bc
                          INNER JOIN @bookCopiesTable bct ON bct.bookCopyId = bc.id AND
                                                             bc.deleted = 0
                      )
            RAISERROR('OneOfBookCopiesNotFound', 16, 1);

        IF EXISTS (
                      SELECT     *
                      FROM       dbo.Activity a
                      INNER JOIN @bookCopiesTable bct ON bct.bookCopyId = a.bookCopyId AND
                                                         a.statusId =                  (
                                                                                           SELECT LOAN
                                                                                           FROM   dbo.enum_ActivityStatus
                                                                                       )
                  )
            RAISERROR('OneOfBookCopiesAlreadyLoaned', 16, 1);

        INSERT INTO dbo.Activity (
                                     userId,
                                     bookCopyId,
                                     statusId,
                                     dateFrom,
                                     returnDate,
                                     expirationDate
                                 )
        SELECT @userId,           -- userId - int
               bct.bookCopyId,    -- bookCopyId - bigint
               (
                   SELECT LOAN
                   FROM   dbo.enum_ActivityStatus
               ),                 -- statusId - tinyint
               bct.dateFrom,      -- dateFrom - datetime
               NULL,              -- returnDate - datetime
               bct.expirationDate -- expirationDate - datetime
        FROM   @bookCopiesTable bct;

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