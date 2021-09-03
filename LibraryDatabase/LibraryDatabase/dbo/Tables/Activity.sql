CREATE TABLE [dbo].[Activity] (
    [id]             BIGINT   IDENTITY (1, 1) NOT NULL,
    [userId]         INT      NOT NULL,
    [bookCopyId]     BIGINT   NOT NULL,
    [statusId]       TINYINT  NOT NULL,
    [dateFrom]       DATE     NOT NULL,
    [returnDate]     DATE     NULL,
    [expirationDate] DATE     NOT NULL,
    [ctime]          DATETIME CONSTRAINT [DF_Activity_ctime] DEFAULT (getdate()) NOT NULL,
    [mtime]          DATETIME CONSTRAINT [DF_Activity_mtime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Activity_ActivityStatus] FOREIGN KEY ([statusId]) REFERENCES [dbo].[ActivityStatus] ([id]),
    CONSTRAINT [FK_Activity_BookCopy] FOREIGN KEY ([bookCopyId]) REFERENCES [dbo].[BookCopy] ([id]),
    CONSTRAINT [FK_Activity_User] FOREIGN KEY ([userId]) REFERENCES [dbo].[User] ([id])
);

