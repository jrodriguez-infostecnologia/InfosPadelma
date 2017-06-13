CREATE TABLE [dbo].[iNivelDestino] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (2)   NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_iNivelDestino_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_iNivelDestino] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

