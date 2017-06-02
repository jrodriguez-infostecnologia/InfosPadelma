CREATE TABLE [dbo].[logDespacho] (
    [empresa]                  INT          NOT NULL,
    [tipo]                     VARCHAR (50) NOT NULL,
    [numero]                   VARCHAR (50) NOT NULL,
    [año]                      CHAR (6)     NOT NULL,
    [mes]                      NCHAR (10)   NOT NULL,
    [fecha]                    DATETIME     NOT NULL,
    [tiquete]                  VARCHAR (50) NOT NULL,
    [remision]                 VARCHAR (50) NOT NULL,
    [remisionComercializadora] VARCHAR (50) NOT NULL,
    [vehiculo]                 VARCHAR (50) NOT NULL,
    [remolque]                 VARCHAR (50) NOT NULL,
    [cantidad]                 FLOAT (53)   CONSTRAINT [DF_logDespacho_cantidad] DEFAULT ((0)) NOT NULL,
    [producto]                 VARCHAR (50) NOT NULL,
    [programacion]             VARCHAR (50) NOT NULL,
    [cliente]                  VARCHAR (50) NOT NULL,
    [lugarEntrega]             VARCHAR (50) NOT NULL,
    [comercializadora]         VARCHAR (50) NOT NULL,
    [planta]                   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_logDespacho] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC)
);

