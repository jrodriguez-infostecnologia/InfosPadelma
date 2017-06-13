CREATE TABLE [dbo].[iBodegaTipoTransaccion] (
    [empresa] INT          NOT NULL,
    [tipo]    VARCHAR (50) NOT NULL,
    [bodega]  VARCHAR (5)  NOT NULL,
    CONSTRAINT [PK_iBodegaTipoTransaccion] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [bodega] ASC)
);

