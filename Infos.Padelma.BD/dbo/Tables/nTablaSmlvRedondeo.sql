CREATE TABLE [dbo].[nTablaSmlvRedondeo] (
    [año]            INT        NOT NULL,
    [dia]            FLOAT (53) NOT NULL,
    [IBC]            FLOAT (53) NULL,
    [pension]        FLOAT (53) NULL,
    [saludSena]      FLOAT (53) NULL,
    [salud]          FLOAT (53) NULL,
    [CCF]            FLOAT (53) NULL,
    [Riesgos_6,96%]  FLOAT (53) NULL,
    [Riesgos_4,35%]  FLOAT (53) NULL,
    [Riesgos_2,436%] FLOAT (53) NULL,
    [Riesgos_1,044%] FLOAT (53) NULL,
    [Riesgos_0,522%] FLOAT (53) NULL,
    [senaEspecial]   FLOAT (53) NULL,
    [sena]           FLOAT (53) NULL,
    [ICBF]           FLOAT (53) NULL,
    [ESAP]           FLOAT (53) NULL,
    [MEN]            FLOAT (53) NULL,
    CONSTRAINT [PK_nTablaSmlvRedondeo] PRIMARY KEY CLUSTERED ([año] ASC, [dia] ASC)
);

