﻿CREATE TABLE [dbo].[nSeguridadSocial] (
    [empresa]        INT          NOT NULL,
    [año]            INT          NOT NULL,
    [mes]            INT          NOT NULL,
    [registro]       INT          NOT NULL,
    [idTercero]      INT          NOT NULL,
    [codigoTercero]  VARCHAR (50) NOT NULL,
    [salario]        INT          NULL,
    [IBCsalud]       INT          NULL,
    [IBCpension]     INT          NULL,
    [IBCarp]         INT          NULL,
    [IBCcaja]        INT          NULL,
    [dSalud]         INT          NULL,
    [dPension]       INT          NULL,
    [dArp]           INT          NULL,
    [dCaja]          INT          NULL,
    [pSalud]         FLOAT (53)   NULL,
    [pPension]       FLOAT (53)   NULL,
    [pArp]           FLOAT (53)   NULL,
    [pCaja]          FLOAT (53)   NULL,
    [pFondo]         FLOAT (53)   NULL,
    [valorSalud]     INT          NULL,
    [valorPension]   INT          NULL,
    [valorFondo]     INT          NULL,
    [valorFondoSub]  INT          NULL,
    [valorArp]       INT          NULL,
    [valorCaja]      INT          NULL,
    [valorSena]      INT          NULL,
    [valorIcbf]      INT          NULL,
    [ING]            VARCHAR (1)  NULL,
    [RET]            VARCHAR (1)  NULL,
    [TDE]            VARCHAR (1)  NULL,
    [TAE]            VARCHAR (1)  NULL,
    [TDP]            VARCHAR (1)  NULL,
    [TAP]            VARCHAR (1)  NULL,
    [VSP]            VARCHAR (1)  NULL,
    [VTE]            VARCHAR (1)  NULL,
    [VST]            VARCHAR (1)  NULL,
    [SLN]            VARCHAR (1)  NULL,
    [IGE]            VARCHAR (1)  NULL,
    [LMA]            VARCHAR (1)  NULL,
    [VAC]            VARCHAR (1)  NULL,
    [AVP]            VARCHAR (1)  NULL,
    [VCT]            VARCHAR (1)  NULL,
    [IRP]            INT          NULL,
    [exoneraSalud]   VARCHAR (1)  NULL,
    [terceroSalud]   INT          NULL,
    [terceroPension] INT          NULL,
    [terceroCaja]    INT          NULL,
    [terceroArp]     INT          NULL,
    [terceroSena]    INT          NULL,
    [terceroIcbf]    INT          NULL,
    CONSTRAINT [PK_nSeguridadSocial] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [registro] ASC)
);
