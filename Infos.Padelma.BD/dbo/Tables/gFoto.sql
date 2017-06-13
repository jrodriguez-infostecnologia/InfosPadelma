CREATE TABLE [dbo].[gFoto] (
    [id]   INT             IDENTITY (1, 1) NOT NULL,
    [foto] VARBINARY (MAX) NOT NULL,
    CONSTRAINT [PK_gFoto] PRIMARY KEY CLUSTERED ([id] ASC)
);

