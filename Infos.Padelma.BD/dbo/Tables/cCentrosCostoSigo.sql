CREATE TABLE [dbo].[cCentrosCostoSigo] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [nivel]       INT           NOT NULL,
    [nivelMayor]  INT           NULL,
    [mayor]       VARCHAR (50)  NULL,
    [descripcion] VARCHAR (350) NOT NULL,
    [activo]      BIT           NOT NULL,
    [auxiliar]    BIT           NOT NULL
);

