CREATE TABLE [dbo].[bTipoVehiculo] (
    [empresa]        INT           NOT NULL,
    [codigo]         VARCHAR (50)  NOT NULL,
    [descripcion]    VARCHAR (250) NOT NULL,
    [aplicaRemolque] BIT           CONSTRAINT [DF_bTipoVehiculo_aplicaRemolque] DEFAULT ((0)) NOT NULL,
    [activo]         BIT           CONSTRAINT [DF_bTipoVehiculo_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_bTipoVehiculo] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_bTipoVehiculo_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

