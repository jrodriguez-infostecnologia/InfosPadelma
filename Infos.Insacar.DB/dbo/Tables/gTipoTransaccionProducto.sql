CREATE TABLE [dbo].[gTipoTransaccionProducto] (
    [empresa]  INT          NOT NULL,
    [tipo]     VARCHAR (50) NOT NULL,
    [producto] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_gTipoTransaccionProducto] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [producto] ASC)
);

