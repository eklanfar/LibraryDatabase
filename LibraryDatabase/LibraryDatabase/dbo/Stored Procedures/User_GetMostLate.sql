-- =============================================
-- Author:		eklanfar
-- Create date: 30.08.2021.
-- Description:	Get user that has the most late days with a single loan of a book copy
-- =============================================
CREATE PROCEDURE [dbo].[User_GetMostLate]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT     u.id,
               u.firstName,
               u.lastName,
               MAX(DATEDIFF(DAY, a.expirationDate, IIF(a.returnDate IS NOT NULL, a.returnDate, CURRENT_TIMESTAMP))) AS daysLate
    FROM       dbo.[User] u
    INNER JOIN dbo.Activity a ON a.userId = u.id
    GROUP BY   u.id,
               u.firstName,
               u.lastName
    HAVING     MAX(DATEDIFF(DAY, a.expirationDate, IIF(a.returnDate IS NOT NULL, a.returnDate, CURRENT_TIMESTAMP))) > 0;
END;