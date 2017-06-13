CREATE TABLE [dbo].[bProcedenciaCorreos] (
    [empresa]     INT           NOT NULL,
    [procedencia] VARCHAR (50)  NOT NULL,
    [direccion]   VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_bProcedenciaDireccionE] PRIMARY KEY CLUSTERED ([empresa] ASC, [procedencia] ASC, [direccion] ASC),
    CONSTRAINT [FK_bProcedenciaCorreos_bProcedencia] FOREIGN KEY ([empresa], [procedencia]) REFERENCES [dbo].[bProcedencia] ([empresa], [codigo]),
    CONSTRAINT [FK_bProcedenciaCorreos_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

