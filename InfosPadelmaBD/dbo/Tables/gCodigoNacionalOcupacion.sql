CREATE TABLE [dbo].[gCodigoNacionalOcupacion] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    CONSTRAINT [PK_gCodigoNacionalOcupacion] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

