CREATE TABLE [dbo].[nLiquidacionPrima] (
    [empresa]        INT            NOT NULL,
    [tipo]           VARCHAR (50)   NOT NULL,
    [numero]         VARCHAR (50)   NOT NULL,
    [fecha]          DATE           NULL,
    [año]            INT            NOT NULL,
    [periodo]        INT            NOT NULL,
    [observacion]    VARCHAR (2550) NULL,
    [anulado]        BIT            NULL,
    [usuario]        VARCHAR (50)   NULL,
    [usuarioAnulado] VARCHAR (50)   NULL,
    [fechaRegistro]  DATETIME       NULL,
    [fechaAnulado]   DATETIME       NULL,
    CONSTRAINT [PK_nLiquidacionPrima] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC)
);

