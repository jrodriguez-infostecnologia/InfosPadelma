CREATE TABLE [dbo].[nNovedades] (
    [empresa]         INT            NOT NULL,
    [tipo]            VARCHAR (50)   NOT NULL,
    [numero]          VARCHAR (50)   NOT NULL,
    [fecha]           DATE           NOT NULL,
    [remision]        VARCHAR (50)   NOT NULL,
    [ccosto]          VARCHAR (50)   NULL,
    [empleado]        VARCHAR (50)   NULL,
    [concepto]        VARCHAR (50)   NULL,
    [observacion]     VARCHAR (2000) NOT NULL,
    [anulado]         BIT            NOT NULL,
    [fechaAnulado]    DATETIME       NULL,
    [usuarioAnulado]  VARCHAR (50)   NULL,
    [usuarioRegistro] VARCHAR (50)   NOT NULL,
    [fechaRegistro]   DATETIME       NOT NULL,
    CONSTRAINT [PK_nNovedades] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Idx_nNovedades]
    ON [dbo].[nNovedades]([empresa] ASC, [tipo] ASC, [numero] ASC);

