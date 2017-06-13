CREATE TABLE [dbo].[sModulos] (
    [codigo]      VARCHAR (150) NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [dirUrl]      VARCHAR (950) NOT NULL,
    [imagen]      VARCHAR (950) NOT NULL,
    [orden]       INT           NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_sModulos_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_sitios] PRIMARY KEY CLUSTERED ([codigo] ASC)
);

