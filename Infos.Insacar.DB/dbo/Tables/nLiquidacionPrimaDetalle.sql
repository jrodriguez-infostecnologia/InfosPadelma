CREATE TABLE [dbo].[nLiquidacionPrimaDetalle] (
    [empresa]         INT          NOT NULL,
    [tipo]            VARCHAR (50) NOT NULL,
    [numero]          VARCHAR (50) NOT NULL,
    [tercero]         INT          NOT NULL,
    [añoInicial]      INT          NULL,
    [añoFinal]        INT          NULL,
    [periodoInicial]  INT          NULL,
    [periodoFinal]    INT          NULL,
    [fechaInicial]    DATE         NULL,
    [fechaFinal]      DATE         NULL,
    [fechaIngreso]    DATE         NULL,
    [basico]          INT          NULL,
    [valorTransporte] INT          NULL,
    [valorPromedio]   INT          NULL,
    [base]            INT          NULL,
    [diasPromedio]    INT          NULL,
    [diasPrimas]      INT          NULL,
    [valorPrima]      INT          NULL,
    [contrato]        INT          NULL,
    CONSTRAINT [PK_nLiquidacionPrimaDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [tercero] ASC)
);

