CREATE TABLE [dbo].[cClaseIR] (
    [empresa]     INT           NOT NULL,
    [codigo]      INT           NOT NULL,
    [descripcion] VARCHAR (950) NOT NULL,
    [sigla]       VARCHAR (5)   NOT NULL,
    [activo]      BIT           NOT NULL,
    [retencion]   BIT           CONSTRAINT [DF_cClaseIR_retencion] DEFAULT ((0)) NOT NULL,
    [impuesto]    BIT           NOT NULL,
    CONSTRAINT [PK_cClaseImpuesto] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

