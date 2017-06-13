CREATE TABLE [dbo].[cContabilizacion] (
    [empresa]         INT           NOT NULL,
    [tipo]            VARCHAR (50)  NOT NULL,
    [numero]          VARCHAR (50)  NOT NULL,
    [tipoLiquidacion] VARCHAR (50)  NOT NULL,
    [año]             INT           NOT NULL,
    [mes]             INT           NOT NULL,
    [periodoContable] VARCHAR (50)  NOT NULL,
    [periodoNomina]   VARCHAR (50)  NULL,
    [estado]          INT           NOT NULL,
    [fecha]           DATETIME      NOT NULL,
    [fechaRegistro]   DATETIME      NOT NULL,
    [usuarioRegistro] VARCHAR (50)  NOT NULL,
    [observacion]     VARCHAR (500) NOT NULL,
    [anulado]         BIT           CONSTRAINT [DF_cContabilizacion_anulado] DEFAULT ((0)) NOT NULL,
    [fechaAnulado]    DATETIME      NULL,
    [usuarioAnulado]  VARCHAR (50)  NULL,
    CONSTRAINT [PK_cContabilizacion2] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [tipoLiquidacion] ASC, [año] ASC, [mes] ASC, [periodoContable] ASC)
);

