CREATE TABLE [dbo].[aTransaccionBascula] (
    [empresa]            INT           NOT NULL,
    [tipo]               VARCHAR (50)  NOT NULL,
    [numero]             VARCHAR (50)  NOT NULL,
    [empresaExtractora]  INT           NULL,
    [terceroExtractrora] INT           NOT NULL,
    [tiquete]            VARCHAR (50)  NOT NULL,
    [pesoBruto]          INT           NOT NULL,
    [pesoTara]           INT           NOT NULL,
    [pesoNeto]           INT           NOT NULL,
    [sacos]              INT           NOT NULL,
    [racimos]            INT           NOT NULL,
    [codigoConductor]    VARCHAR (50)  NOT NULL,
    [nombreConductor]    VARCHAR (550) NOT NULL,
    [vehiculo]           VARCHAR (50)  NOT NULL,
    [remolque]           VARCHAR (50)  NOT NULL,
    [fecha]              DATETIME      NOT NULL,
    [interno]            BIT           NOT NULL,
    CONSTRAINT [PK_aTransaccionBascula] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [terceroExtractrora] ASC)
);

