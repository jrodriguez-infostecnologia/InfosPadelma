CREATE TABLE [dbo].[tmpLiquidacionHoras] (
    [empresa]     INT          NULL,
    [fechaP]      DATE         NULL,
    [funcionario] VARCHAR (50) NULL,
    [hTurno]      FLOAT (53)   NULL,
    [nExtra]      FLOAT (53)   NULL,
    [horaEntrada] DATETIME     NULL,
    [horaSalida]  DATETIME     NULL,
    [HED]         FLOAT (53)   NULL,
    [HEN]         FLOAT (53)   NULL,
    [RN]          FLOAT (53)   NULL,
    [HD]          FLOAT (53)   NULL,
    [HEDD]        FLOAT (53)   NULL,
    [HEND]        FLOAT (53)   NULL,
    [RND]         FLOAT (53)   NULL,
    [HF]          FLOAT (53)   NULL,
    [HEDF]        FLOAT (53)   NULL,
    [HENF]        FLOAT (53)   NULL,
    [RNF]         FLOAT (53)   NULL,
    [HTL]         FLOAT (53)   NULL,
    [CodTurno]    VARCHAR (50) NULL,
    [cuadrilla]   VARCHAR (50) NULL
);

