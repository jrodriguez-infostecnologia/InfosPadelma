CREATE TABLE [dbo].[nParametrosTipoCotizante] (
    [empresa]          INT          NOT NULL,
    [tipoCotizante]    VARCHAR (50) NOT NULL,
    [subTipoCotizante] VARCHAR (50) NOT NULL,
    [salud]            BIT          NOT NULL,
    [pension]          BIT          NOT NULL,
    [fondoSolidaridad] BIT          NOT NULL,
    [arp]              BIT          NOT NULL,
    [caja]             BIT          NOT NULL,
    [sena]             BIT          NOT NULL,
    [icbf]             BIT          NOT NULL,
    CONSTRAINT [PK_nParametrosSeguridadSocial] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipoCotizante] ASC, [subTipoCotizante] ASC)
);

