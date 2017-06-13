CREATE TABLE [dbo].[cConceptoIR] (
    [empresa]      INT           NOT NULL,
    [codigo]       VARCHAR (50)  NOT NULL,
    [clase]        INT           NOT NULL,
    [descripcion]  VARCHAR (950) NOT NULL,
    [calculo]      CHAR (1)      NOT NULL,
    [baseGravable] FLOAT (53)    NOT NULL,
    [tasa]         FLOAT (53)    NOT NULL,
    [baseMinima]   MONEY         NOT NULL,
    [activo]       BIT           CONSTRAINT [DF_cImpuesto_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_cImpuesto] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_cConceptoIR_cClaseIR] FOREIGN KEY ([empresa], [clase]) REFERENCES [dbo].[cClaseIR] ([empresa], [codigo])
);

