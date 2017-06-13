CREATE TABLE [dbo].[pTransaccionDetalle] (
    [empresa]    INT          NOT NULL,
    [tipo]       VARCHAR (50) NOT NULL,
    [numero]     VARCHAR (50) NOT NULL,
    [registro]   INT          NOT NULL,
    [año]        INT          NOT NULL,
    [mes]        INT          NOT NULL,
    [movimiento] INT          NOT NULL,
    [valor]      FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_pTransaccionDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [registro] ASC),
    CONSTRAINT [FK_pTransaccionDetalle_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_pTransaccionDetalle_iItems] FOREIGN KEY ([empresa], [movimiento]) REFERENCES [dbo].[iItems] ([empresa], [codigo]),
    CONSTRAINT [FK_pTransaccionDetalle_pTransaccion] FOREIGN KEY ([empresa], [tipo], [numero]) REFERENCES [dbo].[pTransaccion] ([empresa], [tipo], [numero])
);

