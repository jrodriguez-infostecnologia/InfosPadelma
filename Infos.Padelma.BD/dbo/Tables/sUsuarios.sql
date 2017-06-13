CREATE TABLE [dbo].[sUsuarios] (
    [usuario]       VARCHAR (50)    NOT NULL,
    [descripcion]   VARCHAR (250)   NOT NULL,
    [clave]         VARBINARY (250) NOT NULL,
    [activo]        BIT             CONSTRAINT [DF_usuarios_activo] DEFAULT ((0)) NOT NULL,
    [fechaRegistro] DATETIME        NOT NULL,
    [email]         VARCHAR (250)   NOT NULL,
    CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED ([usuario] ASC)
);

