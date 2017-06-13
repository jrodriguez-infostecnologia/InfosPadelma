CREATE TABLE [dbo].[nConceptosFijosDetalle] (
    [empresa]     INT          NOT NULL,
    [centroCosto] VARCHAR (50) NOT NULL,
    [año]         INT          NOT NULL,
    [mes]         INT          NOT NULL,
    [noPeriodo]   INT          NOT NULL,
    [concepto]    VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_nConceptosFijosDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [centroCosto] ASC, [año] ASC, [mes] ASC, [noPeriodo] ASC, [concepto] ASC),
    CONSTRAINT [FK_nConceptosFijosDetalle_cCentrosCosto] FOREIGN KEY ([empresa], [centroCosto]) REFERENCES [dbo].[cCentrosCosto] ([empresa], [codigo]),
    CONSTRAINT [FK_nConceptosFijosDetalle_nConceptosFijos] FOREIGN KEY ([empresa], [centroCosto], [año], [mes], [noPeriodo]) REFERENCES [dbo].[nConceptosFijos] ([empresa], [centroCosto], [año], [mes], [noPeriodo]),
    CONSTRAINT [FK_nConceptosFijosDetalle_nPeriodoDetalle] FOREIGN KEY ([empresa], [año], [mes], [noPeriodo]) REFERENCES [dbo].[nPeriodoDetalle] ([empresa], [año], [mes], [noPeriodo])
);

