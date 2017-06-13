CREATE TABLE [dbo].[pTransaccion] (
    [empresa]        INT            NOT NULL,
    [tipo]           VARCHAR (50)   NOT NULL,
    [numero]         VARCHAR (50)   NOT NULL,
    [año]            INT            NOT NULL,
    [mes]            INT            NOT NULL,
    [fecha]          DATE           NOT NULL,
    [producto]       INT            NOT NULL,
    [usuario]        VARCHAR (50)   NOT NULL,
    [usuarioAnulado] VARCHAR (50)   NULL,
    [fechaRegistro]  DATETIME       NOT NULL,
    [anulado]        BIT            NULL,
    [fechaAnulado]   DATETIME       NULL,
    [Observacion]    VARCHAR (5500) NULL,
    CONSTRAINT [PK_pTransaccion] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC),
    CONSTRAINT [FK_pTransaccion_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_pTransaccion_iItems] FOREIGN KEY ([empresa], [producto]) REFERENCES [dbo].[iItems] ([empresa], [codigo])
);

