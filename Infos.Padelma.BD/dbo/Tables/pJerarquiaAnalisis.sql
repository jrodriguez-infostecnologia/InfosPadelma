CREATE TABLE [dbo].[pJerarquiaAnalisis] (
    [jerarquia]        INT            NOT NULL,
    [analisis]         VARCHAR (10)   NOT NULL,
    [empresa]          BIT            NOT NULL,
    [resultado]        BIT            NOT NULL,
    [formula]          VARCHAR (8000) NOT NULL,
    [prioridad]        INT            NOT NULL,
    [discreta]         BIT            NOT NULL,
    [campoResul]       BIT            NOT NULL,
    [expresion]        VARCHAR (8000) NULL,
    [resultadoParcial] BIT            CONSTRAINT [DF_pJerarquiaAnalisis_resultadoParcial] DEFAULT ((0)) NOT NULL,
    [resultadoFinal]   BIT            CONSTRAINT [DF_pJerarquiaAnalisis_resultadoFinal] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_pJerarquiaAnalisis] PRIMARY KEY CLUSTERED ([jerarquia] ASC, [analisis] ASC, [empresa] ASC)
);

