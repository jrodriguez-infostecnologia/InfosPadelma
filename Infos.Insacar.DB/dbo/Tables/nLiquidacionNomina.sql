CREATE TABLE [dbo].[nLiquidacionNomina] (
    [empresa]        INT           NOT NULL,
    [tipo]           VARCHAR (50)  NOT NULL,
    [numero]         VARCHAR (50)  NOT NULL,
    [año]            INT           NOT NULL,
    [mes]            INT           NOT NULL,
    [fecha]          DATETIME      NOT NULL,
    [fechaRegistro]  DATETIME      NOT NULL,
    [usuario]        VARCHAR (50)  NOT NULL,
    [anulado]        BIT           NOT NULL,
    [cerrado]        BIT           NOT NULL,
    [estado]         VARCHAR (5)   NOT NULL,
    [observacion]    VARCHAR (500) NOT NULL,
    [usuarioAnulado] VARCHAR (50)  NULL,
    [fechaAnulado]   DATETIME      NULL,
    CONSTRAINT [PK_nLiquidacionNomina] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [año] ASC, [mes] ASC)
);

