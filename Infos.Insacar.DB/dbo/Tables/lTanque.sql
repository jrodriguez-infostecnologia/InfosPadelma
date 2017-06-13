CREATE TABLE [dbo].[lTanque] (
    [empresa]     INT           NOT NULL,
    [codigo]      CHAR (5)      NOT NULL,
    [descripcion] VARCHAR (950) NOT NULL,
    [item]        INT           NOT NULL,
    [capacidad]   FLOAT (53)    NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_lTanque_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_lTanque] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

