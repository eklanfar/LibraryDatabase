CREATE TABLE [dbo].[BookCopy] (
    [id]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [bookId]  BIGINT        NOT NULL,
    [uid]     NVARCHAR (50) NOT NULL,
    [deleted] BIT           CONSTRAINT [DF_BookCopy_deleted] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_BookCopy] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_BookCopy_Book] FOREIGN KEY ([bookId]) REFERENCES [dbo].[Book] ([id])
);

