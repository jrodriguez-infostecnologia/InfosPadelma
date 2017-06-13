CREATE TABLE [dbo].[nFuncionario] (
    [empresa]           INT           NOT NULL,
    [tercero]           INT           NOT NULL,
    [sexo]              VARCHAR (1)   NOT NULL,
    [codigo]            VARCHAR (50)  NOT NULL,
    [proveedor]         VARCHAR (50)  NULL,
    [cliente]           VARCHAR (50)  NULL,
    [descripcion]       VARCHAR (950) NOT NULL,
    [rh]                VARCHAR (50)  NOT NULL,
    [fechaNacimiento]   DATE          NULL,
    [ciduadNacimiento]  VARCHAR (50)  NULL,
    [nivelEducativo]    VARCHAR (50)  NULL,
    [activo]            BIT           CONSTRAINT [DF_nFuncionario_activo] DEFAULT ((0)) NOT NULL,
    [validaTurno]       BIT           CONSTRAINT [DF_nFuncionario_validaTurno] DEFAULT ((0)) NOT NULL,
    [conductor]         BIT           CONSTRAINT [DF_nFuncionario_conductor] DEFAULT ((0)) NOT NULL,
    [operadorLogistico] BIT           CONSTRAINT [DF_nFuncionario_operadorLogistico] DEFAULT ((0)) NOT NULL,
    [extranjero]        BIT           CONSTRAINT [DF_nFuncionario_extranjero] DEFAULT ((0)) NOT NULL,
    [declarante]        BIT           CONSTRAINT [DF_nFuncionario_declarante] DEFAULT ((0)) NOT NULL,
    [contratista]       BIT           NULL,
    CONSTRAINT [PK_nFuncionario] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC),
    CONSTRAINT [FK_nFuncionario_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

