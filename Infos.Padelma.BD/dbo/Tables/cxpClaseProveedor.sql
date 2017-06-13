CREATE TABLE [dbo].[cxpClaseProveedor] (
    [empresa]     INT           NOT NULL,
    [codigo]      CHAR (4)      NOT NULL,
    [descripcion] VARCHAR (950) NOT NULL,
    CONSTRAINT [PK_cxpClaseProveedor] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_cxpClaseProveedor_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

