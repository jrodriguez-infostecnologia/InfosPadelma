CREATE TABLE [dbo].[nCuadrillaFuncionario] (
    [empresa]     INT          NOT NULL,
    [cuadrilla]   VARCHAR (50) NOT NULL,
    [funcionario] INT          NOT NULL,
    CONSTRAINT [PK_nCuadrillaFuncionario] PRIMARY KEY CLUSTERED ([empresa] ASC, [cuadrilla] ASC, [funcionario] ASC),
    CONSTRAINT [FK_nCuadrillaFuncionario_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_nCuadrillaFuncionario_nCuadrilla] FOREIGN KEY ([empresa], [cuadrilla]) REFERENCES [dbo].[nCuadrilla] ([empresa], [codigo]),
    CONSTRAINT [FK_nCuadrillaFuncionario_nFuncionario] FOREIGN KEY ([empresa], [funcionario]) REFERENCES [dbo].[nFuncionario] ([empresa], [tercero])
);

