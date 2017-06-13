CREATE TABLE [dbo].[nPagosNominaDetalle] (
    [empresa]         INT             NOT NULL,
    [año]             INT             NOT NULL,
    [mes]             INT             NOT NULL,
    [periodoNomina]   INT             NOT NULL,
    [registro]        INT             NOT NULL,
    [item]            INT             NOT NULL,
    [codigoBanco]     VARCHAR (50)    NOT NULL,
    [tercero]         INT             NOT NULL,
    [claseContrato]   INT             NOT NULL,
    [valorPago]       DECIMAL (18, 3) NOT NULL,
    [tipoCuenta]      VARCHAR (10)    NOT NULL,
    [documentoNomina] VARCHAR (50)    NOT NULL,
    [noCheque]        VARCHAR (50)    NOT NULL,
    [formaPago]       VARCHAR (50)    NOT NULL,
    [noContrato]      INT             NULL,
    [centroCosto]     VARCHAR (50)    NULL,
    CONSTRAINT [PK_nPagosNominaDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [periodoNomina] ASC, [registro] ASC, [item] ASC),
    CONSTRAINT [FK_nPagosNominaDetalle_cTercero] FOREIGN KEY ([empresa], [tercero]) REFERENCES [dbo].[cTercero] ([empresa], [id])
);

