CREATE TABLE [dbo].[aTipoCanal] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (10)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_aTipoCanal] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

