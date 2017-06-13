CREATE TABLE [dbo].[nPeriodoDetalle] (
    [empresa]       INT          NOT NULL,
    [año]           INT          NOT NULL,
    [mes]           INT          NOT NULL,
    [noPeriodo]     INT          NOT NULL,
    [fechaInicial]  DATE         NULL,
    [fechaFinal]    DATE         NULL,
    [fechaCorte]    DATE         NULL,
    [fechaPago]     DATETIME     NULL,
    [cerrado]       BIT          CONSTRAINT [DF_nPeriodoDetalle_cerrado] DEFAULT ((0)) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    [tipoNomina]    VARCHAR (50) NOT NULL,
    [diasNomina]    INT          NULL,
    [agronomico]    BIT          CONSTRAINT [DF_nPeriodoDetalle_agronomico] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_nPeriodoDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [noPeriodo] ASC)
);

