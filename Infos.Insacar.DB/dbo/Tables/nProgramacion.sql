CREATE TABLE [dbo].[nProgramacion] (
    [empresa]       INT          NOT NULL,
    [fecha]         DATE         NOT NULL,
    [turno]         VARCHAR (50) NOT NULL,
    [funcionario]   VARCHAR (50) NOT NULL,
    [cuadrilla]     VARCHAR (50) NULL,
    [horaInicio]    INT          NOT NULL,
    [horaEntrada]   DATETIME     NULL,
    [horaSalida]    DATETIME     NULL,
    [horasTurno]    INT          NOT NULL,
    [horasExtras]   FLOAT (53)   NOT NULL,
    [estado]        CHAR (10)    NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_nProgramacion] PRIMARY KEY CLUSTERED ([empresa] ASC, [fecha] ASC, [turno] ASC, [funcionario] ASC)
);

