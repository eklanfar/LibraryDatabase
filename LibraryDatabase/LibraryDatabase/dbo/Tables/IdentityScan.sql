CREATE TABLE [dbo].[IdentityScan] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [firstName]   NVARCHAR (50) NULL,
    [lastName]    NVARCHAR (50) NULL,
    [dateOfBirth] NVARCHAR (10) NULL,
    [valid]       BIT           NOT NULL,
    [ctime]       DATETIME      CONSTRAINT [DF_IdentityScan_ctime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_IdentityScan] PRIMARY KEY CLUSTERED ([id] ASC)
);

