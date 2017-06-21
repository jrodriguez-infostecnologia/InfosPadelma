﻿CREATE TABLE [dbo].[nConceptosFijos] (
    [empresa]           INT            NOT NULL,
    [centroCosto]       VARCHAR (50)   NOT NULL,
    [año]               INT            NOT NULL,
    [mes]               INT            NOT NULL,
    [noPeriodo]         INT            NOT NULL,
    [formaPago]         INT            NOT NULL,
    [liquidada]         BIT            NOT NULL,
    [acumulada]         BIT            NOT NULL,
    [observacion]       VARCHAR (2550) NOT NULL,
    [usuario]           VARCHAR (50)   NOT NULL,
    [fechaRegistro]     DATETIME       NOT NULL,
    [lNovedades]        BIT            CONSTRAINT [DF_nConceptosFijos_lNovedades] DEFAULT ((0)) NOT NULL,
    [lPresamo]          BIT            CONSTRAINT [DF_nConceptosFijos_lPresamo] DEFAULT ((0)) NOT NULL,
    [lHoras]            BIT            CONSTRAINT [DF_nConceptosFijos_lHoras] DEFAULT ((0)) NOT NULL,
    [lVacaciones]       BIT            CONSTRAINT [DF_nConceptosFijos_lVacaciones] DEFAULT ((0)) NOT NULL,
    [lPrimas]           BIT            CONSTRAINT [DF_nConceptosFijos_lPrimas] DEFAULT ((0)) NOT NULL,
    [lAusentismo]       BIT            CONSTRAINT [DF_nConceptosFijos_lAusentismo] DEFAULT ((0)) NOT NULL,
    [lEmbargo]          BIT            NOT NULL,
    [lOtros]            BIT            NOT NULL,
    [lNovedadesCredito] BIT            CONSTRAINT [DF_nConceptosFijos_lNovedadesCredito] DEFAULT ((0)) NOT NULL,
    [lFondavi]          BIT            CONSTRAINT [DF_nConceptosFijos_lFondavi] DEFAULT ((0)) NOT NULL,
    [lDomingo]          BIT            NULL,
    [lFestivo]          BIT            NULL,
    [lDomingoCero]      BIT            NULL,
    [mDomingo]          BIT            NULL,
    [lSindicato]        BIT            NULL,
    [lDomingoPromedio]  BIT            NULL,
    [lFestivoPromedio]  BIT            NULL,
    CONSTRAINT [PK_nConceptosFijos] PRIMARY KEY CLUSTERED ([empresa] ASC, [centroCosto] ASC, [año] ASC, [mes] ASC, [noPeriodo] ASC)
);



