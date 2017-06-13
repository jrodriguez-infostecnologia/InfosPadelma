CREATE TABLE [dbo].[cxpProveedorBanco] (
    [empresa]    INT           NOT NULL,
    [proveedor]  INT           NOT NULL,
    [banco]      VARCHAR (50)  NOT NULL,
    [tipoCuenta] CHAR (1)      NOT NULL,
    [nroCuenta]  VARCHAR (150) NOT NULL,
    [ciudad]     CHAR (5)      NULL,
    CONSTRAINT [PK_cxpProveedorBanco] PRIMARY KEY CLUSTERED ([empresa] ASC, [proveedor] ASC, [banco] ASC),
    CONSTRAINT [FK_cxpProveedorBanco_gBanco] FOREIGN KEY ([empresa], [banco]) REFERENCES [dbo].[gBanco] ([empresa], [codigo]),
    CONSTRAINT [FK_cxpProveedorBanco_gTipoCuenta] FOREIGN KEY ([empresa], [tipoCuenta]) REFERENCES [dbo].[gTipoCuenta] ([empresa], [codigo])
);

