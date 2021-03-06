﻿CREATE TABLE [dbo].[bRegistroBascula] (
    [empresa]                  INT            NOT NULL,
    [tipo]                     VARCHAR (50)   NOT NULL,
    [numero]                   VARCHAR (50)   NOT NULL,
    [fecha]                    DATETIME       NOT NULL,
    [tiquete]                  VARCHAR (50)   NOT NULL,
    [remision]                 VARCHAR (50)   NOT NULL,
    [pesoBruto]                FLOAT (53)     CONSTRAINT [DF_bRegistroBascula_pesoBruto] DEFAULT ((0)) NOT NULL,
    [pesoDescuento]            FLOAT (53)     NULL,
    [pesoTara]                 FLOAT (53)     CONSTRAINT [DF_bRegistroBascula_peosTara] DEFAULT ((0)) NOT NULL,
    [pesoNeto]                 FLOAT (53)     CONSTRAINT [DF_bRegistroBascula_pesoNeto] DEFAULT ((0)) NOT NULL,
    [fechaBruto]               DATETIME       NULL,
    [fechaTara]                DATETIME       NULL,
    [fechaNeto]                DATETIME       NULL,
    [estado]                   CHAR (2)       NOT NULL,
    [tipoVehiculo]             VARCHAR (50)   NULL,
    [vehiculo]                 VARCHAR (50)   NOT NULL,
    [remolque]                 VARCHAR (50)   NOT NULL,
    [item]                     INT            NULL,
    [procedencia]              VARCHAR (50)   NULL,
    [finca]                    VARCHAR (50)   NULL,
    [usuario]                  VARCHAR (50)   NOT NULL,
    [fechaProceso]             DATETIME       NULL,
    [racimos]                  INT            CONSTRAINT [DF_bRegistroBascula_racimos] DEFAULT ((0)) NOT NULL,
    [bodega]                   VARCHAR (50)   NULL,
    [sacos]                    INT            CONSTRAINT [DF_bRegistroBascula_sacos] DEFAULT ((0)) NOT NULL,
    [urlTiquete]               VARCHAR (250)  NULL,
    [analisisRegistrado]       BIT            CONSTRAINT [DF_bRegistroBascula_analisisRegistrado] DEFAULT ((0)) NOT NULL,
    [pesoSacos]                FLOAT (53)     CONSTRAINT [DF_bRegistroBascula_pesoSacos] DEFAULT ((0)) NOT NULL,
    [sellos]                   VARCHAR (250)  NULL,
    [tipoDescargue]            VARCHAR (50)   NULL,
    [codigoConductor]          VARCHAR (50)   NULL,
    [nombreConductor]          VARCHAR (200)  NULL,
    [tercero]                  VARCHAR (50)   NULL,
    [vehiculoInterno]          BIT            CONSTRAINT [DF_bRegistroBascula_vehiculoInterno] DEFAULT ((0)) NOT NULL,
    [remisionPlanta]           VARCHAR (50)   NULL,
    [remisionComercializadora] VARCHAR (50)   NULL,
    [planta]                   INT            NULL,
    [plantaOrigen]             INT            NULL,
    [facturada]                BIT            NULL,
    [fechaFactura]             DATETIME       NULL,
    [saldo]                    FLOAT (53)     NULL,
    [recibido]                 BIT            NULL,
    [cantidadRecibida]         FLOAT (53)     NULL,
    [ordenSalida]              VARCHAR (50)   NULL,
    [fechaOS]                  DATETIME       NULL,
    [usuarioOS]                VARCHAR (50)   NULL,
    [motivoOS]                 VARCHAR (500)  NULL,
    [observacion]              VARCHAR (2550) NULL,
    CONSTRAINT [PK_bRegistroBascula_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC),
    CONSTRAINT [FK_bRegistroBascula_bTipoVehiculo] FOREIGN KEY ([empresa], [tipoVehiculo]) REFERENCES [dbo].[bTipoVehiculo] ([empresa], [codigo]),
    CONSTRAINT [FK_bRegistroBascula_gTipoTransaccion] FOREIGN KEY ([empresa], [tipo]) REFERENCES [dbo].[gTipoTransaccion] ([empresa], [codigo]),
    CONSTRAINT [FK_bRegistroBascula_iItems] FOREIGN KEY ([empresa], [item]) REFERENCES [dbo].[iItems] ([empresa], [codigo])
);

