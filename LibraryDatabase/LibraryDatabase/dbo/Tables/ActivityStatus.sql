CREATE TABLE [dbo].[ActivityStatus] (
    [id]     TINYINT       NOT NULL,
    [status] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ActivityType] PRIMARY KEY CLUSTERED ([id] ASC)
);

