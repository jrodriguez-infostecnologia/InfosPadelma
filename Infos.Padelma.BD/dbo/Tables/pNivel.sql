CREATE TABLE [dbo].[pNivel] (
    [empresa]     INT           NOT NULL,
    [codigo]      INT           NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_pNivel] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

