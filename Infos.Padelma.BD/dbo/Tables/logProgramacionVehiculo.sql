﻿CREATE TABLE [dbo].[logProgramacionVehiculo] (
    [empresa]           INT           NOT NULL,
    [numero]            VARCHAR (50)  NOT NULL,
    [tipo]              VARCHAR (50)  NOT NULL,
    [fecha]             DATE          NOT NULL,
    [vehiculoPropio]    BIT           NULL,
    [vehiculo]          VARCHAR (50)  NOT NULL,
    [despacho]          VARCHAR (50)  NULL,
    [codigoConductor]   VARCHAR (50)  NOT NULL,
    [nombreConductor]   VARCHAR (250) NOT NULL,
    [programacionCarga] VARCHAR (50)  NOT NULL,
    [fechaDespacho]     DATETIME      NOT NULL,
    [remolque]          VARCHAR (50)  NOT NULL,
    [producto]          INT           NOT NULL,
    [comercializadora]  VARCHAR (50)  NOT NULL,
    [tercero]           INT           NOT NULL,
    [cantidad]          INT           NOT NULL,
    [observacion]       VARCHAR (250) NOT NULL,
    [planta]            VARCHAR (50)  NOT NULL,
    [estado]            VARCHAR (2)   NOT NULL,
    [cliente]           VARCHAR (10)  NOT NULL,
    [fechaRegistro]     DATETIME      NOT NULL,
    [usuario]           VARCHAR (50)  NOT NULL,
    [certificado]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_logProgramacionVehiculo_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [numero] ASC, [tipo] ASC)
);
