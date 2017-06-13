CREATE TABLE [dbo].[nLiquidacionNominaDatos] (
    [empresa]          INT          NOT NULL,
    [tipo]             VARCHAR (50) NOT NULL,
    [numero]           VARCHAR (50) NOT NULL,
    [año]              INT          NOT NULL,
    [mes]              INT          NOT NULL,
    [periodo]          INT          NOT NULL,
    [tercero]          INT          NOT NULL,
    [noContrato]       INT          NULL,
    [sueldo]           FLOAT (53)   NULL,
    [entidadEps]       VARCHAR (50) NULL,
    [entidadPension]   VARCHAR (50) NULL,
    [entidadCesantias] VARCHAR (50) NULL,
    [entidadArp]       VARCHAR (50) NULL,
    [entidadCaja]      VARCHAR (50) NULL,
    [entidadSena]      VARCHAR (50) NULL,
    [entidadIcbf]      VARCHAR (50) NULL,
    [centroTrabajo]    VARCHAR (50) NULL,
    CONSTRAINT [PK_nLiquidacionDatos] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [año] ASC, [mes] ASC, [periodo] ASC, [tercero] ASC)
);

