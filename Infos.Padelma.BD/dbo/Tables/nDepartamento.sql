CREATE TABLE [dbo].[nDepartamento] (
    [empresa]     INT           NOT NULL,
    [ccosto]      VARCHAR (50)  CONSTRAINT [DF_nDepartamento_cCosto] DEFAULT ('01') NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_nDepartamento_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_nDepartamento_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_nDepartamento_cCentrosCosto] FOREIGN KEY ([empresa], [ccosto]) REFERENCES [dbo].[cCentrosCosto] ([empresa], [codigo]),
    CONSTRAINT [FK_nDepartamento_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

