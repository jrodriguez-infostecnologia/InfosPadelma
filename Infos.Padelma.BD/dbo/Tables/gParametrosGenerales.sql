﻿CREATE TABLE [dbo].[gParametrosGenerales] (
    [empresa]           INT          NOT NULL,
    [entradas]          VARCHAR (50) NULL,
    [entradasAlt]       VARCHAR (50) NULL,
    [salidas]           VARCHAR (50) NULL,
    [salidasAlt]        VARCHAR (50) NULL,
    [pesajes]           VARCHAR (50) NULL,
    [pesajesAlt]        VARCHAR (50) NULL,
    [fruta]             VARCHAR (50) NULL,
    [frutaAlt]          VARCHAR (50) NULL,
    [almendra]          VARCHAR (50) NULL,
    [almedraAlt]        VARCHAR (50) NULL,
    [nuez]              VARCHAR (50) NULL,
    [nuezAlt]           VARCHAR (50) NULL,
    [crudo]             VARCHAR (50) NULL,
    [crudoAlt]          VARCHAR (50) NULL,
    [palmiste]          VARCHAR (50) NULL,
    [palmisteAlt]       VARCHAR (50) NULL,
    [blanqueado]        VARCHAR (50) NULL,
    [blanqueadoAlt]     VARCHAR (50) NULL,
    [cascarilla]        VARCHAR (50) NULL,
    [cascarillaAlt]     VARCHAR (50) NULL,
    [torta]             VARCHAR (50) NULL,
    [tortaAlt]          VARCHAR (50) NULL,
    [raquiz]            VARCHAR (50) NULL,
    [raquizAlt]         VARCHAR (50) NULL,
    [raquizPrensado]    VARCHAR (50) NULL,
    [raquizPrensadoAlt] VARCHAR (50) NULL,
    [fibra]             VARCHAR (50) NULL,
    [fibraAlt]          VARCHAR (50) NULL,
    [tiquete]           VARCHAR (50) NULL,
    [tiqueteAlt]        VARCHAR (50) NULL,
    [ordenEnvio]        VARCHAR (50) NULL,
    [ordenEnvioAlt]     VARCHAR (50) NULL,
    [remisionComer]     VARCHAR (50) NULL,
    [remisionComerAlt]  VARCHAR (50) NULL,
    [remisionInt]       VARCHAR (50) NULL,
    [remisionIntAlt]    VARCHAR (50) NULL,
    [ordenSalida]       VARCHAR (50) NULL,
    [ordenSalidaAlt]    VARCHAR (50) NULL,
    [anulado]           VARCHAR (50) NULL,
    [anuladoAlt]        VARCHAR (50) NULL,
    [frutaDura]         VARCHAR (50) NULL,
    [frutaDuraAlt]      VARCHAR (50) NULL,
    [frutaTenera]       VARCHAR (50) NULL,
    [frutaTeneraAlt]    VARCHAR (50) NULL,
    [agl]               VARCHAR (50) NULL,
    [aglAlt]            VARCHAR (50) NULL,
    [humedad]           VARCHAR (50) NULL,
    [humedadAlt]        VARCHAR (50) NULL,
    [impurezas]         VARCHAR (50) NULL,
    [impurezasAlt]      VARCHAR (50) NULL,
    CONSTRAINT [PK_gParametrosGenerales] PRIMARY KEY CLUSTERED ([empresa] ASC)
);

