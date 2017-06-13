CREATE TABLE [dbo].[cxpProveedorCalseIR] (
    [empresa]   INT          NOT NULL,
    [tercero]   INT          NOT NULL,
    [proveedor] VARCHAR (10) NOT NULL,
    [clase]     INT          NOT NULL,
    [concepto]  VARCHAR (5)  NULL,
    CONSTRAINT [PK_cxpProveedorCalseIR] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC, [proveedor] ASC, [clase] ASC)
);

