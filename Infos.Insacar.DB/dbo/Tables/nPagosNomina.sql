CREATE TABLE [dbo].[nPagosNomina] (
    [empresa]         INT          NOT NULL,
    [año]             INT          NOT NULL,
    [mes]             INT          NOT NULL,
    [periodoNomina]   INT          NOT NULL,
    [registro]        INT          NOT NULL,
    [numero]          VARCHAR (50) NOT NULL,
    [fecha]           DATE         NOT NULL,
    [Banco]           VARCHAR (50) NOT NULL,
    [TipoCuenta]      VARCHAR (50) NOT NULL,
    [noCuenta]        VARCHAR (50) NOT NULL,
    [NoChequeInicial] VARCHAR (50) NOT NULL,
    [usuario]         VARCHAR (50) NOT NULL,
    [anulado]         BIT          NULL,
    [usuarioAnulado]  VARCHAR (50) NULL,
    [fechaAnualado]   DATETIME     NULL,
    [fechaRegistro]   DATETIME     NOT NULL,
    [valorTotal]      MONEY        NOT NULL,
    CONSTRAINT [PK_nPagosNomina_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [periodoNomina] ASC, [registro] ASC, [numero] ASC),
    CONSTRAINT [FK_nPagosNomina_gBanco] FOREIGN KEY ([empresa], [Banco]) REFERENCES [dbo].[gBanco] ([empresa], [codigo]),
    CONSTRAINT [FK_nPagosNomina_nPeriodoDetalle] FOREIGN KEY ([empresa], [año], [mes], [periodoNomina]) REFERENCES [dbo].[nPeriodoDetalle] ([empresa], [año], [mes], [noPeriodo])
);

