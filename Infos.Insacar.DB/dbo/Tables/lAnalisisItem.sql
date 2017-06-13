CREATE TABLE [dbo].[lAnalisisItem] (
    [empresa]  INT          NOT NULL,
    [item]     INT          NOT NULL,
    [analisis] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_lAnlisisItem] PRIMARY KEY CLUSTERED ([empresa] ASC, [item] ASC, [analisis] ASC),
    CONSTRAINT [FK_lAnlisisItem_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_lAnlisisItem_iItems] FOREIGN KEY ([empresa], [item]) REFERENCES [dbo].[iItems] ([empresa], [codigo]),
    CONSTRAINT [FK_lAnlisisItem_lAnalisis] FOREIGN KEY ([empresa], [analisis]) REFERENCES [dbo].[lAnalisis] ([empresa], [codigo])
);

