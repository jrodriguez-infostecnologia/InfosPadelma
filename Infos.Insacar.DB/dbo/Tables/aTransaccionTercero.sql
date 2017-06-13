CREATE TABLE [dbo].[aTransaccionTercero] (
    [empresa]         INT             NOT NULL,
    [año]             INT             NOT NULL,
    [mes]             INT             NOT NULL,
    [tipo]            VARCHAR (50)    NOT NULL,
    [numero]          VARCHAR (50)    NOT NULL,
    [novedad]         VARCHAR (50)    NOT NULL,
    [registro]        INT             NOT NULL,
    [registroNovedad] INT             NOT NULL,
    [seccion]         VARCHAR (50)    NULL,
    [lote]            VARCHAR (50)    NULL,
    [tercero]         INT             NOT NULL,
    [cantidad]        DECIMAL (18, 2) NOT NULL,
    [jornales]        DECIMAL (18, 2) NOT NULL,
    [saldo]           DECIMAL (18, 2) NOT NULL,
    [ejecutado]       BIT             CONSTRAINT [DF_aTransaccionTercero_ejecutado] DEFAULT ((0)) NOT NULL,
    [zCuadrilla]      VARCHAR (50)    NULL,
    [precioLabor]     MONEY           NULL,
    [valorTotal]      INT             NULL,
    [ccosto]          VARCHAR (50)    NULL,
    [contrato]        INT             NULL,
    [periodo]         INT             NULL,
    CONSTRAINT [PK_aTransaccionTercero_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [novedad] ASC, [registro] ASC, [registroNovedad] ASC),
    CONSTRAINT [FK_aTransaccionTercero_aLotes] FOREIGN KEY ([empresa], [lote]) REFERENCES [dbo].[aLotes] ([empresa], [codigo]),
    CONSTRAINT [FK_aTransaccionTercero_aTransaccion] FOREIGN KEY ([empresa], [tipo], [numero]) REFERENCES [dbo].[aTransaccion] ([empresa], [tipo], [numero]),
    CONSTRAINT [FK_aTransaccionTercero_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);


GO
CREATE NONCLUSTERED INDEX [Idx_AtransaccionTercero]
    ON [dbo].[aTransaccionTercero]([empresa] ASC, [tipo] ASC, [numero] ASC, [tercero] ASC, [registro] ASC, [registroNovedad] ASC);

