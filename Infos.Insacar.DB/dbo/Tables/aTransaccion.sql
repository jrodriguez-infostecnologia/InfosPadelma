CREATE TABLE [dbo].[aTransaccion] (
    [empresa]         INT            NOT NULL,
    [año]             INT            NOT NULL,
    [mes]             INT            NOT NULL,
    [tipo]            VARCHAR (50)   NOT NULL,
    [numero]          VARCHAR (50)   NOT NULL,
    [fecha]           DATE           NOT NULL,
    [referencia]      VARCHAR (50)   NULL,
    [finca]           VARCHAR (50)   NOT NULL,
    [jornal]          INT            NOT NULL,
    [racimos]         INT            NOT NULL,
    [cantidad]        INT            NOT NULL,
    [precio]          MONEY          NOT NULL,
    [valorTotal]      MONEY          NOT NULL,
    [fechaFinal]      DATE           NULL,
    [remision]        VARCHAR (50)   NULL,
    [observacion]     VARCHAR (2550) NOT NULL,
    [fechaRegistro]   DATETIME       NOT NULL,
    [usuarioRegistro] VARCHAR (50)   NOT NULL,
    [anulado]         BIT            NULL,
    [usuarioAnulado]  VARCHAR (50)   NULL,
    [fechaAnulado]    DATETIME       NULL,
    [periodo]         INT            NULL,
    CONSTRAINT [PK_aTransaccion] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC),
    CONSTRAINT [FK_aTransaccion_aFinca] FOREIGN KEY ([empresa], [finca]) REFERENCES [dbo].[aFinca] ([empresa], [codigo]),
    CONSTRAINT [FK_aTransaccion_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);


GO
CREATE NONCLUSTERED INDEX [Idx_Atransaccion]
    ON [dbo].[aTransaccion]([empresa] ASC, [tipo] ASC, [numero] ASC);

