CREATE TABLE [dbo].[logProgramacionGeneral] (
    [empresa]       INT          NOT NULL,
    [programacion]  VARCHAR (50) NOT NULL,
    [año]           INT          NOT NULL,
    [mes]           INT          NOT NULL,
    [producto]      VARCHAR (50) NOT NULL,
    [cantidad]      FLOAT (53)   NOT NULL,
    [mercado]       VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_logProgramacionGeneral] PRIMARY KEY CLUSTERED ([empresa] ASC, [programacion] ASC, [año] ASC, [mes] ASC, [producto] ASC)
);

