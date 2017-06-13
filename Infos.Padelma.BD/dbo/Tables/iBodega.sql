CREATE TABLE [dbo].[iBodega] (
    [empresa]         INT           NOT NULL,
    [codigo]          VARCHAR (5)   NOT NULL,
    [descripcion]     VARCHAR (550) NOT NULL,
    [desCorta]        VARCHAR (50)  NOT NULL,
    [activo]          BIT           CONSTRAINT [DF_iBodega_activo] DEFAULT ((0)) NOT NULL,
    [validaCcosto]    BIT           NOT NULL,
    [cCosto]          VARCHAR (50)  NULL,
    [validaProveedor] BIT           CONSTRAINT [DF_iBodega_validaProveedor] DEFAULT ((0)) NOT NULL,
    [proveedor]       INT           NULL,
    [validaCuenta]    BIT           NOT NULL,
    [Cuenta]          VARCHAR (16)  NULL,
    [produccion]      BIT           CONSTRAINT [DF_iBodega_produccion] DEFAULT ((0)) NOT NULL,
    [mExistencia]     BIT           CONSTRAINT [DF_iBodega_manejaExistencia] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_iBodega] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

