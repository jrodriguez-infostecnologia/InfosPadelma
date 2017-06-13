CREATE TABLE [dbo].[aSanidad] (
    [empresa]         INT           NOT NULL,
    [tipo]            VARCHAR (50)  NOT NULL,
    [numero]          VARCHAR (50)  NOT NULL,
    [fecha]           DATE          NOT NULL,
    [finca]           VARCHAR (50)  NOT NULL,
    [seccion]         CHAR (3)      NULL,
    [remision]        VARCHAR (50)  NULL,
    [nota]            VARCHAR (950) NOT NULL,
    [referencia]      VARCHAR (50)  NULL,
    [usuario]         VARCHAR (50)  NOT NULL,
    [fechaRegistro]   DATETIME      NOT NULL,
    [anulado]         BIT           NULL,
    [usuarioAnulado]  VARCHAR (50)  NULL,
    [fechaAnulado]    DATETIME      NULL,
    [ejecutado]       BIT           CONSTRAINT [DF_aSanidad_ejecutado] DEFAULT ((0)) NOT NULL,
    [aprobado]        BIT           CONSTRAINT [DF_aSanidad_aprobado] DEFAULT ((0)) NOT NULL,
    [usuarioAprobado] VARCHAR (50)  NULL,
    [fechaAprobado]   DATETIME      NULL,
    CONSTRAINT [PK_aSanidad] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC)
);

