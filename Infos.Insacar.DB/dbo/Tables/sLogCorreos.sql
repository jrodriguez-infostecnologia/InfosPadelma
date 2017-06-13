CREATE TABLE [dbo].[sLogCorreos] (
    [id]      INT           IDENTITY (1, 1) NOT NULL,
    [subject] VARCHAR (200) NULL,
    [body]    VARCHAR (MAX) NULL,
    [estado]  VARCHAR (50)  NULL,
    CONSTRAINT [PK_sLogCorreos] PRIMARY KEY CLUSTERED ([id] ASC)
);

