CREATE TABLE [dbo].[aGrupoCaracteristica] (
    [empresa]     INT           NOT NULL,
    [codigo]      INT           NOT NULL,
    [descripcion] VARCHAR (500) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_aGrupoCaracteristica_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aGrupoCaracteristica] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

