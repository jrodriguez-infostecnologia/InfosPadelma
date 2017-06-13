CREATE TABLE [dbo].[sUsuarioPerfiles] (
    [empresa] INT          NOT NULL,
    [usuario] VARCHAR (50) NOT NULL,
    [perfil]  VARCHAR (50) NOT NULL,
    [activo]  BIT          CONSTRAINT [DF_usuarioPerfiles_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_sUsuarioPerfiles] PRIMARY KEY CLUSTERED ([empresa] ASC, [usuario] ASC),
    CONSTRAINT [FK_sUsuarioPerfiles_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_sUsuarioPerfiles_sUsuarios] FOREIGN KEY ([usuario]) REFERENCES [dbo].[sUsuarios] ([usuario]),
    CONSTRAINT [FK_usuarioPerfiles_perfiles] FOREIGN KEY ([perfil]) REFERENCES [dbo].[sPerfiles] ([codigo])
);

