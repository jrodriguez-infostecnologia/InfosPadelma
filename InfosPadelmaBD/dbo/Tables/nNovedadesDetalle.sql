CREATE TABLE [dbo].[nNovedadesDetalle] (
    [empresa]                 INT           NOT NULL,
    [tipo]                    VARCHAR (50)  NOT NULL,
    [numero]                  VARCHAR (50)  NOT NULL,
    [registro]                INT           NOT NULL,
    [concepto]                VARCHAR (50)  NULL,
    [empleado]                VARCHAR (50)  NULL,
    [cantidad]                INT           NOT NULL,
    [valor]                   MONEY         NOT NULL,
    [añoInicial]              INT           NOT NULL,
    [periodoInicial]          INT           NOT NULL,
    [periodoFinal]            INT           NOT NULL,
    [frecuencia]              INT           NOT NULL,
    [detalle]                 VARCHAR (250) NOT NULL,
    [ultimoPeriodoLiquidado]  INT           NULL,
    [ultimoPeriodoFrecuencia] INT           NULL,
    [liquidada]               BIT           NULL,
    [anulado]                 BIT           NULL,
    [añoFinal]                INT           NULL,
    CONSTRAINT [PK_nNovedadesDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [registro] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Idx_nNovedadesDetalle]
    ON [dbo].[nNovedadesDetalle]([empresa] ASC, [tipo] ASC, [numero] ASC, [registro] ASC);

