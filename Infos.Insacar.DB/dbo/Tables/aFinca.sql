CREATE TABLE [dbo].[aFinca] (
    [empresa]            INT           NOT NULL,
    [codigo]             VARCHAR (50)  NOT NULL,
    [descripcion]        VARCHAR (950) NOT NULL,
    [proveedor]          INT           NULL,
    [ciudad]             CHAR (5)      NULL,
    [activo]             BIT           NOT NULL,
    [interna]            BIT           CONSTRAINT [DF_aFinca_interna] DEFAULT ((0)) NOT NULL,
    [zonaGeografica]     VARCHAR (550) NULL,
    [hectareas]          FLOAT (53)    NOT NULL,
    [fechaRegistro]      DATE          NOT NULL,
    [usuarioRegistro]    VARCHAR (50)  NOT NULL,
    [codigoEquivalencia] VARCHAR (50)  NULL,
    CONSTRAINT [PK_aFinca] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_aFinca_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_aFinca_gEmpresa1] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

