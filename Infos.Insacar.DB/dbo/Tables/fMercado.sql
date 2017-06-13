CREATE TABLE [dbo].[fMercado] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [tipoMercado] VARCHAR (50)  NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_fMercado_bit] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_fMercado] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

