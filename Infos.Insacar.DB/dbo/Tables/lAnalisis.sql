CREATE TABLE [dbo].[lAnalisis] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (10)  NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [uMedida]     VARCHAR (50)  NOT NULL,
    [produccion]  BIT           CONSTRAINT [DF_lAnalisis_produccion] DEFAULT ((0)) NOT NULL,
    [despacho]    BIT           CONSTRAINT [DF_lAnalisis_despacho] DEFAULT ((0)) NOT NULL,
    [informe]     BIT           CONSTRAINT [DF_lAnalisis_informe] DEFAULT ((0)) NOT NULL,
    [control]     BIT           CONSTRAINT [DF_lAnalisis_control] DEFAULT ((0)) NOT NULL,
    [orden]       INT           NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_lAnalisis_activo] DEFAULT ((0)) NOT NULL,
    [descuenta]   BIT           CONSTRAINT [DF_lAnalisis_descuenta] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_c_analisis] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_lAnalisis_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_lAnalisis_gUnidadMedida] FOREIGN KEY ([empresa], [uMedida]) REFERENCES [dbo].[gUnidadMedida] ([empresa], [codigo])
);

