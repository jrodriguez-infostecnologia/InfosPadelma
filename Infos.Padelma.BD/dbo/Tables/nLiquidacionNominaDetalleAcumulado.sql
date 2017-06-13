﻿CREATE TABLE [dbo].[nLiquidacionNominaDetalleAcumulado] (
    [empresa]              FLOAT (53)      NULL,
    [tipo]                 VARCHAR (50)    NULL,
    [numero]               VARCHAR (50)    NULL,
    [año]                  FLOAT (53)      NULL,
    [mes]                  FLOAT (53)      NULL,
    [registro]             FLOAT (53)      NULL,
    [noPeriodo]            FLOAT (53)      NULL,
    [tercero]              FLOAT (53)      NULL,
    [concepto]             VARCHAR (50)    NULL,
    [fechaInicial]         DATE            NULL,
    [fechaFinal]           DATE            NULL,
    [ccosto]               VARCHAR (50)    NULL,
    [departamento]         VARCHAR (50)    NULL,
    [cantidad]             DECIMAL (18, 3) NULL,
    [porcentaje]           DECIMAL (18, 3) NULL,
    [valorUnitario]        FLOAT (53)      NULL,
    [valorTotal]           FLOAT (53)      NULL,
    [signo]                INT             NULL,
    [saldo]                FLOAT (53)      NULL,
    [noDias]               FLOAT (53)      NULL,
    [entidad]              VARCHAR (50)    NULL,
    [contrato]             FLOAT (53)      NULL,
    [basePrimas]           BIT             NULL,
    [baseCajaCompensacion] BIT             NULL,
    [baseCesantias]        BIT             NULL,
    [baseVacaciones]       BIT             NULL,
    [baseIntereses]        BIT             NULL,
    [baseSeguridadSocial]  BIT             NULL,
    [manejaRango]          BIT             NULL,
    [baseEmbargo]          BIT             NULL,
    [noPrestamo]           NVARCHAR (255)  NULL,
    [cantidadR]            FLOAT (53)      NULL,
    [valorTotalR]          FLOAT (53)      NULL,
    [fecha]                VARCHAR (50)    NULL,
    [tipoConcepto]         VARCHAR (50)    NULL,
    [desTipoConcepto]      VARCHAR (50)    NULL
);

