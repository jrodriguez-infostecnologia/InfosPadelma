CREATE TABLE [dbo].[aTransaccionNovedad] (
    [empresa]     INT             NOT NULL,
    [año]         INT             NOT NULL,
    [mes]         INT             NOT NULL,
    [tipo]        VARCHAR (50)    NOT NULL,
    [numero]      VARCHAR (50)    NOT NULL,
    [novedad]     VARCHAR (50)    NOT NULL,
    [registro]    INT             NOT NULL,
    [uMedida]     VARCHAR (50)    NULL,
    [seccion]     VARCHAR (50)    NULL,
    [lote]        VARCHAR (50)    NULL,
    [fecha]       DATE            NULL,
    [cantidad]    DECIMAL (18, 2) NOT NULL,
    [jornales]    DECIMAL (18, 2) NOT NULL,
    [racimos]     INT             NOT NULL,
    [pesoRacimo]  FLOAT (53)      NOT NULL,
    [saldo]       DECIMAL (18, 2) NOT NULL,
    [ejecutado]   BIT             CONSTRAINT [DF_aTransaccionLote_ejecutado] DEFAULT ((0)) NOT NULL,
    [signo]       INT             NULL,
    [precioLabor] MONEY           NULL,
    [concepto]    VARCHAR (50)    NULL,
    [periodo]     INT             NULL,
    CONSTRAINT [PK_aTransaccionNovedad] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [novedad] ASC, [registro] ASC),
    CONSTRAINT [FK_aTransaccionNovedad_aLotes] FOREIGN KEY ([empresa], [lote]) REFERENCES [dbo].[aLotes] ([empresa], [codigo]),
    CONSTRAINT [FK_aTransaccionNovedad_aTransaccion] FOREIGN KEY ([empresa], [tipo], [numero]) REFERENCES [dbo].[aTransaccion] ([empresa], [tipo], [numero]),
    CONSTRAINT [FK_aTransaccionNovedad_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_aTransaccionNovedad_gUnidadMedida] FOREIGN KEY ([empresa], [uMedida]) REFERENCES [dbo].[gUnidadMedida] ([empresa], [codigo])
);


GO
CREATE NONCLUSTERED INDEX [Idx_AtransaccionNovedad]
    ON [dbo].[aTransaccionNovedad]([empresa] ASC, [tipo] ASC, [numero] ASC, [novedad] ASC, [registro] ASC);

