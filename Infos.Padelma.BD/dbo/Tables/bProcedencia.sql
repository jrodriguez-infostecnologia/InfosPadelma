CREATE TABLE [dbo].[bProcedencia] (
    [empresa]       INT          NOT NULL,
    [codigo]        VARCHAR (50) NOT NULL,
    [proveedor]     INT          NULL,
    [agrupadoPor]   INT          NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    [activo]        BIT          CONSTRAINT [DF_bProcedencia_activa] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_bProcedencia_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_bProcedencia_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

