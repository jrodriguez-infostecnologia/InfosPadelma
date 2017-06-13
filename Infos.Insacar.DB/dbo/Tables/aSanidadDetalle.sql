CREATE TABLE [dbo].[aSanidadDetalle] (
    [empresa]             INT             NOT NULL,
    [tipo]                VARCHAR (50)    NOT NULL,
    [numero]              VARCHAR (50)    NOT NULL,
    [registro]            INT             NOT NULL,
    [fecha]               DATE            NOT NULL,
    [lote]                VARCHAR (50)    NOT NULL,
    [linea]               INT             NOT NULL,
    [palma]               INT             NULL,
    [item]                INT             NOT NULL,
    [cantidad]            DECIMAL (18, 3) NULL,
    [uMedida]             VARCHAR (50)    NULL,
    [detalle]             VARCHAR (550)   NOT NULL,
    [ejecutado]           BIT             NULL,
    [fechaEjecutado]      DATETIME        NULL,
    [usuarioEjecturado]   DATETIME        NULL,
    [referenciaDetalle]   VARCHAR (50)    NULL,
    [grupoCaracteristica] VARCHAR (50)    NULL,
    [caracteristica]      VARCHAR (50)    NULL,
    [naturaleza]          INT             NULL,
    CONSTRAINT [PK_aSanidadDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [registro] ASC)
);

