﻿CREATE TABLE [dbo].[nSeguridadSocialPila] (
    [empresa]                       INT           NOT NULL,
    [año]                           INT           NOT NULL,
    [mes]                           INT           NOT NULL,
    [registro]                      INT           NOT NULL,
    [idTercero]                     INT           NOT NULL,
    [codigoTercero]                 VARCHAR (50)  NOT NULL,
    [apellido1]                     VARCHAR (250) NULL,
    [apellido2]                     VARCHAR (250) NULL,
    [nombre1]                       VARCHAR (250) NULL,
    [nombre2]                       VARCHAR (250) NULL,
    [departamento]                  VARCHAR (250) NULL,
    [ciudad]                        VARCHAR (250) NULL,
    [tipoCotizante]                 VARCHAR (50)  NULL,
    [subTipoCotizante]              VARCHAR (50)  NULL,
    [horasLaboradas]                INT           NULL,
    [extranjero]                    VARCHAR (1)   NULL,
    [RecidenteExterior]             VARCHAR (1)   NULL,
    [fechaRadExterior]              DATE          NULL,
    [ING]                           VARCHAR (1)   NULL,
    [fechaIngreso]                  DATE          NULL,
    [RET]                           VARCHAR (1)   NULL,
    [fechaRetiro]                   DATE          NULL,
    [TDE]                           VARCHAR (1)   NULL,
    [TAE]                           VARCHAR (1)   NULL,
    [TDP]                           VARCHAR (1)   NULL,
    [TAP]                           VARCHAR (1)   NULL,
    [VSP]                           VARCHAR (1)   NULL,
    [fechaVSP]                      DATE          NULL,
    [VST]                           VARCHAR (1)   NULL,
    [SLN]                           VARCHAR (1)   NULL,
    [fiSLN]                         DATE          NULL,
    [ffSLN]                         DATE          NULL,
    [IGE]                           VARCHAR (1)   NULL,
    [fiIGE]                         DATE          NULL,
    [ffIGE]                         DATE          NULL,
    [LMA]                           VARCHAR (1)   NULL,
    [fiLMA]                         DATE          NULL,
    [ffLMA]                         DATE          NULL,
    [VAC]                           VARCHAR (1)   NULL,
    [fiVAC]                         DATE          NULL,
    [ffVAC]                         DATE          NULL,
    [AVP]                           VARCHAR (1)   NULL,
    [VCT]                           VARCHAR (1)   NULL,
    [fiVCT]                         DATE          NULL,
    [ffVCT]                         DATE          NULL,
    [IRL]                           INT           NULL,
    [fiIRL]                         DATE          NULL,
    [ffIRL]                         DATE          NULL,
    [correciones]                   VARCHAR (1)   NULL,
    [salario]                       INT           NULL,
    [salarioIntegral]               VARCHAR (1)   NULL,
    [terceroPension]                INT           NULL,
    [dPension]                      INT           NULL,
    [IBCpension]                    INT           NULL,
    [pPension]                      FLOAT (53)    NULL,
    [valorPension]                  INT           NULL,
    [indicadorAltoRiesgo]           INT           NULL,
    [cotizacionVoluntariaAfiliado]  FLOAT (53)    NULL,
    [cotizacionVoluntariaEmpleador] FLOAT (53)    NULL,
    [valorFondo]                    FLOAT (53)    NULL,
    [valorFondoSub]                 FLOAT (53)    NULL,
    [pFondo]                        FLOAT (53)    NULL,
    [valorRetenido]                 FLOAT (53)    NULL,
    [totalPension]                  FLOAT (53)    NULL,
    [AFPdestino]                    VARCHAR (50)  NULL,
    [terceroSalud]                  INT           NULL,
    [dSalud]                        INT           NULL,
    [IBCsalud]                      INT           NULL,
    [pSalud]                        FLOAT (53)    NULL,
    [valorSalud]                    FLOAT (53)    NULL,
    [valorUPC]                      FLOAT (53)    NULL,
    [noAutorizacionEG]              VARCHAR (100) NULL,
    [valorIncapacidad]              FLOAT (53)    NULL,
    [noAutorizacionLMA]             VARCHAR (100) NULL,
    [valorLMA]                      FLOAT (53)    NULL,
    [saludDestino]                  NCHAR (10)    NULL,
    [terceroArl]                    INT           NULL,
    [dArl]                          INT           NULL,
    [IBCarl]                        INT           NULL,
    [pArl]                          FLOAT (53)    NULL,
    [claseARL]                      INT           NULL,
    [centroTrabajo]                 VARCHAR (50)  NULL,
    [valorArl]                      FLOAT (53)    NULL,
    [dCaja]                         INT           NULL,
    [terceroCaja]                   INT           NULL,
    [IBCcaja]                       INT           NULL,
    [pCaja]                         FLOAT (53)    NULL,
    [valorCaja]                     INT           NULL,
    [IBCCajaOtros]                  FLOAT (53)    NULL,
    [pSena]                         FLOAT (53)    NULL,
    [valorSena]                     INT           NULL,
    [terceroSena]                   INT           NULL,
    [pICBF]                         FLOAT (53)    NULL,
    [valorICBF]                     INT           NULL,
    [terceroIcbf]                   INT           NULL,
    [pESAP]                         FLOAT (53)    NULL,
    [valorESAP]                     FLOAT (53)    NULL,
    [pMEN]                          FLOAT (53)    NULL,
    [valorMEN]                      FLOAT (53)    NULL,
    [exoneraSalud]                  VARCHAR (1)   NULL,
    [tipoIDcotizanteUPC]            VARCHAR (50)  NULL,
    [noIDcotizanteUPC]              VARCHAR (50)  NULL,
    [contrato]                      INT           NULL,
    [tipoID]                        VARCHAR (50)  NULL,
    CONSTRAINT [PK_nSeguridadSocialPila] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [registro] ASC)
);

