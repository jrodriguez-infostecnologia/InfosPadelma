CREATE TABLE [dbo].[nTipoConceptoDetalle] (
    [empresa]      INT          NOT NULL,
    [tipoConcepto] VARCHAR (50) NOT NULL,
    [concepto]     VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_nTipoConceptoDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipoConcepto] ASC, [concepto] ASC)
);

