CREATE TABLE [dbo].[lRegistroBodega] (
    [empresa]  INT          NOT NULL,
    [tipo]     VARCHAR (50) NOT NULL,
    [numero]   VARCHAR (50) NOT NULL,
    [bodega]   VARCHAR (5)  NOT NULL,
    [cantidad] INT          NOT NULL,
    CONSTRAINT [PK_lRegistroTanque] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [bodega] ASC)
);

