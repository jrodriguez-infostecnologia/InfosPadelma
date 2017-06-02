CREATE TABLE [dbo].[sPerfilPermisos] (
    [perfil]    VARCHAR (50)  NOT NULL,
    [sitio]     VARCHAR (150) NOT NULL,
    [menu]      VARCHAR (150) NOT NULL,
    [operacion] VARCHAR (50)  NOT NULL,
    [activo]    BIT           CONSTRAINT [DF_perfilPermisos_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_perfilPermisos] PRIMARY KEY CLUSTERED ([perfil] ASC, [sitio] ASC, [menu] ASC, [operacion] ASC),
    CONSTRAINT [FK_sPerfilPermisos_sMenu] FOREIGN KEY ([menu], [sitio]) REFERENCES [dbo].[sMenu] ([codigo], [modulo]),
    CONSTRAINT [FK_sPerfilPermisos_sModulos] FOREIGN KEY ([sitio]) REFERENCES [dbo].[sModulos] ([codigo]),
    CONSTRAINT [FK_sPerfilPermisos_sOperaciones] FOREIGN KEY ([operacion]) REFERENCES [dbo].[sOperaciones] ([codigo]),
    CONSTRAINT [FK_sPerfilPermisos_sPerfiles] FOREIGN KEY ([perfil]) REFERENCES [dbo].[sPerfiles] ([codigo])
);

