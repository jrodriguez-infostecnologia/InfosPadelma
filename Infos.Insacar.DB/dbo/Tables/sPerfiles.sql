CREATE TABLE [dbo].[sPerfiles] (
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_perfiles_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_perfiles] PRIMARY KEY CLUSTERED ([codigo] ASC)
);

