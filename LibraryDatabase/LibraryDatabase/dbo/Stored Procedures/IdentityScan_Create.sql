-- =============================================
-- Author:		eklanfar
-- Create date: 2.9.2021.
-- Description:	Create identity scan record in db
-- =============================================
CREATE PROCEDURE [dbo].[IdentityScan_Create]
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @dateOfBirth NVARCHAR(10),
    @valid BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.IdentityScan (
                                     firstName,
                                     lastName,
                                     dateOfBirth,
                                     valid,
                                     ctime
                                 )
    VALUES (@firstName,   -- firstName - nvarchar(50)
            @lastName,    -- lastName - nvarchar(50)
            @dateOfBirth, -- dateOfBirth - date
            @valid,       -- valid - bit
            GETDATE()     -- ctime - datetime
        );

END;