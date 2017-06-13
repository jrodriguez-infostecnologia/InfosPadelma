CREATE TABLE [dbo].[cxpProveedor] (
    [empresa]        INT           NOT NULL,
    [idTercero]      INT           NOT NULL,
    [codigo]         VARCHAR (10)  NOT NULL,
    [descripcion]    VARCHAR (950) NOT NULL,
    [activo]         BIT           CONSTRAINT [DF_cxpProveedores_activo] DEFAULT ((0)) NOT NULL,
    [clase]          CHAR (4)      NULL,
    [contacto]       VARCHAR (950) NOT NULL,
    [ciudad]         CHAR (5)      NULL,
    [direccion]      VARCHAR (950) NOT NULL,
    [telefono]       VARCHAR (50)  NOT NULL,
    [email]          VARCHAR (250) NOT NULL,
    [fechaRegistro]  DATETIME      NOT NULL,
    [entradaDirecta] BIT           CONSTRAINT [DF_cxpProveedor_entradaDirecta] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_cxpProveedores] PRIMARY KEY CLUSTERED ([empresa] ASC, [idTercero] ASC, [codigo] ASC),
    CONSTRAINT [FK_cxpProveedor_cxpClaseProveedor] FOREIGN KEY ([empresa], [clase]) REFERENCES [dbo].[cxpClaseProveedor] ([empresa], [codigo]),
    CONSTRAINT [FK_cxpProveedor_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

