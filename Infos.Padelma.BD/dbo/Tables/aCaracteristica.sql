CREATE TABLE [dbo].[aCaracteristica] (
    [empresa]             INT           NOT NULL,
    [codigo]              INT           NOT NULL,
    [descripcion]         VARCHAR (500) NOT NULL,
    [manejaCaractistica]  BIT           CONSTRAINT [DF_aCaracteristica_manejaCaractistica] DEFAULT ((0)) NOT NULL,
    [grupoCaracteristica] INT           NULL,
    [activo]              BIT           CONSTRAINT [DF_aCaracteristica_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aCaracteristica] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

