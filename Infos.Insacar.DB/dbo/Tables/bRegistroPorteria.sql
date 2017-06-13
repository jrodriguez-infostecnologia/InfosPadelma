CREATE TABLE [dbo].[bRegistroPorteria] (
    [empresa]           INT           NOT NULL,
    [numero]            VARCHAR (50)  NOT NULL,
    [tipo]              VARCHAR (50)  NOT NULL,
    [remision]          VARCHAR (50)  NOT NULL,
    [fechaEntrada]      DATETIME      NOT NULL,
    [fechaSalida]       DATETIME      NOT NULL,
    [codigoConductor]   VARCHAR (50)  NOT NULL,
    [nombreConductor]   VARCHAR (250) NOT NULL,
    [estado]            CHAR (2)      NOT NULL,
    [fechaProgramacion] DATETIME      NOT NULL,
    [vehiculo]          VARCHAR (50)  NOT NULL,
    [remolque]          VARCHAR (50)  NOT NULL,
    [propio]            BIT           CONSTRAINT [DF_bRegistroPorteria_propio] DEFAULT ((0)) NOT NULL,
    [usuario]           VARCHAR (50)  NOT NULL,
    [fechaRegistro]     DATETIME      NOT NULL,
    CONSTRAINT [PK_bRegistroPorteria] PRIMARY KEY CLUSTERED ([empresa] ASC, [numero] ASC, [tipo] ASC),
    CONSTRAINT [FK_bRegistroPorteria_gTipoTransaccion] FOREIGN KEY ([empresa], [tipo]) REFERENCES [dbo].[gTipoTransaccion] ([empresa], [codigo])
);

