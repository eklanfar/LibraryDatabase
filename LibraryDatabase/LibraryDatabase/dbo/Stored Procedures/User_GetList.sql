-- =============================================
-- Author:		eklanfar
-- Create date: 29.08.2021.
-- Description:	Get list of users
-- =============================================
CREATE PROCEDURE [dbo].[User_GetList]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT   id,
             firstName,
             lastName,
             dateOfBirth
    FROM     dbo.[User]
    WHERE    deleted = 0
    ORDER BY firstName,
             lastName;

END;