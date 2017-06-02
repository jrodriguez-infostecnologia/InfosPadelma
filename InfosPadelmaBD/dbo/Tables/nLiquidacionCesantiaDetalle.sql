CREATE TABLE [dbo].[nLiquidacionCesantiaDetalle] (
    [empresa]              INT        NOT NULL,
    [tipo]                 NCHAR (10) NOT NULL,
    [numero]               NCHAR (10) NOT NULL,
    [tercero]              INT        NOT NULL,
    [año]                  INT        NULL,
    [fechaInicial]         DATE       NULL,
    [fechaFinal]           DATE       NULL,
    [fechaIngreso]         DATE       NULL,
    [basico]               INT        NULL,
    [valorTransporte]      INT        NULL,
    [valorPromedio]        INT        NULL,
    [base]                 INT        NULL,
    [diasPromedio]         INT        NULL,
    [diasCesantia]         INT        NULL,
    [valorCesantia]        INT        NULL,
    [valorInteresCesantia] INT        NULL,
    [contrato]             INT        NULL,
    CONSTRAINT [PK_nLiquidacionDetalleCesantia] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [tercero] ASC)
);

