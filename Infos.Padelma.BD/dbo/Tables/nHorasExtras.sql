CREATE TABLE [dbo].[nHorasExtras] (
    [empresa]       INT          NOT NULL,
    [fecha]         DATE         NOT NULL,
    [turno]         VARCHAR (50) NOT NULL,
    [funcionario]   VARCHAR (50) NOT NULL,
    [cantidad]      INT          NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    CONSTRAINT [PK_nHorasExtras] PRIMARY KEY CLUSTERED ([empresa] ASC, [fecha] ASC, [turno] ASC, [funcionario] ASC)
);

