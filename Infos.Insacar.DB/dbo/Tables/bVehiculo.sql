CREATE TABLE [dbo].[bVehiculo] (
    [empresa]       INT           NOT NULL,
    [tipo]          NCHAR (10)    NOT NULL,
    [codigo]        VARCHAR (50)  NOT NULL,
    [descripcion]   VARCHAR (550) NOT NULL,
    [pesoTara]      INT           NOT NULL,
    [activo]        BIT           CONSTRAINT [DF_bVehiculo_activo] DEFAULT ((0)) NOT NULL,
    [usuario]       VARCHAR (50)  NOT NULL,
    [fechaRegistro] DATETIME      NOT NULL,
    CONSTRAINT [PK_bVehiculo] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [codigo] ASC)
);

