CREATE TABLE [dbo].[Book] (
    [id]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [isbn]    NVARCHAR (50) NOT NULL,
    [name]    NVARCHAR (50) NOT NULL,
    [deleted] BIT           CONSTRAINT [DF_Book_deleted] DEFAULT ((0)) NOT NULL,
    [ctime]   DATETIME      CONSTRAINT [DF_Book_ctime] DEFAULT (getdate()) NOT NULL,
    [mtime]   DATETIME      CONSTRAINT [DF_Book_mtime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED ([id] ASC)
);

