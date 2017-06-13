CREATE TABLE [dbo].[gTipoLiquidacion] (
    [codigo]      INT           NOT NULL,
    [empresa]     INT           NOT NULL,
    [descripcion] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_gTipoLiquidacion] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

