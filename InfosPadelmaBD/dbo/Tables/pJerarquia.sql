CREATE TABLE [dbo].[pJerarquia] (
    [codigo]      INT           NOT NULL,
    [empresa]     INT           NOT NULL,
    [hijo]        INT           NOT NULL,
    [padre]       INT           NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_pJerarquia_activo] DEFAULT ((0)) NOT NULL,
    [nivel]       INT           NOT NULL,
    CONSTRAINT [PK_pJerarquia] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

