CREATE TABLE [dbo].[aLotesCanal] (
    [empresa]   INT             NOT NULL,
    [lote]      VARCHAR (50)    NOT NULL,
    [registro]  INT             NOT NULL,
    [tipoCanal] VARCHAR (10)    NOT NULL,
    [metros]    DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_aLoteCanal] PRIMARY KEY CLUSTERED ([empresa] ASC, [lote] ASC, [registro] ASC, [tipoCanal] ASC),
    CONSTRAINT [FK_aLotesCanal_aLotes] FOREIGN KEY ([empresa], [lote]) REFERENCES [dbo].[aLotes] ([empresa], [codigo]),
    CONSTRAINT [FK_aLotesCanal_aTipoCanal] FOREIGN KEY ([empresa], [tipoCanal]) REFERENCES [dbo].[aTipoCanal] ([empresa], [codigo]),
    CONSTRAINT [FK_aLotesCanal_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

