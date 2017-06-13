CREATE TABLE [dbo].[gCiudad] (
    [empresa]      INT           NOT NULL,
    [codigo]       VARCHAR (50)  NOT NULL,
    [nombre]       VARCHAR (150) NOT NULL,
    [pais]         CHAR (5)      NOT NULL,
    [departamento] VARCHAR (50)  NULL,
    CONSTRAINT [PK_p_ciudades] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

