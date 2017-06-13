CREATE TABLE [dbo].[nTipoIncapacidad] (
    [empresa]               INT           NOT NULL,
    [codigo]                VARCHAR (50)  NOT NULL,
    [descripcion]           VARCHAR (550) NOT NULL,
    [porcentaje]            FLOAT (53)    NOT NULL,
    [adicionarPorcentaje]   BIT           NOT NULL,
    [despues]               INT           NOT NULL,
    [porcentajeNuevo]       FLOAT (53)    NOT NULL,
    [activo]                BIT           NOT NULL,
    [afectaSeguridadSocial] BIT           CONSTRAINT [DF_nTipoIncapacidad_afectaSeguridadSocial] DEFAULT ((0)) NOT NULL,
    [afectaARL]             BIT           NOT NULL,
    [afectaNovedadSS]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_nTipoIncapacidad] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

