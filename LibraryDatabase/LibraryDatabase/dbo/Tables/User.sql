CREATE TABLE [dbo].[User] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [firstName]   NVARCHAR (50) NOT NULL,
    [lastName]    NVARCHAR (50) NOT NULL,
    [dateOfBirth] DATE          NOT NULL,
    [deleted]     BIT           CONSTRAINT [DF_User_deleted] DEFAULT ((0)) NOT NULL,
    [ctime]       DATETIME      CONSTRAINT [DF_User_ctime] DEFAULT (getdate()) NOT NULL,
    [mtime]       DATETIME      CONSTRAINT [DF_User_mtime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([id] ASC)
);

