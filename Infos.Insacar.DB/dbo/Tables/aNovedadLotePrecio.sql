CREATE TABLE [dbo].[aNovedadLotePrecio] (
    [empresa]            INT             NOT NULL,
    [año]                VARCHAR (50)    NOT NULL,
    [novedad]            VARCHAR (50)    NOT NULL,
    [registro]           INT             NOT NULL,
    [precioDestajo]      MONEY           NOT NULL,
    [precioContratistas] MONEY           NOT NULL,
    [precioOtros]        MONEY           NOT NULL,
    [porcentaje]         DECIMAL (18, 3) NOT NULL,
    [fechaRegistro]      DATETIME        NOT NULL,
    [usuario]            VARCHAR (50)    NOT NULL,
    [modificado]         BIT             NOT NULL,
    [baseSueldo]         BIT             CONSTRAINT [DF_aNovedadLotePrecio_baseSueldo] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_aNovedadLotePrecio_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [novedad] ASC, [registro] ASC),
    CONSTRAINT [FK_aNovedadLotePrecio_aNovedad] FOREIGN KEY ([empresa], [novedad]) REFERENCES [dbo].[aNovedad] ([empresa], [codigo]),
    CONSTRAINT [FK_aNovedadLotePrecio_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

