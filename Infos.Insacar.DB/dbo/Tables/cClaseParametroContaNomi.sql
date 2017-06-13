CREATE TABLE [dbo].[cClaseParametroContaNomi] (
    [empresa]        INT           NOT NULL,
    [codigo]         VARCHAR (50)  NOT NULL,
    [descripcion]    VARCHAR (500) NOT NULL,
    [tipo]           VARCHAR (50)  NOT NULL,
    [tipoDocumento]  VARCHAR (50)  NOT NULL,
    [comprobante]    VARCHAR (50)  NOT NULL,
    [cuentaPuente]   VARCHAR (50)  NOT NULL,
    [cuentaCruce]    VARCHAR (50)  NULL,
    [ccostoMayor]    VARCHAR (50)  NULL,
    [ccosto]         VARCHAR (50)  NULL,
    [porTercero]     BIT           CONSTRAINT [DF_cClaseParametroContaNomi_porTercero_1] DEFAULT ((0)) NOT NULL,
    [porCuenta]      BIT           CONSTRAINT [DF_cClaseParametroContaNomi_porCuenta_1] DEFAULT ((0)) NOT NULL,
    [porCentroCosto] BIT           CONSTRAINT [DF_cClaseParametroContaNomi_porCentroCosto_1] DEFAULT ((0)) NOT NULL,
    [activo]         BIT           NOT NULL,
    CONSTRAINT [PK_cClaseParametroContaNomi] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

