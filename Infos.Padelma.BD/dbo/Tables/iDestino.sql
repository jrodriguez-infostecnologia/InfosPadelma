CREATE TABLE [dbo].[iDestino] (
    [empresa]      INT          NOT NULL,
    [codigo]       VARCHAR (50) NOT NULL,
    [nivel]        INT          NOT NULL,
    [nivelPadre]   INT          NOT NULL,
    [padre]        VARCHAR (50) NOT NULL,
    [descripcion]  VARCHAR (50) NOT NULL,
    [ctaInversion] VARCHAR (16) NOT NULL,
    [ctaGasto]     VARCHAR (16) NOT NULL,
    [activo]       BIT          NOT NULL,
    CONSTRAINT [PK_iDestino] PRIMARY KEY CLUSTERED ([codigo] ASC, [nivel] ASC, [empresa] ASC)
);

