CREATE TABLE [dbo].[cCentrosCosto] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [nivel]       INT           NOT NULL,
    [nivelMayor]  INT           NULL,
    [mayor]       VARCHAR (50)  NULL,
    [descripcion] VARCHAR (350) NOT NULL,
    [responsable] VARCHAR (150) NOT NULL,
    [grupo]       VARCHAR (50)  NOT NULL,
    [manejaHE]    BIT           CONSTRAINT [DF_cCentrosCosto_manejaHE] DEFAULT ((0)) NOT NULL,
    [manejaLC]    BIT           CONSTRAINT [DF_cCentrosCosto_manejaLC] DEFAULT ((0)) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_cCentrosCosto_activo] DEFAULT ((0)) NOT NULL,
    [auxiliar]    BIT           CONSTRAINT [DF_cCentrosCosto_auxiliar] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_cCentrosCosto_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_cCentrosCosto_cGrupoCCosto] FOREIGN KEY ([empresa], [grupo]) REFERENCES [dbo].[cGrupoCCosto] ([empresa], [codigo])
);

