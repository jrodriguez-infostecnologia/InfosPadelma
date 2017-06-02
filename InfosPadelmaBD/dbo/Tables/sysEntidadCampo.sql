CREATE TABLE [dbo].[sysEntidadCampo] (
    [entidad] VARCHAR (250) NOT NULL,
    [campo]   VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_sysEntidadCampo] PRIMARY KEY CLUSTERED ([entidad] ASC, [campo] ASC)
);

