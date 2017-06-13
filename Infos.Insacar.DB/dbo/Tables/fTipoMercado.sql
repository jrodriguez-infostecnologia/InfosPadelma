CREATE TABLE [dbo].[fTipoMercado] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_fTipoMercado_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_fTipoMercado] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

