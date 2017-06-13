CREATE TABLE [dbo].[gTipoEmbargo] (
    [codigo]      VARCHAR (50)  NOT NULL,
    [empresa]     INT           NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_gTipoEmbargo] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

