CREATE TABLE [dbo].[nProrroga] (
    [empresa]            INT            NOT NULL,
    [id]                 INT            NOT NULL,
    [contrato]           INT            NOT NULL,
    [tipo]               VARCHAR (1)    NOT NULL,
    [tercero]            INT            NOT NULL,
    [fechaInicial]       DATE           NOT NULL,
    [fechaFinal]         DATE           NOT NULL,
    [dias]               INT            NOT NULL,
    [fechaFinalAnterior] DATE           NOT NULL,
    [observacion]        VARCHAR (5550) NOT NULL,
    [fechaRegistro]      DATETIME       NOT NULL,
    [usuario]            VARCHAR (50)   NOT NULL,
    [motivoRetiro]       VARCHAR (50)   NULL,
    [retirado]           BIT            NULL,
    [fechaRetiro]        DATE           NULL,
    CONSTRAINT [PK_nProrroga] PRIMARY KEY CLUSTERED ([empresa] ASC, [id] ASC, [contrato] ASC, [tipo] ASC, [tercero] ASC)
);

