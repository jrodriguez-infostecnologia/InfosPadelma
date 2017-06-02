CREATE TABLE [dbo].[aGrupoNovedad] (
    [empresa]           INT          NOT NULL,
    [codigo]            VARCHAR (50) NOT NULL,
    [descripcion]       VARCHAR (50) NOT NULL,
    [activo]            BIT          CONSTRAINT [DF_aGrupoLabor_activo] DEFAULT ((0)) NOT NULL,
    [ccosto]            VARCHAR (50) NULL,
    [manejaCcostoSiigo] BIT          NULL,
    [ccostoSiigo]       VARCHAR (50) NULL,
    CONSTRAINT [PK_aGrupoLabor] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_aGrupoNovedad_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

