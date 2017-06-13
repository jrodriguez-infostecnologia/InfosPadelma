CREATE TABLE [dbo].[nFestivo] (
    [empresa] INT  NOT NULL,
    [fecha]   DATE NOT NULL,
    CONSTRAINT [PK_nFestivos] PRIMARY KEY CLUSTERED ([empresa] ASC, [fecha] ASC)
);

