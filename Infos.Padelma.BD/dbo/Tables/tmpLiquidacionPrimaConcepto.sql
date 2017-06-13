﻿CREATE TABLE [dbo].[tmpLiquidacionPrimaConcepto] (
    [empresa]         INT          NOT NULL,
    [tercero]         INT          NOT NULL,
    [concepto]        VARCHAR (50) NOT NULL,
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
    CONSTRAINT [PK_tmpLiquidacionPrimaConcepto] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC, [concepto] ASC)
);

