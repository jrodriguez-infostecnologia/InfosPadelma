CREATE TABLE [dbo].[cPeriodo] (
    [empresa]      INT           NOT NULL,
    [año]          INT           NOT NULL,
    [mes]          INT           NOT NULL,
    [descripcion]  VARCHAR (550) NULL,
    [periodo]      VARCHAR (6)   NULL,
    [cerrado]      BIT           CONSTRAINT [DF_cPeriodo_cerrado] DEFAULT ((0)) NOT NULL,
    [fechaInicial] DATE          NULL,
    [fechaFinal]   DATE          NULL,
    CONSTRAINT [PK_cPeriodo] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC)
);

