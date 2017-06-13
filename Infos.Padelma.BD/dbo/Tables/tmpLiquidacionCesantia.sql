CREATE TABLE [dbo].[tmpLiquidacionCesantia] (
    [empresa]              INT  NOT NULL,
    [tercero]              INT  NOT NULL,
    [año]                  INT  NULL,
    [fechaInicial]         DATE NULL,
    [fechaFinal]           DATE NULL,
    [fechaIngreso]         DATE NULL,
    [basico]               INT  NULL,
    [valorTransporte]      INT  NULL,
    [valorPromedio]        INT  NULL,
    [base]                 INT  NULL,
    [diasPromedio]         INT  NULL,
    [diasCesantia]         INT  NULL,
    [valorCesantia]        INT  NULL,
    [valorInteresCesantia] INT  NULL,
    [contrato]             INT  NULL,
    CONSTRAINT [PK_tmpLiquidacionCesantia] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC)
);

