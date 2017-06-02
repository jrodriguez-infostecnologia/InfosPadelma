CREATE TABLE [dbo].[nCuadrilla] (
    [empresa]      INT           NOT NULL,
    [departamento] VARCHAR (50)  NOT NULL,
    [codigo]       VARCHAR (50)  NOT NULL,
    [descripcion]  VARCHAR (250) NOT NULL,
    [activo]       BIT           CONSTRAINT [DF_nCuadrilla_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_nCuadrilla_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_nCuadrilla_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_nCuadrilla_nDepartamento] FOREIGN KEY ([empresa], [departamento]) REFERENCES [dbo].[nDepartamento] ([empresa], [codigo])
);

